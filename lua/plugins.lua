return require('packer').startup(function()
    -- Packer
    use { 'wbthomason/packer.nvim' }

    -- lsp
    use {
        'neovim/nvim-lspconfig',
        'tamago324/nlsp-settings.nvim',
        'williamboman/nvim-lsp-installer',
    }


    -- Comments
    use {
        'terrortylor/nvim-comment',
        event = "BufRead",
        config = function()
            require('nvim_comment').setup({
                marker_padding = true,
                comment_empty = false,
                create_mappings = true,
                line_mapping = 'gcc',
                operator_mapping = 'gc',
                hook = nil,
            })
    end }


    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                map_cr = true,
                auto_select = true,
                insert = false,
                map_char = {
                    all = '(',
                    tex = '{'
                },
                check_ts = true;
                ts_config = {
                    lua = { 'string' },
                    javascript = { 'template_string' },
                    java = false,
                },
            })
    end }


    -- Colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
    end }


    -- Colorschemes
    use { 'folke/tokyonight.nvim' }


    -- Icons
    use { 'kyazdani42/nvim-web-devicons' }


    -- Tabs Viewer
    use {
        'romgrk/barbar.nvim',
        event = "BufWinEnter",
    }


    -- Plenary
    use { 'nvim-lua/plenary.nvim' }


    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        event = "BufRead",
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = {
                        hl = "GitSignsAdd",
                        text = "▎",
                        numhl = "GitSignsAddNr",
                        linehl = "GitSignsAddLn",
                    },
                    change = {
                        hl = "GitSignsChange",
                        text = "▎",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    delete = {
                        hl = "GitSignsDelete",
                        text = "契",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    topdelete = {
                        hl = "GitSignsDelete",
                        text = "契",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChange",
                        text = "▎",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                },
                numhl = false,
                linehl = false,
                keymaps = {
                    -- Default keymap options
                    noremap = true,
                    buffer = true,
                },
                watch_gitdir = { interval = 1000 },
                sign_priority = 6,
                update_debounce = 200,
                status_formatter = nil, -- Use default
            })
    end }


end )
