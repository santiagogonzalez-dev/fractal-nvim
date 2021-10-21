require('packer').startup(function(use)

    -- Packer
    use {
        'wbthomason/packer.nvim',
        vim.api.nvim_set_keymap('n', '<Leader>ps', ':PackerSync<CR>', {noremap = true, silent = true}),
        vim.api.nvim_set_keymap('n', '<Leader>pu', ':PackerUpdate<CR>', {noremap = true, silent = true}),
        vim.api.nvim_set_keymap('n', '<Leader>pc', ':PackerCompile<CR>', {noremap = true, silent = true}),
    }

    use {
        'folke/tokyonight.nvim',
        'sainnhe/everforest',
        'sainnhe/sonokai',
    }

    -- ColorScheme
    vim.g.tokyonight_style='night'
    vim.api.nvim_exec([[ autocmd ColorScheme * highlight Visual cterm=reverse gui=reverse ]], true)  -- Colors in visual mode
    -- vim.g.sonokai_style = 'andromeda'
    vim.cmd([[ colorscheme tokyonight ]])  -- Select colorscheme


    -- Icons
    use {
        'kyazdani42/nvim-web-devicons',
    }


    -- Comment
    use {
        'numToStr/Comment.nvim',
        event = 'BufEnter',
        keys = { '<Leader>c', 'gc' },
        config = function()
            require('Comment').setup({
                ignore = '^$',
            })
            require('Comment.ft').set('dosini', '#%s')
            require('Comment.ft').set('zsh', '#%s')
            require('Comment.ft').set('help', '#%s')
        end,
    }


    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        after = 'nvim-cmp',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,
                ts_config = {
                    javascript = { 'template_string' },
                    java = true,
                },
                enable_check_bracket_line = false,
            })
            require('nvim-autopairs.completion.cmp').setup {
                map_cr = true,  -- map <CR> on insert mode
                map_complete = true,  -- it will auto insert `(` after select function or method item
                auto_select = true,  -- automatically select the first item
            }
        end,
    }


    -- Autotags
    use {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
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
        end, -- Keymappings
        vim.api.nvim_set_keymap('n', '<Leader>h', ':HopPattern<CR>', {noremap = true, silent = true}),
    }


    -- Treesitter textobjects
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        opt = true,
    }


    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',  -- For some reason nvim-ts-autotag only works when I don't lazyload treesitter
        requires = 'nvim-treesitter-textobjects',
        config = function()
            require('configs.treesitter')
        end,
    }


    -- Nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('configs.nvimtree')
        end,
    }


    -- Tabs Viewer
    use {
        'romgrk/barbar.nvim',
        event = 'BufEnter',
        config = function()
            require('configs.barbar')
        end,
    }


    -- Colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        ft = {
            'html',
            'css',
        },
        event = { 'CursorMoved', 'CursorHold' },
        config = function()
            require('colorizer').setup({
                '*',
            }, {
                    mode = 'foreground',
                })
            vim.cmd [[ColorizerAttachToBuffer]]
        end,
    }


    -- Plenary
    use {
        'nvim-lua/plenary.nvim',
    }


    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        -- event = 'BufRead',
        event = 'VimEnter',
        after = 'plenary.nvim',
        requires = 'plenary.nvim',
        config = function()
            require('configs.gitcolumnsigns')
        end,
    }


    -- Indent Blankline
    use {
        'lukas-reineke/indent-blankline.nvim',
        cmd = 'IndentBlanklineToggle',
        config = function()
            require('indent_blankline').setup({
                show_current_context = true,
            })
        end,
    }


    -- Completion engine with cmp and
    -- LSP and snippets
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',  -- Snippets plugin
        'saadparwaiz1/cmp_luasnip',
        'neovim/nvim-lspconfig',  -- Collection of configurations for built-in LSP client
        event = 'InsertEnter',
    }


end )
