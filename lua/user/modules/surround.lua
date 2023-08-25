local M = {
	"kylechui/nvim-surround",
	event = "User FractalEnd",
}

function M.config()
	require("nvim-surround").setup()
end

return M
