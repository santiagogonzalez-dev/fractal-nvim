vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

-- local on_attach = function(client, bufnr)
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- this buf_set_keymap() is not working correctly on startup
    -- running :source ~/.config/nvim/lua/main.lua makes the gd command work tho
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<Cr>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<Cr>', opts)
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', opts)
    -- buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<Cr>', opts)
    -- buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
    buf_set_keymap('n', '<Space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<Cr>', opts)
    buf_set_keymap('n', '<Space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<Cr>', opts)
    buf_set_keymap('n', '<Space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<Cr>', opts)
    buf_set_keymap('n', '<Space>D', '<Cmd>lua vim.lsp.buf.type_definition()<Cr>', opts)
    buf_set_keymap('n', '<Space>rn', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
    buf_set_keymap('n', '<Space>ca', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<Cr>', opts)
    -- buf_set_keymap('n', '<space>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<Cr>', opts)
    buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<Cr>', opts)
    buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<Cr>', opts)
    -- buf_set_keymap('n', '<space>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<Cr>', opts)
    buf_set_keymap('n', '<space>f', '<Cmd>lua vim.lsp.buf.formatting()<Cr>', opts)
end

-- local root_pattern = require('lspconfig/util').root_pattern
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 }, }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" }, }
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

-- Nvim LSP Installer
require('nvim-lsp-installer').on_server_ready(function(server)
    local opts = {}

    server:setup(opts)
end)

-- Python
require('lspconfig').pyright.setup{}

-- Bash
require('lspconfig').bashls.setup{
    filetypes = { "sh", "zsh", "bash" }
}

-- Javascript and Typescript
require('lspconfig').tsserver.setup{}
-- require('lspconfig').tsserver.setup{
--     root_dir = root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')
-- }

-- HTML
require('lspconfig').html.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'html' },
    init_options = {
        configurationSection = { 'html', 'css', 'javascript', 'typescript' },
        embeddedLanguages = {
            css = true,
            javascript = true,
            javascriptreact = true,
            typescript = true,
            typescriptreact = true,
        }
    },
    settings = {},
    single_file_support = true,
}

-- CSS
require('lspconfig').cssls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Json
require('lspconfig').jsonls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Lua
local sumneko_root_path = "/usr/bin/"
local sumneko_binary = sumneko_root_path .. 'lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. 'main.lua' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT', -- Tell the language server which version of Lua you're using
                path = runtime_path, -- Setup your lua path
            },
            diagnostics = {
                globals = { 'vim' }, -- Get the language server to recognize the `vim` global
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
            },
            telemetry = {
                enable = false, -- Do not send telemetry data containing a randomized but unique identifier
            },
        },
    },
}

require("csj.lsp.handlers").setup()
