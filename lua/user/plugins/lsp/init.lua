local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return -- Return if there is any problem with lspconfig
end

local SERVERS = {
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	"html",
	"lua_ls",
	"svelte",
	"tsserver",
	"marksman",
}

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = SERVERS,
	automatic_installation = false,
})

for _, server in pairs(SERVERS) do
	server = vim.split(server, "@")[1]

	local opts = {
		on_attach = require("user.plugins.lsp.handlers").on_attach,
		capabilities = require("user.plugins.lsp.handlers").capabilities,
	}

	if server ~= "jdtls" then
		local has_opts, custom_opts = pcall(require, string.format("%s.%s", "user.plugins.lsp.settings", server))
		if has_opts then opts = vim.tbl_deep_extend("force", custom_opts, opts) end

		lspconfig[server].setup(opts)
	end
end

require("user.plugins.lsp.handlers").setup()
require("user.plugins.lsp.inlay-hint")
