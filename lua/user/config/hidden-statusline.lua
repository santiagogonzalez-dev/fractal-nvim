local function hide_completely()
	local expr = vim.api.nvim_win_get_width(0)
	local sign = vim.opt.fillchars:get().horiz or "─"
	return vim.fn["repeat"](expr, sign)
end

vim.opt.statusline = '%{%v:lua.require("user.config.hidden-statusline").hide_completely()%}'
vim.opt.laststatus = 0
vim.opt.ruler = false
