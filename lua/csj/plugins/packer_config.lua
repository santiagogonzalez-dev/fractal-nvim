-- Packer settings and setup

-- Automatically install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print('Installing packer close and reopen Neovim...')
    vim.cmd([[ packadd packer.nvim ]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

packer.init {
    -- Path for packer_compiled.lua
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',

    -- Have packer use a popup window
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end,
    },
}

return packer.startup(function(use)
    -- Impatient
    use {
        'lewis6991/impatient.nvim',
        config = function()
            require('impatient').enable_profile()
        end,
    }

    use('wbthomason/packer.nvim') -- Packer
    use { 'nvim-lua/plenary.nvim', module = 'plenary' } -- Plenary
    use { 'kyazdani42/nvim-web-devicons', after = 'nvim-tree.lua' } -- Icons
    use('tpope/vim-surround') -- Surround
    use('tpope/vim-repeat') -- Repeat
    use('tweekmonster/startuptime.vim') -- Startuptime

    -- Colorscheme, Rosé Pine
    use {
        'rose-pine/neovim',
        as = 'rose-pine',
    }

    -- Comment
    use {
        'numToStr/Comment.nvim',
        module = 'comment',
        keys = { 'gcc', 'gc', 'gcb', 'gb' },
        config = function()
            require('csj.plugins.configs.comment')
        end,
    }

    -- Project
    use {
        'ahmedkhalf/project.nvim',
        config = function()
            vim.g.nvim_tree_respect_buf_cwd = 1
            require('csj.plugins.configs.project')
        end,
    }

    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('csj.plugins.configs.autopairs')
        end,
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        opt = true,
        run = ':TSUpdate',
        requires = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'p00f/nvim-ts-rainbow',
        },
        config = function()
            require('csj.plugins.configs.treesitter')
        end,
    }

    -- Treehopper
    use {
        'mfussenegger/nvim-treehopper',
        opt = true,
        config = function()
            require('tsht').config.hint_keys = { 'a', 'o', 'e', 'u', 'i', 'd', 'h', 't', 'n', 's' }
            require('csj.core.keymaps').treehopper_keybinds()
        end,
    }

    -- Completion and snippets
    use {
        'L3MON4D3/LuaSnip', -- Snippet engine
        'rafamadriz/friendly-snippets', -- Additional snippets
        'saadparwaiz1/cmp_luasnip', -- Snippet completions
        'hrsh7th/cmp-buffer', -- Buffer completions
        'hrsh7th/cmp-calc', -- Calculator as completion
        'hrsh7th/cmp-cmdline', -- cmdline completion
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path', -- Path completion
        'hrsh7th/nvim-cmp', -- The completion plugin
    }

    -- LSP
    use {
        'neovim/nvim-lspconfig', -- Enable LSP
        'williamboman/nvim-lsp-installer', -- Install language servers
    }

    -- Null-LS for formatters and linters
    use { 'jose-elias-alvarez/null-ls.nvim' }

    -- Bufferline
    use {
        'akinsho/bufferline.nvim',
        config = function()
            require('csj.plugins.configs.bufferline')
        end,
    }

    -- Toggle term
    use {
        'akinsho/toggleterm.nvim',
        module = 'toggleterm',
        keys = { '<C-t>' },
        config = function()
            require('csj.plugins.configs.toggleterm')
        end,
    }

    -- Notifications
    use {
        'simrat39/desktop-notify.nvim',
        config = function()
            require('desktop-notify').override_vim_notify()
        end,
    }

    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        opt = true,
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            local gitsigns = require('csj.plugins.configs.gitsigns').setup()
            require('csj.core.keymaps').gitsigns_keybinds(gitsigns)
        end,
    }

    -- Nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('csj.plugins.configs.nvimtree')
            require('csj.core.keymaps').nvimtree_keybinds()
        end,
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        module = 'telescope',
        keys = { 't/', 't//', 'tf', 'tp', 'tt' },
        requires = {
            'nvim-lua/plenary.nvim',
            'ahmedkhalf/project.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        config = function()
            require('csj.core.keymaps').telescope_keybinds()
            require('csj.plugins.configs.telescope').setup()
        end,
    }

    -- Indent Blankline
    use {
        'lukas-reineke/indent-blankline.nvim',
        opt = true,
        config = function()
            require('csj.plugins.configs.indentblankline')
        end,
    }

    -- Colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        opt = true,
        config = function()
            require('colorizer').setup()
        end,
    }

    -- Vim Hexokinase
    use {
        'RRethy/vim-hexokinase',
        opt = true,
        run = 'cd /home/st/.local/share/nvim/site/pack/packer/opt/vim-hexokinase && make hexokinase',
    }

    -- Semantic Highlight
    use {
        'jaxbot/semantic-highlight.vim',
        config = function()
            vim.cmd([[
                " let s:semanticGUIColors = [ '#eb6f92', '#f6c177', '#ebbcba', '#31748f', '#9ccfd8', '#c4a7e7', ]
                let s:semanticGUIColors = [ '#eb6f92', '#f6c177', '#ea9a97', '#3e8fb0', '#9ccfd8', '#c4a7e7', ]
            ]])
            vim.keymap.set('n', '<Leader><Leader>', function()
                vim.cmd([[TSBufToggle highlight]])
                vim.cmd([[SemanticHighlightToggle]])
            end)
        end,
    }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
