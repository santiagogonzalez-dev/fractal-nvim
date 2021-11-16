require('packer').startup({function(use)
	local opts = { noremap = true, silent = true }

	-- Packer
	use {
		'wbthomason/packer.nvim',
		vim.api.nvim_set_keymap('n', '<Leader>ps', ':PackerSync<Cr>', opts),
		vim.api.nvim_set_keymap('n', '<Leader>pc', ':PackerCompile<Cr>', opts),
	}

	-- use {
	-- 	'folke/tokyonight.nvim',
	-- }
	-- vim.g.tokyonight_style = 'storm'
	-- vim.g.tokyonight_italic_functions = true
	-- vim.g.tokyonight_italic_variables = true
	-- vim.g.tokyonight_dark_sidebar = true
	-- vim.g.tokyonight_transparent = true
	-- vim.cmd([[ colorscheme tokyonight ]])  -- Select colorscheme

	use{
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			-- Options (see available options below)
			vim.g.rose_pine_variant = 'base'
			-- vim.g.rose_pine_variant = 'moon'
			-- vim.g.rose_pine_variant = 'dawn'
		end,
	}
	-- Load colorscheme after options
	vim.cmd('colorscheme rose-pine')

	-- Icons
	use {
		'kyazdani42/nvim-web-devicons',
		module = 'nvim-web-devicons',
	}

	-- Comment
	use {
		'numToStr/Comment.nvim',
		after = 'nvim-treesitter',
		event = 'BufEnter',
		config = function()
			require('configs.comment')
		end,
	}

	-- Autopairs
	use {
		'windwp/nvim-autopairs',
		after = 'nvim-treesitter',
		config = function()
			require('configs.autopairs')
		end,
	}

	-- Autotags
	use {
		'windwp/nvim-ts-autotag',
		after = 'nvim-treesitter',
		event = 'InsertEnter',
	}

	-- Hop
	use {
		'phaazon/hop.nvim',
		event = 'VimEnter',
		config = function()
			require('hop').setup({
				keys = 'aoeusnthdiqjkzvwmbxlrcgp',
				term_seq_bias = 0.5,
				vim.cmd([[ highlight HopNextKey guifg=orange gui=nocombine ]]),
			})
		end,

		-- Keymappings
		vim.api.nvim_set_keymap('n', '<Leader>h', ':HopPattern<Cr>', opts)
	}

	-- Tabs Viewer
	use {
		'romgrk/barbar.nvim',
		event = 'BufEnter',
		config = function()
			require('configs.barbar')
		end,
	}

	-- Surround
	use {
		'tpope/vim-surround',
		event = 'VimEnter',
	}

	-- Terminal
	use {
		'akinsho/toggleterm.nvim',
		keys = { '<C-t>', '<Leader>r' },
		config = function()
			require('configs.toggleterm')
		end,
	}

	-- Stabilize
	use {
		'luukvbaal/stabilize.nvim',
		event = 'BufEnter',
		config = function()
			require('stabilize').setup()
		end,
	}

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		event = 'BufRead',
		config = function()
			require('configs.treesitter')
		end,
	}

	-- Nvim-tree
	use {
		'kyazdani42/nvim-tree.lua',
		event = 'BufEnter',
		config = function()
			require('configs.nvimtree')
		end,
	}

	-- Colorizer
	use {
		'norcalli/nvim-colorizer.lua',
		event = { 'CursorMoved', 'CursorHold' },
		config = function()
			require('colorizer').setup({ 'html', 'css', 'javascript', 'typescript', },
			{
				-- mode = 'foreground',
			})
			vim.cmd([[ ColorizerAttachToBuffer ]])
		end,
	}

	-- Plenary
	use {
		'nvim-lua/plenary.nvim',
	}

	-- Git Signs
	use {
		'lewis6991/gitsigns.nvim',
		event = 'VimEnter',
		requires = 'plenary.nvim',
		config = function()
			require('configs.gitcolumnsigns')
		end,
	}

	-- Indent Blankline
	use {
		'lukas-reineke/indent-blankline.nvim',
		after = 'nvim-treesitter',
		event = 'VimEnter',
		config = function()
			require('indent_blankline').setup({
				show_current_context = true,
				-- show_current_context_start = true,
				show_end_of_line = false,
				buftype_exclude = { 'terminal', 'nofile', 'NvimTree' },
				filetype_exclude = { 'help', 'packer', 'NvimTree' },
			})
			-- vim.g.indent_blankline_char = '' -- Only shows active indent line
			vim.g.indent_blankline_use_treesitter = true
			vim.g.indent_blankline_char_highlight = 'LineNr'
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_enabled = false
			vim.cmd([[ highlight IndentBlanklineContextChar guifg=orange gui=nocombine ]])
		end,

		-- Keymappings
		vim.api.nvim_set_keymap('n', '<Leader>i', ':IndentBlanklineToggle<Cr>', opts)
 	}

	-- Completion and lsp
	use {
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'neovim/nvim-lspconfig',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		event = 'BufWinEnter',
	}
end,
config = {
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end
	}
}})
