local utils = require("fractal.utils")
local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
}

local function lsp_keymaps(bufnr)
	vim.keymap.set("n", "<Leader>i", vim.lsp.buf.implementation, { buffer = bufnr })

	vim.keymap.set(
		{ "n", "v", "x" },
		"<Leader>ls",
		function() return vim.lsp.stop_client(vim.lsp.get_clients()) end,
		{ buffer = bufnr, desc = "Stop the LS" }
	)

	vim.keymap.set("n", "<Leader>r", vim.cmd.LspRestart, { desc = "Restart the LSP" })

	vim.keymap.set(
		{ "v", "x" },
		"<Leader>ca",
		":lua vim.lsp.buf.range_code_action()<CR>",
		{ buffer = bufnr, desc = "Range code actions" }
	)
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })

	-- Formatting
	vim.keymap.set("n", "<Leader><Leader>f", function()
		vim.cmd("mkview")
		vim.lsp.buf.format({ async = false })
		vim.cmd("loadview")
	end, { buffer = bufnr, desc = "Format the file" })

	vim.keymap.set(
		{ "v", "x" },
		"<Leader><Leader>f",
		function() vim.lsp.buf.range_formatting() end,
		{ buffer = bufnr, desc = "Range formatting the file" }
	)

	vim.api.nvim_create_user_command("Format", function()
		vim.cmd("mkview")
		vim.lsp.buf.format({ async = false })
		vim.cmd("loadview")
	end, {})

	-- Diagnostics
	vim.keymap.set(
		"n",
		"<Leader>d",
		vim.diagnostic.setqflist,
		{ buffer = bufnr, desc = "Show all diagnostics an a quickfix list" }
	)

	vim.keymap.set("n", "gl", function()
		if utils.not_interfere_on_float() then -- If there is not a floating window present
			-- Try to open diagnostics under the cursor
			local diags = vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
			if not diags then -- If there's no diagnostic under the cursor show diagnostics of the entire line
				vim.diagnostic.open_float()
			end
			return diags
		end
	end, { buffer = bufnr, desc = "Show diagnostics in a float window" })

	local diagnostics_active
	vim.keymap.set("n", "<Leader>ld", function()
		diagnostics_active = not diagnostics_active
		if diagnostics_active then
			return vim.diagnostic.hide()
		else
			return vim.diagnostic.show()
		end
	end, { buffer = bufnr, desc = "Toggle diagnostics" })

	vim.keymap.set("n", "gh", function() return utils.not_interfere_on_float() and vim.lsp.buf.hover() end, {
		buffer = bufnr,
		desc = "Show a description of the word under cursor",
	})

	vim.keymap.set("n", "<A-]>", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Go to next diagnostic" })
	vim.keymap.set("n", "<A-[>", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Go to previous diagnostic" })

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Definitions" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Declarations" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references) -- References

	vim.keymap.set("n", "r", vim.lsp.buf.rename)
end

M.on_attach = function(_, bufnr) lsp_keymaps(bufnr) end

function M.common_capabilities()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then return cmp_nvim_lsp.default_capabilities() end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	return capabilities
end

function M.config()
	local SERVERS = require("user.mason").servers
	local lspconfig = require("lspconfig")
	local icons = require("user.icons")

	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = false,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	for _, server in pairs(SERVERS) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = M.common_capabilities(),
		}

		local require_ok, settings = pcall(require, "user.lsp-settings." .. server)
		if require_ok then opts = vim.tbl_deep_extend("force", settings, opts) end

		lspconfig[server].setup(opts)
	end
end

return M
