local M = {}

-- Setup
M.setup = function()
    local signs = {
        { name = 'DiagnosticSignError', text = '' },
        { name = 'DiagnosticSignWarn', text = '' },
        { name = 'DiagnosticSignHint', text = '' },
        { name = 'DiagnosticSignInfo', text = '' },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    local config = {
        virtual_text = false, -- Toggle virtual text
        signs = { active = signs }, -- Show signs
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            border = 'rounded',
            style = 'minimal',
            format = function(diagnostic)
                return string.format(
                    '%s (%s) [%s]',
                    diagnostic.message,
                    diagnostic.source,
                    diagnostic.code or diagnostic.user_data.lsp.code
                )
            end,
        },
    }

    vim.diagnostic.config(config)
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { focusable = true, border = 'rounded' }
    )
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded ' }
    )
end

-- Highlight words matching the word under cursor
local function lsp_highlight_document(client)
    if client.resolved_capabilities.document_highlight then
        local highlight = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })

        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = 0,
            group = highlight,
            callback = function()
                vim.defer_fn(function()
                    vim.lsp.buf.document_highlight()
                end, 150)
            end,
        })

        vim.api.nvim_create_autocmd('CursorMoved', {
            buffer = 0,
            group = highlight,
            callback = vim.lsp.buf.clear_references,
        })

        local set_hl = require('csj.utils').set_hl
        set_hl({ 'LspReferenceText', 'LspReferenceRead', 'LspReferenceWrite' }, { link = 'PounceAcceptBest' })
    end
end

-- On attach
M.on_attach = function(client, _)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    require('csj.keymaps.lsp_keybinds') -- Keymaps
    lsp_highlight_document(client) -- Highlighting
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
    return
end

-- Update cmp capabilities
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local compl = capabilities.textDocument.completion.completionItem
compl.commitCharactersSupport = true
compl.deprecatedSupport = true
compl.insertReplaceSupport = true
compl.labelDetailsSupport = true
compl.preselectSupport = true
compl.resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits' } }
compl.tagSupport = { valueSet = { 1 } }

capabilities.textDocument.codeAction = {
    dynamicRegistration = false,
    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = {
                '',
                'quickfix',
                'refactor',
                'refactor.extract',
                'refactor.inline',
                'refactor.rewrite',
                'source',
                'source.organizeImports',
            },
        },
    },
}

local indentation_regex = vim.regex([[^\s\+]])

local highlight_groups = {
    [vim.diagnostic.severity.ERROR] = 'DiagnosticVirtualTextError',
    [vim.diagnostic.severity.WARN] = 'DiagnosticVirtualTextWarn',
    [vim.diagnostic.severity.INFO] = 'DiagnosticVirtualTextInfo',
    [vim.diagnostic.severity.HINT] = 'DiagnosticVirtualTextHint',
}

-- @param bufnr integer
-- @param lnum integer
local function get_indentation_for_line(bufnr, lnum)
    local lines = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)

    -- The line does not exist when a buffer is empty, though there may be
    -- additional situations. Fall back gracefully whenever this happens.
    if not vim.tbl_isempty(lines) then
        local istart, iend = indentation_regex:match_str(lines[1])

        if istart ~= nil then
            -- XXX: The docs say `tabstop` should be respected, but this doesn't seem
            -- to be happening (check this on go files).
            return string.sub(lines[1], istart, iend)
        end
    end

    return ''
end

-- Registers a wrapper-handler to render lsp lines.
-- This should usually only be called once, during initialisation.
M.register_lsp_virtual_lines = function()
    -- TODO: When a diagnostic changes for the current line, the cursor is not shifted properly.
    -- TODO: On LSP restart (e.g.: diagnostics cleared), errors don't go away.

    vim.diagnostic.handlers.virtual_lines = {
        show = function(namespace, bufnr, diagnostics, opts)
            vim.validate {
                namespace = { namespace, 'n' },
                bufnr = { bufnr, 'n' },
                diagnostics = {
                    diagnostics,
                    vim.tbl_islist,
                    'a list of diagnostics',
                },
                opts = { opts, 't', true },
            }

            local ns = vim.diagnostic.get_namespace(namespace)
            if not ns.user_data.virt_lines_ns then
                ns.user_data.virt_lines_ns = vim.api.nvim_create_namespace('')
            end
            local virt_lines_ns = ns.user_data.virt_lines_ns

            vim.api.nvim_buf_clear_namespace(bufnr, virt_lines_ns, 0, -1)

            local prefix = opts.virtual_lines.prefix or '▼'

            for id, diagnostic in ipairs(diagnostics) do
                local virt_lines = {}
                local lprefix = prefix
                local indentation = get_indentation_for_line(bufnr, diagnostic.lnum)

                -- Some diagnostics have multiple lines. Split those into multiple
                -- virtual lines, but only show the prefix for the first one.
                for diag_line in diagnostic.message:gmatch('([^\n]+)') do
                    table.insert(virt_lines, {
                        {
                            indentation,
                            '',
                        },
                        {
                            string.format('%s %s', lprefix, diag_line),
                            highlight_groups[diagnostic.severity],
                        },
                    })
                    lprefix = ' '
                end

                vim.api.nvim_buf_set_extmark(bufnr, virt_lines_ns, diagnostic.lnum, 0, {
                    id = id,
                    virt_lines = virt_lines,
                    virt_lines_above = true,
                })
            end
        end,
        hide = function(namespace, bufnr)
            local ns = vim.diagnostic.get_namespace(namespace)
            if ns.user_data.virt_lines_ns then
                vim.api.nvim_buf_clear_namespace(bufnr, ns.user_data.virt_lines_ns, 0, -1)
            end
        end,
    }
end

M.register_lsp_virtual_lines()

return M
