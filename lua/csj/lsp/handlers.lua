local M = {}
local utils = require('csj.utils')

local lsp_settings = vim.api.nvim_create_augroup('_lsp_settings', {})

-- function M.goto_definition(split_cmd)
--     local handler = function(_, result, ctx)
--         if result == nil or vim.tbl_isempty(result) then
--             local _ = vim.lsp.log.info() and vim.lsp.log.info(ctx.method, 'No location found')
--             return nil
--         end

--         if split_cmd then
--             vim.cmd(split_cmd) -- 'split' or 'vsplit'
--         end

--         if vim.tbl_islist(result) then
--             vim.lsp.util.jump_to_location(result[1])

--             if #result > 1 then
--                 vim.lsp.util.set_qflist(vim.lsp.util.locations_to_items(result))
--                 vim.api.nvim_command('copen')
--                 vim.api.nvim_command('wincmd p')
--             end
--         else
--             vim.lsp.util.jump_to_location(result)
--         end
--     end

--     return handler
-- end

M.setup = function()
    -- Setup
    local signs = {
        { name = 'DiagnosticSignError', text = ' ', texthl = 'DiagnosticSignError' },
        { name = 'DiagnosticSignWarn', text = ' ', texthl = 'DiagnosticSignWarn' },
        { name = 'DiagnosticSignHint', text = ' ', texthl = 'DiagnosticSignInfo' },
        { name = 'DiagnosticSignInfo', text = ' ', texthl = 'DiagnosticSignHint' },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
    end

    vim.diagnostic.config {
        virtual_text = false, -- Toggle virtual text
        signs = { active = signs }, -- Show signs
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            border = 'rounded',
            style = 'minimal',
            source = 'if_many',
            format = function(diagnostic)
                return string.format('%s (%s) [%s]', diagnostic.message, diagnostic.source, diagnostic.code or diagnostic.user_data.lsp.code)
            end,
        },
    }

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = true, border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded ' })

    -- vim.lsp.handlers['textDocument/definition'] = M.goto_definition('vsplit') -- TODO open split only on keybinding
end

function M.lsp_highlight_document(client)
    -- Highlight words matching the word under cursor
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = 0,
            group = lsp_settings,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = 0,
            group = lsp_settings,
            callback = vim.lsp.buf.clear_references,
        })

        local set_hl = require('csj.utils').set_hl
        set_hl({ 'LspReferenceText', 'LspReferenceRead', 'LspReferenceWrite' }, { link = 'LspDocumentHighlight' })
    end
end

function M.on_attach(client, _)
    -- On attach

    -- -- Do not let language servers format code
    -- client.resolved_capabilities.document_formatting = false
    -- client.resolved_capabilities.document_range_formatting = false

    require('csj.keymaps.lsp_keybinds') -- Keymaps
    M.lsp_highlight_document(client) -- Highlighting
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

local highlight_groups = {
    [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
    [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
    [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
    [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
}

function M.print_diagnostics(opts, bufnr, line_nr)
    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    opts = opts or { ['lnum'] = line_nr }

    local namespace = vim.api.nvim_create_namespace('trld')
    local ns = vim.diagnostic.get_namespace(namespace)

    local line_diagnostics = vim.diagnostic.get(bufnr, opts)

    if vim.tbl_isempty(line_diagnostics) then
        if ns.user_data.diags then
            vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
        end
        return
    end

    if ns.user_data.last_line_nr == line_nr and ns.user_data.diags then
        return
    end

    ns.user_data.diags = true
    ns.user_data.last_line_nr = line_nr

    local win_info = vim.fn.getwininfo(vim.fn.win_getid())[1]

    for i, diagnostic in ipairs(line_diagnostics) do
        local diag_lines = {}

        for line in diagnostic.message:gmatch('[^\n]+') do
            table.insert(diag_lines, line)
        end
        for j, dline in ipairs(diag_lines) do
            local x = (win_info.topline - 3) + (i + j)
            if win_info.botline <= x - 1 then
                return
            end
            vim.api.nvim_buf_set_extmark(bufnr, namespace, x, 0, {
                virt_text = { { dline, highlight_groups[diagnostic.severity] } },
                virt_text_pos = 'right_align',
                virt_lines_above = true,
            })
        end
    end
end

function M.hide_diagnostics(bufnr)
    bufnr = bufnr or 0
    local namespace = vim.api.nvim_get_namespaces()['trld']
    if namespace == nil then
        return
    end
    local ns = vim.diagnostic.get_namespace(namespace)
    if ns.user_data.diags then
        vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
    end
    ns.user_data.diags = false
end

function M.setup_diagnostics()
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        desc = 'Print the lsp diagnostics at the top right of the screen',
        group = lsp_settings,
        callback = function()
            return M.print_diagnostics()
        end,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        desc = 'Clean the lsp messages from the top right of the screen',
        group = lsp_settings,
        callback = function()
            return M.hide_diagnostics()
        end,
    })
end

return M
