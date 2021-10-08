return require('packer').startup(function()

    -- Packer
    use 'wbthomason/packer.nvim'

    -- Comments
    use {
        'terrortylor/nvim-comment',
        event = 'BufRead',
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
    use 'folke/tokyonight.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Tabs Viewer
    use {
        'romgrk/barbar.nvim',
        event = "BufWinEnter",
    }

    -- Plenary
    use 'nvim-lua/plenary.nvim'

    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        event = "BufRead",
        config = function () require('gitsigns').setup()
    end }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = function() require('nvim-treesitter.configs').setup {
            ensure_installed = {
                "lua", "bash", "python", "typescript", "javascript",
                "html", "css", "c", "java", "json",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true
            },
            autotag = {
                enable = true
            },
        }
    end }

    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('nvim-tree').setup()
    end }

end )
