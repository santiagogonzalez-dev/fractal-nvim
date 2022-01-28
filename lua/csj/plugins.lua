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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    },
})

return packer.startup(function(use)
    -- Impatient
    use({
        'lewis6991/impatient.nvim',
        config = function()
            require('csj.configs.impatient')
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
        after = {
            'nvim-treesitter',
            'nvim-ts-context-commentstring',
        },
        config = function()
            require('csj.configs.comment')
        end,
    })

    -- Autopairs
    use({
        'windwp/nvim-autopairs',
        after = 'nvim-treesitter',
        event = 'InsertEnter',
        config = function()
            require('csj.configs.autopairs')
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

    -- Hop
    use({
        'phaazon/hop.nvim',
        opt = true,
        config = function()
            require('hop').setup({
                keys = 'aoeusnthdiqjkzvwmbxlrcgp',
                term_seq_bias = 0.5,
            })
        end,
    })

    -- Bufferline
    use({
        'akinsho/bufferline.nvim',
        opt = true,
        config = function()
            require('csj.configs.bufferline')
        end,
    })

    -- Surround
    use({
        'blackCauldron7/surround.nvim',
        opt = true,
        config = function()
            require('surround').setup({ mappings_style = 'surround' })
        end,
    })

    -- Toggleterm
    use({
        'akinsho/toggleterm.nvim',
        keys = {
            '<C-t>',
            '<Leader>R',
        },
        config = function()
            require('csj.configs.toggleterm')
        end,
    })

    -- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('csj.configs.treesitter')
        end,
        requires = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'p00f/nvim-ts-rainbow',
        },
    })

    -- Nvim-tree
    use({
        'kyazdani42/nvim-tree.lua',
        event = 'BufEnter',
        config = function()
            require('csj.configs.nvimtree')
        end,
    })

    -- Project
    use({
        'ahmedkhalf/project.nvim',
        config = function()
            vim.g.nvim_tree_respect_buf_cwd = 1
            require('csj.configs.project')
        end,
    })

    -- Colorizer
    use({
        'norcalli/nvim-colorizer.lua',
        event = {
            'CursorMoved',
            'CursorHold',
        },
        config = function()
            require('colorizer').setup()
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
    })

    -- LSP
    use({ 'neovim/nvim-lspconfig' }) -- Enable LSP
    use({ 'williamboman/nvim-lsp-installer' }) -- Install language servers

    -- Null-LS
    use({
        'jose-elias-alvarez/null-ls.nvim', -- For formatters and linters
        event = 'Filetype',
        config = function()
            require('csj.lsp.null-ls')
        end,
    })

    -- Startuptime
    use({ 'dstein64/vim-startuptime' })

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
