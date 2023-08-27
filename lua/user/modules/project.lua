local M = {
	"ahmedkhalf/project.nvim",
	event = "VeryLazy",
	module = true,
}

function M.config()
	require("project_nvim").setup({
		active = true,
		on_config_done = nil,
		manual_mode = false,
		patterns = {
			".git",
			"_darcs",
			".hg",
			".bzr",
			".svn",
			"Makefile",
			"package.json",
			"pom.xml",
			".zshrc",
		},
		ignore_lsp = {},
		exclude_dirs = {},
		silent_chdir = true,
		scope_chdir = "global",
		detection_methods = { "lsp", "pattern" },
		show_hidden = true, -- Show hidden files in telescope when searching for files in a project
	})
end

return M
