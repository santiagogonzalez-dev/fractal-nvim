local M = {
	dir = "~/workspace/repos/jetjbp.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = "jetjbp"
function M.config() return end

return M
