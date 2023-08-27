local M = {}

function M.hide_completely()
	local expr = vim.api.nvim_win_get_width(0)
	local sign = vim.opt.fillchars:get().horiz or "─"
	return vim.fn["repeat"](expr, sign)
end

function M.setup()
	vim.opt.statusline = '%{%v:lua.require("user.config.hidden-statusline").hide_completely()%}'
	vim.opt.laststatus = 0
	vim.opt.cmdheight = 0
	vim.opt.ruler = false
end

return M
