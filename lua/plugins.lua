return require('packer').startup(function()

    -- Packer
    use 'wbthomason/packer.nvim'

    -- Comments
    use {
        'terrortylor/nvim-comment',
        event = 'BufRead',
        config = function()
            require('configs.comments')
        end,
    }

    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('configs.autopairs')
        end,
    }

    -- Colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()  -- Defaults
        end,
    }

    -- Colorschemes
    use 'folke/tokyonight.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Tabs Viewer
    use { 'romgrk/barbar.nvim',
        event = 'BufWinEnter' }

    -- Git Signs
    use { 'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',  -- Plenary
        event = 'BufRead',
        config = function () require('gitsigns').setup()  -- Defaults
        end,
    }

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter',
        requires = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require('configs.treesitter')
        end,
    }

    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('nvim-tree').setup()  -- Defaults
        end,
    }

end )
