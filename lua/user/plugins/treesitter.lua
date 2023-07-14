local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

-- Enable bundled treesitter parsers, this also turns off `syntax`.
-- https://github.com/neovim/neovim/issues/14090#issuecomment-1237820552
vim.g.ts_highlight_lua = true

treesitter.setup({
	ensure_installed = "all",
	auto_install = true,
	sync_install = false,
	highlight = {
		enable = true,
		aditional_vim_regex_highlighting = true,
		disable = {
			function(_, bufnr)
				local buf_name = vim.api.nvim_buf_get_name(bufnr)
				local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
				return file_size > 256 * 1024
			end,
			"latex",
		},
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	indent = {
		enable = true,
		disable = {
			"yaml",
			"python",
		},
	},
	autopairs = {
		enable = true,
	},
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
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				-- You can also use captures from other query groups like `locals.scm`
				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
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
			include_surrounding_whitespace = true,
		},
	},
})
