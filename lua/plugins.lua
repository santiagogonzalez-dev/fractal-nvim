return require('packer').startup(function()

	-- Packer
	use {
		'wbthomason/packer.nvim',
		disable = false,
	}

	-- Comments
	use {
		'terrortylor/nvim-comment',
		keys = {
			{"n", "<Leader>c"},
			{"v", "<Leader>c"}
		},
		event = 'BufRead',
		config = function()
			require('configs.comments')
		end,
		disable = false,
	}

	-- Hop
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			require('configs.hop')
		end,
	}

	-- Autopairs
	use {
		'windwp/nvim-autopairs',
		config = function()
			require('configs.autopairs')
		end,
		disable = false,
	}

	-- Specs
	use {
		'edluffy/specs.nvim',
		config = function()
			require('configs.specs')
		end,
		disable = false,
	}

	-- Colorizer
	use {
		'norcalli/nvim-colorizer.lua',
		filetype = "html,css", -- or "latex"
		config = function()
			require('colorizer').setup()  -- Defaults
		end,
		disable = false,
	}

	-- Colorschemes
	use 'folke/tokyonight.nvim'

	-- Icons
	use {
		'kyazdani42/nvim-web-devicons',
		module = 'nvim-web-devicons',
		disable = false,
	}

	-- Tabs Viewer
	use { 'romgrk/barbar.nvim',
		event = 'BufWinEnter',
		disable = false,
	}

	-- Plenary
	use {
		'nvim-lua/plenary.nvim',
		module = 'plenary',
	}

	-- Git Signs
	use { 'lewis6991/gitsigns.nvim',
   		event = "BufRead",
		config = function()
			require('configs.gitsigns')
		end,
		disable = false,  -- Check config, slows down some motions/actions
	}

	-- treesitter
	use { 'nvim-treesitter/nvim-treesitter',
		requires = 'nvim-treesitter/nvim-treesitter-textobjects',
		config = function()
			require('configs.treesitter')
		end,
		disable = false,
	}

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		config = function()
			require('configs.telescope')
		end,
		disable = false,
	}

	-- nvim-tree
	use {
		'kyazdani42/nvim-tree.lua',
		keys = {
			{"n", "<Leader>n"}
		},
		config = function()
			require('configs.nvimtree')
		end,
		disable = false,
	}

	-- Completion
	use {
		'neovim/nvim-lspconfig',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'saadparwaiz1/cmp_luasnip',
		'L3MON4D3/LuaSnip',
		-- config = function()
		-- 	require('configs.completion')
		-- end,
		disable = false,
	}

end )
