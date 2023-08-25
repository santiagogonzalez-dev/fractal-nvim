local M = {
	dir = "~/workspace/repos/jetjbp.nvim",
	priority = 1000,
}

function M.config()
	vim.cmd.colorscheme(vim.g.colorscheme)
end

return M
