local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			lazy = true,
		},
	},
	lazy = true,
	cmd = "Telescope",
	keys = {
		"<Leader>gr",
		"<Leader>t/",
		"<Leader>t//",
		"<Leader>tf",
		"<Leader>tg",
		"<Leader>tp",
		"<Leader>tt",
	},
}

function M.config()
	local icons = require("user.icons")
	local actions = require("telescope.actions")
	local telescope = require("telescope")
	local previewers_utils = require("telescope.previewers.utils")

	telescope.setup({
		defaults = {
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. " ",
			-- prompt_prefix = " ",
			-- selection_caret = " ",
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			path_display = { "smart" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" },
			sorting_strategy = nil,
			layout_strategy = nil,
			layout_config = {},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--column",
				"--glob=!.git/",
				"--hidden",
				"--line-number",
				"--no-heading",
				"--smart-case",
				"--with-filename",
				"--trim",
				"--vimgrep",
			},
			preview = {
				filesize_hook = function(filepath, bufnr, opts)
					-- If the file is very big only print the head of the it
					local cmd = { "head", "-c", 1000000, filepath }
					previewers_utils.job_maker(cmd, bufnr, opts)
				end,
			},
			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
				n = {
					["<esc>"] = actions.close,
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["q"] = actions.close,
				},
			},
		},
		pickers = {
			live_grep = {
				theme = "dropdown",
			},

			grep_string = {
				theme = "dropdown",
			},

			find_files = {
				theme = "dropdown",
				previewer = false,
			},

			buffers = {
				theme = "dropdown",
				previewer = false,
				initial_mode = "normal",
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
					},
				},
			},

			planets = {
				show_pluto = true,
				show_moon = true,
			},

			colorscheme = {
				enable_preview = true,
			},

			lsp_references = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_definitions = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_declarations = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_implementations = {
				theme = "dropdown",
				initial_mode = "normal",
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})

	vim.keymap.set("n", "<Leader>gr", "<CMD>Telescope lsp_references theme=dropdown<CR>")
	vim.keymap.set("n", "<Leader>tf", "<CMD>Telescope find_files<CR>")
	-- vim.keymap.set("n", "<Leader>t/", "<CMD>Telescope live_grep theme=dropdown<CR>")
	-- vim.keymap.set("n", "<Leader>t//", "<CMD>Telescope current_buffer_fuzzy_find theme=dropdown<CR>")
	vim.keymap.set("n", "<Leader>tg", "<CMD>Telescope grep_string<CR>")
	vim.keymap.set("n", "<Leader>tt", "<CMD>Telescope<CR>")
end

return M
