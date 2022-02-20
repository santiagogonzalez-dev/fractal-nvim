-- Packer settings and setup

-- Automatically install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    print('Installing packer close and reopen Neovim...')
    vim.cmd([[ packadd packer.nvim ]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

packer.init({
    -- packer_compiled.lua path
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',

    -- Have packer use a popup window
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    },
})

return packer.startup(function(use)

    -- Core

    -- Impatient
    use({
        'lewis6991/impatient.nvim',
        config = function()
            require('csj.core.impatient')
        end,
    })

    -- Packer
    use({ 'wbthomason/packer.nvim' })

    -- Plenary
    use({ 'nvim-lua/plenary.nvim' })

    -- Icons
    use({ 'kyazdani42/nvim-web-devicons' })

    -- Colorscheme
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
    })

    -- Comment
    use({
        'numToStr/Comment.nvim',
        keys = {
            'gcc',
            'gc',
            'gcb',
            'gb',
        },
        config = function()
            require('csj.core.comment')
        end,
    })

    -- Project
    use({
        'ahmedkhalf/project.nvim',
        event = 'VimEnter',
        config = function()
            vim.g.nvim_tree_respect_buf_cwd = 1
            require('csj.core.project')
        end,
    })

    -- Autopairs
    use({
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('csj.core.autopairs')
        end,
    })

    -- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('csj.core.treesitter')
        end,
        requires = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'p00f/nvim-ts-rainbow',
        },
    })

    -- End Core

    -- Completion

    use({
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
        event = 'InsertEnter',
    })

    -- End Completion

    -- LSP

    use({
        'neovim/nvim-lspconfig', -- Enable LSP
        'williamboman/nvim-lsp-installer', -- Install language servers
        event = 'InsertEnter',
    })

    -- Null-LS
    use({
        'jose-elias-alvarez/null-ls.nvim', -- For formatters and linters
        event = 'InsertEnter',
        config = function()
            require('csj.lsp.null-ls')
        end,
    })

    -- End LSP

    -- Extra Plugins

    -- Bufferline
    use({
        'akinsho/bufferline.nvim',
        opt = true,
        config = function()
            require('csj.configs.bufferline')
        end,
    })

    -- Folds
    use({
        'anuvyklack/pretty-fold.nvim',
        opt = true,
        config = function()
            require('csj.configs.folds')
        end,
    })

    -- Git Signs
    use({
        'lewis6991/gitsigns.nvim',
        opt = true,
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('csj.configs.gitsigns')
        end,
    })

    -- Nvim-tree
    use({
        'kyazdani42/nvim-tree.lua',
        opt = true,
        config = function()
            require('csj.configs.nvimtree')
        end,
    })

    -- Vim Fugitive
    use({
        'tpope/vim-fugitive',
        cmd = {
            'Git'
        },
    })

    -- Vim Surround
    use({
        'tpope/vim-surround',
        event = 'InsertEnter',
    })

    -- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        opt = true,
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('csj.configs.telescope')
            require('csj.keymaps').telescope_keybinds()
        end,
    })

    -- Status line
    use({
        'nvim-lualine/lualine.nvim',
        opt = true,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('csj.configs.lualine')
        end,
    })

    -- Colorizer
    use({
        'norcalli/nvim-colorizer.lua',
        opt = true,
        config = function()
            require('colorizer').setup()
        end,
    })

    -- Startup time
    use({ 'dstein64/vim-startuptime', })

    -- Toggle term
    use({
        'akinsho/toggleterm.nvim',
        keys = {
            '<C-t>'
        },
        config = function()
            require('csj.configs.toggleterm')
        end,
    })

    -- End Extra Plugins

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
