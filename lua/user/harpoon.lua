local M = {
	"ThePrimeagen/harpoon",
}

function M.config()
	vim.keymap.set("n", "<Leader>h", require("harpoon.mark").add_file)
	vim.keymap.set("n", "<Leader>ho", require("harpoon.ui").toggle_quick_menu)

	vim.keymap.set("n", "<Leader>hh", function() require("harpoon.ui").nav_file(1) end)
	vim.keymap.set("n", "<Leader>ht", function() require("harpoon.ui").nav_file(2) end)
	vim.keymap.set("n", "<Leader>hn", function() require("harpoon.ui").nav_file(3) end)
	vim.keymap.set("n", "<Leader>hs", function() require("harpoon.ui").nav_file(4) end)
end

return M
