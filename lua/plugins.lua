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
        disable = false,
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
        config = function () require('gitsigns').setup()  -- Defaults
        end,
        disable = false,
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
        config = function() require('nvim-tree').setup()  -- Defaults
        end,
        disable = false,
    }

    -- Everything for completion
    -- use {
    --     'williamboman/nvim-lsp-installer',
    --     'neovim/nvim-lspconfig',
    --     config = function() require('nvim-lsp-installer').setup()  -- Defaults
    --     end,
    --     disable = false,
    -- }

end )
