require("fractal.core.not")

vim.loader.enable()

vim.cmd.filetype("off")
vim.cmd.filetype("plugin indent off")
vim.cmd.syntax("off")
vim.opt.shadafile = "NONE"

vim.schedule(function()
	vim.opt.loadplugins = true

	if not vim.opt.loadplugins:get() then
		vim.cmd.runtime("plugin/**/*.lua", { bang = true })
		vim.cmd.runtime("plugin/**/*.vim", { bang = true })
	end

	-- Enable filetype settings and shadafile.
	vim.cmd.filetype("on")
	vim.cmd.filetype("plugin indent on")
	vim.cmd.syntax("on")
	vim.opt.shadafile = ""
	vim.cmd.rshada({ bang = true })

	local buf_curr_path = vim.fn.expand("%F")
	if not require("fractal.utils").readable(buf_curr_path) then
		vim.defer_fn(function() vim.api.nvim_exec_autocmds("BufNewFile", {}) end, 0)
	else
		vim.defer_fn(function() vim.cmd.filetype("detect") end, 0) -- Manual ftplugin
	end

	vim.defer_fn(function()
		vim.api.nvim_exec_autocmds("BufEnter", {})
		vim.api.nvim_exec_autocmds("UIEnter", {})
	end, 0)

	require("fractal.core")
end)
