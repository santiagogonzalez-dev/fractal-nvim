require('nvim-treesitter.configs').setup({

	ensure_installed = {'lua', 'python', 'java', 'bash', 'javascript', 'html'},

	-- ensure_installed = 'maintained',

	highlight = {
		enable = true,
		aditional_vim_regex_highlighting = true,
		disable = { 'latex' },
	},

	context_commentstring = {
		enable = true,
		config = { css = '// %s' },
	},

	indent = {
		enable = true,
		-- disable = { 'python' },
	},

	textsubjects = {
		enable = true,
		keymaps = {
			[','] = 'textsubjects-smart',
		},
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
		},
		move = {
			enable = true,
			set_jumps = true, -- Whether to set jumps in the jumplist
		}
	},

	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = true },
	},

	autopairs = {
		enable = true,
	},

	autotag = {
		enable = true,
		filetypes = {
			'html',
			'javascript',
			'javascriptreact',
			'typescript',
			'typescriptreact',
			'svelte',
			'vue',
			'markdown',
		},
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'gnn',
			node_incremental = 'gnn',
			scope_incremental = 'gns',
			node_decremental = 'gnp',
		},
	},

	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { 'BufWrite', 'CursorHold', 'CursorHold' },
	},

	playground = {
		enable = true,
		updatetime = 25,
		persist_queries = false,
		keybindings = {
			toggel_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<CR>',
			show_help = '?',
		}
	},
})
