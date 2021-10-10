return require('packer').startup(function()

    -- Packer
    use {
        'wbthomason/packer.nvim',
        disable = false,
    }

    -- Comments
    use {
        'terrortylor/nvim-comment',
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

    -- Colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()  -- Defaults
        end,
        disable = false,
    }

    -- Colorschemes
    use 'folke/tokyonight.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Tabs Viewer
    use { 'romgrk/barbar.nvim',
        event = 'BufWinEnter',
        disable = false,
        }

    -- Git Signs
    use { 'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',  -- Plenary
        event = 'BufRead',
        config = function ()
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

    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('configs.nvimtree')
        end,
        disable = false,
    }

    -- Everything for completion
    use {
        'neovim/nvim-lspconfig',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        disable = false,
    }

end )
