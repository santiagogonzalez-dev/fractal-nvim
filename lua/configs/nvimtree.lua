vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1

require('nvim-tree').setup({
	view = {
		side = 'right',
		width = 33,
		auto_resize = true,
	},
	auto_open = true,
	auto_close = true,
	follow = true,
	disable_netrw = true,
	open_on_setup = true,
	open_on_tab = true,
	-- update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	show_icons = {
		git = true,
		folders = true,
		files = true,
		folder_arrows = true,
		tree_width = 33,
	},
	gitignore = true,
	ignore = { ".git", "node_modules", ".cache" },
	quit_on_open = true,
	hide_dotfiles = false,
	git_hl = true,
	root_folder_modifier = ":t",
	allow_resize = true,
	icons = {
		default = " ",
		symlink = " ",
		git = {
			unstaged = " ",
			staged = "S ",
			unmerged = " ",
			renamed = "➜ ",
			deleted = " ",
			untracked = "U ",
			ignored = "◌ ",
		},
		folder = {
			default = " ",
			open = " ",
			empty = " ",
			empty_open = " ",
			symlink = " ",
		},
	},
})

require('nvim-tree.events').on_nvim_tree_ready(function()
	vim.cmd 'NvimTreeRefresh'
end)

-- Keymappings
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
