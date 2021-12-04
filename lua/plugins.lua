-- Automatically install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer, close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
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
    -- Colorscheme
    use{
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            -- Options (see available options below)
            vim.g.rose_pine_variant = 'base'
            -- vim.g.rose_pine_variant = 'moon'
            -- vim.g.rose_pine_variant = 'dawn'
        end,
    }
    -- Load colorscheme after options
    vim.cmd('colorscheme rose-pine')
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
        config = function() require('configs.comment') end,
    }
    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        after = 'nvim-treesitter',
        config = function() require('configs.autopairs') end,
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
    -- Tabs Viewer
    use {
        'romgrk/barbar.nvim',
        event = 'BufEnter',
        config = function() require('configs.barbar') end,
    }
    -- Surround
    use {
        'tpope/vim-surround',
        event = 'VimEnter',
    }
    -- Terminal
    use {
        'akinsho/toggleterm.nvim',
        keys = { '<C-t>', '<Leader>r' },
        config = function() require('configs.toggleterm') end,
    }
    -- Stabilize
    use {
        'luukvbaal/stabilize.nvim',
        event = 'BufEnter',
        config = function() require('stabilize').setup() end,
    }
    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        config = function() require('configs.treesitter') end,
    }
    -- Nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        event = 'BufEnter',
        config = function() require('configs.nvimtree') end,
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
    -- Plenary
    use {
        'nvim-lua/plenary.nvim',
    }
    -- TelescopePrompt
    use {
        'nvim-telescope/telescope.nvim',
        opt = true,
        cmd = 'Telescope',
        event = 'BufRead',
        config = function() require('configs.telescope') end,
    }
    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        event = 'VimEnter',
        requires = 'plenary.nvim',
        config = function() require('configs.gitcolumnsigns') end,
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
        -- Keymappings
        vim.api.nvim_set_keymap('n', '<Leader>i', ':IndentBlanklineToggle<Cr>', opts)
    }
    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
    }
    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
        event = 'InsertEnter',
    }
    -- Java
    use {
        'mfussenegger/nvim-jdtls',
        event = 'BufEnter',
    }
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
