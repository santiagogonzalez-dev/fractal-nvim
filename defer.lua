vim.loader.enable()

require("user.not")

vim.cmd.filetype("off")
vim.cmd.filetype("plugin indent off")
vim.cmd.syntax("off")
vim.opt.shadafile = "NONE"

vim.schedule(function()
	vim.opt.loadplugins = true

	if not vim.opt.loadplugins:get() then
		vim.cmd.runtime({ args = "plugin/**/*.lua", bang = true })
		vim.cmd.runtime({ args = "plugin/**/*.vim", bang = true })
	end

	-- Enable filetype settings and shadafile.
	vim.cmd.filetype("on")
	vim.cmd.filetype("plugin indent on")
	vim.cmd.syntax("on")
	vim.opt.shadafile = ""
	vim.cmd.rshada({ bang = true })

	dofile(vim.fn.stdpath("config") .. "/fractal/init.lua")
end)

vim.schedule_wrap(function()
	local buf_curr_path = vim.fn.expand("%F")
	if not require("fractal.utils").readable(buf_curr_path) then
		vim.api.nvim_exec_autocmds("BufNewFile", {}) -- Test tst
	else
		vim.cmd.filetype("detect")
	end

	vim.api.nvim_exec_autocmds("BufEnter", {})
	vim.api.nvim_exec_autocmds("UIEnter", {})
	vim.api.nvim_exec_autocmds("BufWinEnter", {})
end)()
