
-- -- Python
-- require('lspconfig').pyright.setup{}

-- -- Bash
-- require('lspconfig').bashls.setup{}

-- -- Javascript and Typescript
-- require('lspconfig').denols.setup{
-- 	cmd = { 'deno', 'lsp' },
--     filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
-- 	init_options = {
-- 		enable = true,
-- 		lint = false,
-- 		unstable = false,
-- 	},
-- 	root_dir = root_pattern('deno.json', 'deno.jsonc', 'package.json', 'tsconfig.json', '.git', 'index.html'),
-- }

-- -- HTML
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- require('lspconfig').html.setup{
-- 	-- cmd = { 'vscode-html-languageserver', '--stdio' },
-- 	capabilities = capabilities,
-- 	filetypes = { 'html' },
-- 	init_options = {
-- 		configurationSection = { 'html', 'css', 'javascript', 'typescript' },
-- 		embeddedLanguages = {
-- 			css = true,
-- 			javascript = true,
-- 			javascriptreact = true,
-- 			typescript = true,
-- 			typescriptreact = true,
-- 		}
-- 	},
-- 	settings = {},
-- 	single_file_support = true,
-- }

-- -- CSS
-- require('lspconfig').cssls.setup{
-- 	cmd = { 'vscode-css-languageserver', '--stdio' },
-- 	capabilities = capabilities,
-- }

-- -- Lua
-- local sumneko_root_path = os.getenv("HOME") .. '/.services/lua/' -- Change to your sumneko root installation
-- -- local sumneko_binary = sumneko_root_path .. 'lua-language-server'

-- -- -- Make runtime files discoverable to the server
-- -- local runtime_path = vim.split(package.path, ';')
-- -- table.insert(runtime_path, 'lua/?.lua')
-- -- table.insert(runtime_path, 'lua/?/init.lua')

-- require('lspconfig').sumneko_lua.setup {
-- 	cmd = { sumneko_root_path .. 'lua-language-server', '-E', sumneko_root_path .. 'main.lua' },
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using
-- 				version = 'LuaJIT',
-- 				-- Setup your lua path
-- 				path = runtime_path,
-- 			},
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = { 'vim' },
-- 			},
-- 			workspace = {
-- 				-- Make the server aware of Neovim runtime files
-- 				library = vim.api.nvim_get_runtime_file('', true),
-- 			},
-- 			-- Do not send telemetry data containing a randomized but unique identifier
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- }

