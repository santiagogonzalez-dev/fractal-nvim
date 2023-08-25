local M = {
	-- "santigo-zero/right-corner-diagnostics.nvim",
	dir = "/home/st/workspace/repos/right-corner-diagnostics.nvim",
	event = "LspAttach",
}

function M.config()
	-- Recommended:
	-- NOTE: Apply this settings before calling the `setup()`.
	vim.diagnostic.config({
		-- Disable default virtual text since you are using this plugin
		-- already :)
		virtual_text = false,

		-- Do not display diagnostics while you are in insert mode, so if you have
		-- `auto_cmds = true` it will not update the diagnostics while you type.
		update_in_insert = false,
	})

	-- Default config:
	require("rcd").setup({
		-- Where to render the diagnostics: top or bottom, the latter sitting at
		-- the bottom line of the buffer, not of the terminal.
		position = "bottom",

		-- In order to print the diagnostics we need to use autocommands, you can
		-- disable this behaviour and call the functions yourself if you think
		-- your autocmds work better than the default ones with this option:
		auto_cmds = true,
	})
end

return M
