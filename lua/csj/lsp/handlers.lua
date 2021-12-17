local M = {}

-- Setup
M.setup = function()
    local signs = {
        { name = 'DiagnosticSignError', text = '' }, -- ''
        { name = 'DiagnosticSignWarn',  text = '' }, -- ''
        { name = 'DiagnosticSignHint',  text = '' }, -- ''
        { name = 'DiagnosticSignInfo',  text = '' }, -- ''
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    local config = {
        virtual_text = false, -- Toggle virtual text
        signs = { active = signs, }, -- Show signs
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded', })
end

-- Highlight words matching the word under cursor
local function lsp_highlight_document(client)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
end

-- Keymaps
local function lsp_keymaps(bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local nore_sil = { noremap = true, silent = true }

    buf_set_keymap('n',     '<Leader>D',    '<Cmd>lua vim.lsp.buf.type_definition()<Cr>', nore_sil)
    buf_set_keymap('n',     '<Leader>ca',   '<Cmd>lua vim.lsp.buf.code_action()<Cr>', nore_sil)
    buf_set_keymap('n',     '<Leader>f',    '<Cmd>lua vim.lsp.buf.formatting()<Cr>', nore_sil)
    buf_set_keymap('n',     '<Leader>q',    '<Cmd>lua vim.diagnostic.setloclist()<Cr>', nore_sil)
    buf_set_keymap('n',     '<Leader>rn',   '<Cmd>lua vim.lsp.buf.rename()<Cr>', nore_sil)
    buf_set_keymap('n',     '<Leader>wa',   '<Cmd>lua vim.lsp.buf.add_workspace_folder()<Cr>', nore_sil)
    buf_set_keymap('n',     '<Leader>wl',   '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<Cr>', nore_sil)
    buf_set_keymap('n',     '<Leader>wr',   '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<Cr>', nore_sil)
    buf_set_keymap('n',     '[d',           '<Cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<Cr>', nore_sil)
    buf_set_keymap('n',     ']d',           '<Cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<Cr>', nore_sil)
    buf_set_keymap('n',     'gD',           '<Cmd>lua vim.lsp.buf.declaration()<Cr>', nore_sil)
    buf_set_keymap('n',     'gd',           '<Cmd>lua vim.lsp.buf.definition()<Cr>', nore_sil)
    buf_set_keymap('n',     'gl',           '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<Cr>', nore_sil)
    buf_set_keymap('n',     'gr',           '<Cmd>lua vim.lsp.buf.references()<Cr>', nore_sil)

    -- buf_set_keymap('n',     '<C-k>',        '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', nore_sil)
    -- buf_set_keymap('n',     '<C-k>',        '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', nore_sil)
    -- buf_set_keymap('n',     '<Space>e',     '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<Cr>', nore_sil)
    -- buf_set_keymap('n',     '<Space>q',     '<Cmd>lua vim.lsp.diagnostic.set_loclist()<Cr>', nore_sil)
    -- buf_set_keymap('n',     '<leader>ca',   '<Cmd>lua vim.lsp.buf.code_action()<Cr>', nore_sil)
    -- buf_set_keymap('n',     '<leader>f',    '<Cmd>lua vim.diagnostic.open_float()<Cr>', nore_sil)
    -- buf_set_keymap('n',     '<leader>rn',   '<Cmd>lua vim.lsp.buf.rename()<Cr>', nore_sil)
    -- buf_set_keymap('n',     'K',            '<Cmd>lua vim.lsp.buf.hover()<Cr>', nore_sil)
    -- buf_set_keymap('n',     'K',            '<Cmd>lua vim.lsp.buf.hover()<Cr>', nore_sil)
    -- buf_set_keymap('n',     'gi',           '<Cmd>lua vim.lsp.buf.implementation()<Cr>', nore_sil)
    -- buf_set_keymap('n',     'gi',           '<Cmd>lua vim.lsp.buf.implementation()<Cr>', nore_sil)

    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- On attach
M.on_attach = function(client, bufnr)
    -- tsserver
    if client.name == 'tsserver' then
        client.resolved_capabilities.document_formatting = false
    end

    -- jdtls
    if client.name == 'jdtls' then
        client.resolved_capabilities.document_formatting = false
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end

    -- Keymaps
    lsp_keymaps(bufnr)

    -- Highlighting
    lsp_highlight_document(client)
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
  return
end

-- Update cmp capabilities
M.capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Features
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits' }, }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 }, }
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
