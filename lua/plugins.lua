return require('packer').startup(function()


    -- Packer
    use {
        'wbthomason/packer.nvim',
        disable = false,
    }


    -- Comment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ignore = '^$',
            })
        end,
        disable = false,
    }


    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,
                ts_config = {
                    -- lua = { "string" },
                    javascript = { "template_string" },
                    java = false,
                },
            })
            require('nvim-autopairs.completion.cmp').setup {
                map_cr = true, --  map <CR> on insert mode
                map_complete = true, -- it will auto insert `(` after select function or method item
                auto_select = true, -- automatically select the first item
            }
        end,
        disable = false,
    }


    -- Hop
    use {
        'phaazon/hop.nvim',
        as = 'hop',
        config = function()
            require('hop').setup({
                keys = 'aoeusnthlrcg,.p'
            })
        end,

        -- Keymappings
        vim.api.nvim_set_keymap('n', '<Leader>m', ':HopPattern<CR>', {noremap = true, silent = true}),

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
        config = function()
            require('configs.barbar')
        end,
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
            require('telescope').setup()
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


    -- LSP and language server installation
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        disable = false,
    }


    -- Completion engine with cmp
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        config = function()
            require('configs.cmp')
        end,
        disable = false,
    }


end )
