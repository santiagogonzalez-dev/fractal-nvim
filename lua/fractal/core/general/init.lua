require('fractal.core.general.autocmds')

-- Default tab size
vim.opt.shiftwidth = 2 -- Size of a > or < when indenting
vim.opt.tabstop = 4 -- Tab length

-- My own implementation of map
---@param tbl table
---@param func function
---@return table
map = function(tbl, func)
	local T = {}
	for k, v in pairs(tbl) do
		T[k] = func(k, v)
	end
	return T
end
