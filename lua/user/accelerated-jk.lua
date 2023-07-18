local M = {
	"rainbowhxch/accelerated-jk.nvim",
	keys = {
		"j",
		"k",
		"<C-e>",
		"<C-y>",
		"w",
		"b",
		"+",
		"-",
	},
}

function M.config()
	require("accelerated-jk").setup({
		-- enable_deceleration = true,
		acceleration_motions = { "w", "b", "+", "-" },
	})
	vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_j)", {})
	vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_k)", {})
end

return M
