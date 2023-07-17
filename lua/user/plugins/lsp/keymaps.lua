local M = {}
local utils = require("fractal.utils")

function M.keymaps(bufnr)
	vim.keymap.set(
		{ "n", "v", "x" },
		"<Leader>ls",
		function() return vim.lsp.stop_client(vim.lsp.get_active_clients()) end,
		{ buffer = bufnr, desc = "Stop the LS" }
	)

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

	vim.keymap.set("n", "gll", function()
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

	vim.keymap.set("n", "gl", function() return utils.not_interfere_on_float() and vim.lsp.buf.hover() end, {
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

return M
