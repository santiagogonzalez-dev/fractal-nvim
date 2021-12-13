local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer close and reopen Neovim...")
    vim.cmd [[packadd packer.nvim]]
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
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
})

-- Install your plugins here
return packer.startup(function(use)
    local opts = { noremap = true, silent = true }

    -- Packer
    use {
        'wbthomason/packer.nvim',
        vim.api.nvim_set_keymap('n', '<Leader>ps', ':PackerSync<Cr>', opts),
        vim.api.nvim_set_keymap('n', '<Leader>pc', ':PackerCompile<Cr>', opts),
    }

    -- Plenary
    use 'nvim-lua/plenary.nvim'

    -- Colorscheme
    use{
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.g.rose_pine_variant = 'base'
        end,
    }

    -- Icons
    use {
        'kyazdani42/nvim-web-devicons',
        module = 'nvim-web-devicons',
    }

    -- Comment
    use {
        'numToStr/Comment.nvim',
        after = 'nvim-treesitter',
        event = 'BufEnter',
        config = function() require('csj.configs.comment') end,
    }

    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        after = 'nvim-treesitter',
        config = function() require('csj.configs.autopairs') end,
    }

    -- Autotags
    use {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
        event = 'InsertEnter',
    }

    -- Hop
    use {
        'phaazon/hop.nvim',
        event = 'VimEnter',
        config = function()
            require('hop').setup({
                keys = 'aoeusnthdiqjkzvwmbxlrcgp',
                term_seq_bias = 0.5,
                vim.cmd([[ highlight HopNextKey guifg=orange gui=nocombine ]]),
            })
        end,
        -- Keymappings
        vim.api.nvim_set_keymap('n', '<Leader>h', ':HopPattern<Cr>', opts)
    }

    -- Bufferline
    use {
        'akinsho/bufferline.nvim',
        config = function() require('csj.configs.bufferline') end,
    }

    -- Surround
    use {
        'tpope/vim-surround',
        event = 'VimEnter',
    }

    -- -- Terminal
    -- use {
    --     'akinsho/toggleterm.nvim',
    --     keys = { '<C-t>', '<Leader>r' },
    --     -- config = function() require('configs.toggleterm') end,
    -- }

    -- -- Stabilize
    -- use {
    --     'luukvbaal/stabilize.nvim',
    --     event = 'BufEnter',
    --     config = function() require('stabilize').setup() end,
    -- }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        config = function() require('csj.configs.treesitter') end,
    }

    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        event = 'BufRead',
    }

    -- Nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        event = 'BufEnter',
        config = function() require('csj.configs.nvimtree') end,
    }

    -- Colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        event = { 'CursorMoved', 'CursorHold' },
        config = function()
            require('colorizer').setup({ 'html', 'css', 'javascript', 'typescript', },
            {
                -- mode = 'foreground',
            })
            vim.cmd([[ ColorizerAttachToBuffer ]])
        end,
    }

    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        event = 'VimEnter',
        requires = 'plenary.nvim',
        config = function() require('csj.configs.gitsigns') end,
    }

    -- Indent Blankline
    use {
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter',
        event = 'VimEnter',
        config = function()
            require('indent_blankline').setup({
                show_current_context = true,
                -- show_current_context_start = true,
                show_end_of_line = false,
                buftype_exclude = { 'terminal', 'nofile', 'NvimTree' },
                filetype_exclude = { 'help', 'packer', 'NvimTree' },
            })
            -- vim.g.indent_blankline_char = '' -- Only shows active indent line
            vim.g.indent_blankline_use_treesitter = true
            vim.g.indent_blankline_char_highlight = 'LineNr'
            vim.g.indent_blankline_show_trailing_blankline_indent = false
            -- vim.g.indent_blankline_enabled = false
            vim.cmd([[ highlight IndentBlanklineContextChar guifg=orange gui=nocombine ]])
        end,
    }

    -- Completion
    use {
        'L3MON4D3/LuaSnip', -- Snippet engine
        'saadparwaiz1/cmp_luasnip', -- Snippet completions
        'hrsh7th/cmp-buffer', -- Buffer completions
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-cmdline', -- cmdline completion
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path', -- Path completion
        'hrsh7th/nvim-cmp', -- The completion plugin
        event = 'InsertEnter',
    }

    -- LSP
    use { 'neovim/nvim-lspconfig' }
    use { 'williamboman/nvim-lsp-installer' }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
