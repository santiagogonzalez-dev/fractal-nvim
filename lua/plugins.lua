require('packer').startup(function(use)


    -- Packer
    use {
        'wbthomason/packer.nvim',
        disable = false,
        config = {
            -- Move to lua dir so impatient.nvim can cache it
            compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
        }
    }


    -- Impatient
    use {
        'lewis6991/impatient.nvim',
        opt = true,
        config = function()
            require 'impatient'
            require('impatient').enable_profile()
        end,
    }

    -- Comment
    use {
        'numToStr/Comment.nvim',
        event = 'BufEnter',
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
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,
                ts_config = {
                    javascript = { 'template_string' },
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
        event = 'BufEnter',
        config = function()
            require('hop').setup({
                keys = 'aoeusnthlrcg,.p'
            })
        end,

        -- Keymappings
        vim.api.nvim_set_keymap('n', '<Leader>h', ':HopPattern<CR>', {noremap = true, silent = true}),

        disable = false,
    }


    -- Colorizer
    use {
        "norcalli/nvim-colorizer.lua",
        event = { "CursorMoved", "CursorHold" },
        module = 'nvim-colorizer',
        opt = true,
        config = function()
            require("colorizer").setup({
                "*",
            }, {
                    mode = "foreground",
                })
            vim.cmd [[ColorizerAttachToBuffer]]
        end,
        disable = false,
    }


    -- Colorschemes
    use 'folke/tokyonight.nvim'


    -- Icons
    use {
        'kyazdani42/nvim-web-devicons',
        module = 'nvim-web-devicons',
        opt = true,
        disable = false,
    }


    -- Tabs Viewer
    use { 'romgrk/barbar.nvim',
        module = 'barbar',
        opt = true,
        event = 'BufWinEnter',
        config = function()
            require('configs.barbar')
        end,
        disable = false,
    }


    -- Plenary
    use {
        'nvim-lua/plenary.nvim',
        disable = false,
    }


    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('configs.gitsigns')
        end,
        disable = false,  -- Check config, slows down some motions/actions
    }


    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        after = 'impatient.nvim',
        module = 'nvim-treesitter',
        opt = true,
        event = 'BufRead',
        require = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require('configs.treesitter')
        end,
        disable = false,
    }


    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        after = "impatient.nvim",
        cmd = { "Telescope" },
        event = { "CursorMoved", "CursorHold" },
        config = function()
            require('telescope').setup()
        end,
        disable = false,
    }


    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        module = 'nvim-tree',
        opt = true,
        config = function()
            require('configs.nvimtree')
        end,
        disable = false,
    }


    -- LSP and language server installation
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        event = 'InsertEnter',
        disable = false,
    }


    -- Completion engine with cmp
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        config = function()
            require('configs.cmp')
        end,
        disable = false,
    }


end )
