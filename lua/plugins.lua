require('packer').startup({function(use)
	local opts = { noremap = true, silent = true }

	-- Packer
	use {
		'wbthomason/packer.nvim',
		vim.api.nvim_set_keymap('n', '<Leader>ps', ':PackerSync<CR>', opts),
		vim.api.nvim_set_keymap('n', '<Leader>pc', ':PackerCompile<CR>', opts),
	}

	use {
		'folke/tokyonight.nvim',
	}

	-- ColorScheme
	vim.g.tokyonight_style='night'
	vim.cmd([[ colorscheme tokyonight ]])  -- Select colorscheme

	-- Icons
	use {
		'kyazdani42/nvim-web-devicons',
		module = 'nvim-web-devicons',
	}

	-- Comment
	use {
		'numToStr/Comment.nvim',
		event = 'BufEnter',
		config = function()
			require('configs.comment')
		end,
	}

	-- Autopairs
	use {
		'windwp/nvim-autopairs',
		after = 'nvim-treesitter',
		event = 'InsertEnter',
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
		as = 'hop',
		event = 'BufEnter',
		config = function()
			require('hop').setup({
				keys = 'aoeusnthdiqjkzvwmbxlrcgp',
				term_seq_bias = 0.5,
				vim.cmd([[highlight HopNextKey guifg=orange gui=nocombine]]),
			})
		end,
		-- Keymappings
		vim.api.nvim_set_keymap('n', '<Leader>h', ':HopPattern<CR>', opts)
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

	-- Treesitter textobjects
	use {
		'nvim-treesitter/nvim-treesitter-textobjects',
		after = 'nvim-treesitter',
		opt = true,
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
				mode = 'foreground',
			})
			vim.cmd([[ ColorizerAttachToBuffer ]])
		end,
	}

	-- Plenary
	use {
		'nvim-lua/plenary.nvim',
		event = 'BufEnter',
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
		event = 'VimEnter',
		config = function()
			require('indent_blankline').setup({
				show_current_context = true,
				show_end_of_line = false,
				space_char_blankline = ' ',
				buftype_exclude = { 'terminal', 'nofile', 'NvimTree' },
				filetype_exclude = { 'help', 'packer', 'NvimTree' },
			})
			-- vim.g.indent_blankline_char = ''
			vim.g.indent_blankline_char_highlight = 'LineNr'
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_use_treesitter = true
			vim.cmd([[highlight IndentBlanklineContextChar guifg=orange gui=nocombine]])
		end,
		-- Keymapping
		vim.api.nvim_set_keymap('n', '<Leader>i', ':IndentBlanklineToggle<CR>', opts)
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
		event = 'BufEnter',
	}
end,
config = {
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end
	}
}})
