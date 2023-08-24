local M = {
	"ThePrimeagen/harpoon",
}

function M.config()
	vim.keymap.set("n", "<Leader>h", require("harpoon.mark").add_file)
	vim.keymap.set("n", "<Leader>ho", require("harpoon.ui").toggle_quick_menu)

	-- Because I use dvorak
	vim.keymap.set("n", "<C-h>", function() require("harpoon.ui").nav_file(1) end)
	vim.keymap.set("n", "<C-t>", function() require("harpoon.ui").nav_file(2) end)
	vim.keymap.set("n", "<C-n>", function() require("harpoon.ui").nav_file(3) end)
	vim.keymap.set("n", "<C-s>", function() require("harpoon.ui").nav_file(4) end)

	require("harpoon").setup({
		menu = {
			width = math.floor(vim.api.nvim_win_get_width(0) / 1.5),
		},
	})
end

return M
