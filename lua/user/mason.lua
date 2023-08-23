local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
	},
}

M.servers = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"marksman",
	"cssmodules_ls",
	"emmet_language_server",
	"astro",
	"svelte",
	"rust_analyzer",
}

function M.config()
	require("mason").setup({ ui = { border = "rounded" } })
	require("mason-lspconfig").setup({
		ensure_installed = M.servers,
	})
end

return M
