vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

local root_pattern = require('lspconfig/util').root_pattern
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- CONFIGURE SERVERS

-- Python
require('lspconfig').pyright.setup{}

-- Bash
require('lspconfig').bashls.setup{}

-- Javascript and Typescript
require('lspconfig').denols.setup{
	cmd = { 'deno', 'lsp' },
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
	init_options = {
		enable = true,
		lint = false,
		unstable = false,
	},
	root_dir = root_pattern('deno.json', 'deno.jsonc', 'package.json', 'tsconfig.json', '.git', 'index.html'),
}

-- HTML
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').html.setup{
	cmd = { 'vscode-html-languageserver', '--stdio' },
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
	cmd = { 'vscode-css-languageserver', '--stdio' },
	capabilities = capabilities,
}

-- Lua
local sumneko_root_path = '/usr/bin' -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
	cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- LuaSnip
local luasnip = require('luasnip')


-- CMP
local cmp = require('cmp')
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-u>'] = cmp.mapping.scroll_docs(4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<Cr>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jumpable()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
	},
}

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
-- 	sources = {
-- 		{ name = 'buffer' }
-- 	}
-- })

-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
-- 	sources = cmp.config.sources({
-- 		{ name = 'path' },
-- 		{ name = 'cmdline'}
-- 	})
-- })

-- -- Show LSP error details
-- vim.cmd([[ autocmd CursorHold * lua vim.diagnostic.open_float(0, {scope="cursor"}) ]])
