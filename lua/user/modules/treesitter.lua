local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
		},
		{
			"RRethy/nvim-treesitter-textsubjects",
			event = "VeryLazy",
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "VeryLazy",
		},
		{
			"nvim-treesitter/playground",
			cmd = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" },
			keys = "<Leader>tsh",
			config = function()
				require("nvim-treesitter.configs").setup({
					playground = {
						enable = true,
						disable = {},
						updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
						persist_queries = false, -- Whether the query persists across vim sessions
						keybindings = {
							toggle_query_editor = "o",
							toggle_hl_groups = "i",
							toggle_injected_languages = "t",
							toggle_anonymous_nodes = "a",
							toggle_language_display = "I",
							focus_language = "f",
							unfocus_language = "F",
							update = "R",
							goto_node = "<cr>",
							show_help = "?",
						},
					},
				})
				vim.keymap.set("n", "<Leader>tsh", ":TSHighlightCapturesUnderCursor<CR>")
			end,
		},
	},
}

function M.config()
	local config = require("nvim-treesitter.configs")

	-- Enable bundled treesitter parsers, this also turns off `syntax`.
	-- https://github.com/neovim/neovim/issues/14090#issuecomment-1237820552
	vim.g.ts_highlight_lua = true

	config.setup({
		ensure_installed = "all",
		auto_install = true,
		sync_install = false,
		highlight = {
			enable = true,
			aditional_vim_regex_highlighting = false,
			disable = {
				function(_, bufnr)
					local buf_name = vim.api.nvim_buf_get_name(bufnr)
					local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
					return file_size > 256 * 1024
				end,
				"latex",
			},
		},
		context_commentstring = { enable = true, enable_autocmd = false },
		indent = { enable = true, disable = { "yaml", "python" } },
		autopairs = { enable = true },
		autotag = {
			enable = true,
			filetypes = {
				"css",
				"html",
				"javascript",
				"javascriptreact",
				"markdown",
				"svelte",
				"typescript",
				"typescriptreact",
				"vue",
				"xhtml",
				"xml",
			},
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn", -- Start the selection by nodes
				node_incremental = "gnn", -- Increment to the node with higher order
				node_decremental = "gnp", -- Decrement to the node with lower order
				scope_incremental = "gns", -- Select the entire group  of nodes including the braces
			},
		},
		textsubjects = {
			enable = true,
			prev_selection = ",", -- (Optional) keymap to select the previous selection
			keymaps = {
				["."] = "textsubjects-smart",
				[";"] = "textsubjects-container-outer",
				["i;"] = "textsubjects-container-inner",
			},
		},
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					-- You can optionally set descriptions to the mappings (used in the desc parameter of
					-- nvim_buf_set_keymap) which plugins like which-key display
					["ic"] = {
						query = "@class.inner",
						desc = "Select inner part of a class region",
					},
					-- You can also use captures from other query groups like `locals.scm`
					["as"] = {
						query = "@scope",
						query_group = "locals",
						desc = "Select language scope",
					},
				},
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`.
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * selection_mode: eg 'v'
				-- and should return true of false
				-- include_surrounding_whitespace = true,
			},
		},
	})
end

return M
