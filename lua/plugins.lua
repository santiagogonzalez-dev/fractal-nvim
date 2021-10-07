return require('packer').startup(function()
    -- Impatient
    use { 'lewis6991/impatient.nvim' }
    config = {
        compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
    }

    -- Packer
    use { 'wbthomason/packer.nvim' }

    -- Comments
    use { 'terrortylor/nvim-comment',
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
    use { 'windwp/nvim-autopairs', config = function()
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
        config = function() require('gitsigns').setup({
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

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
    }

    -- Treesitter, to update :TSUpdate
    use {
        'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        config = function() require('nvim-treesitter.configs').setup {}
    end }

    -- Nvim Tree
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('nvim-tree').setup({
            setup = {
                auto_open = 0,
                auto_close = 1,
                tab_open = 0,
                update_focused_file = {
                    enable = 1,
                },
                lsp_diagnostics = 1,
                view = {
                    width = 30,
                    side = "left",
                    auto_resize = false,
                    mappings = {
                        custom_only = false,
                    },
                },
            },
            show_icons = {
                git = 1,
                folders = 1,
                files = 1,
                folder_arrows = 1,
                tree_width = 30,
            },
            ignore = { ".git", "node_modules", ".cache" },
            quit_on_open = 0,
            hide_dotfiles = 1,
            git_hl = 1,
            root_folder_modifier = ":t",
            allow_resize = 1,
            auto_ignore_ft = { "startify", "dashboard" },
            icons = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            },
        })
    end }

end )
