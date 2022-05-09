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

return M
