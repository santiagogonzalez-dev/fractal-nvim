local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
   { 'kyazdani42/nvim-web-devicons' },
   { 'nvim-lua/plenary.nvim' },

   -- Surround
   {
      'kylechui/nvim-surround',
      event = 'User FractalEnd',
      config = function() require('nvim-surround').setup() end,
   },

   -- Accelerated jk
   {
      'rainbowhxch/accelerated-jk.nvim',
      keys = { 'j', 'k', '<C-e>', '<C-y>', 'w', 'b', '+', '-' },
      config = function()
         require('accelerated-jk').setup({
            enable_deceleration = true,
            acceleration_motions = { 'w', 'b', '+', '-' },
         })
         vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
         vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
      end,
   },

   -- Indent Blankline
   {
      'lukas-reineke/indent-blankline.nvim',
      event = 'User FractalEnd',
      config = function()
         require('indent_blankline').setup({
            show_current_context = true,
            show_current_context_start = true,
            show_end_of_line = true,
            show_trailing_blankline_indent = false,
         })
      end,
   },

   -- Project
   {
      'ahmedkhalf/project.nvim',
      module = true,
      config = function()
         require('project_nvim').setup({
            detection_methods = { 'lsp', 'pattern' },
            patterns = {
               '.git',
               'package.json',
               'pom.xml',
               '.zshrc',
               'wezterm.lua',
            },
            show_hidden = true, -- Show hidden files in telescope when searching for files in a project
         })
      end,
   },

   -- Comment
   {
      'numToStr/Comment.nvim',
      event = 'User FractalEnd',
      config = function()
         require('Comment').setup({
            pre_hook = function(ctx)
               local U = require('Comment.utils')
               local location = nil
               if ctx.ctype == U.ctype.blockwise then
                  location =
                     require('ts_context_commentstring.utils').get_cursor_location()
               elseif
                  ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V
               then
                  location =
                     require('ts_context_commentstring.utils').get_visual_start_location()
               end
               return require('ts_context_commentstring.internal').calculate_commentstring({
                  key = ctx.ctype == U.ctype.linewise and '__default'
                     or '__multiline',
                  location = location,
               })
            end,
         })
      end,
   },

   -- Autopairs
   {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
         require('nvim-autopairs').setup({
            check_ts = true,
            ts_config = { javascript = { 'template_string' } },
            disable_filetype = { 'TelescopePrompt' },
            enable_afterquote = false, -- To use bracket pairs inside quotes
            enable_check_bracket_line = true, -- Check for closing brace so it will not add a close pair
            disable_in_macro = false,
            fast_wrap = {
               map = '<C-f>',
               chars = { '{', '[', '(', '"', "'", '<' },
               pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
               offset = -1, -- Offset from pattern match, with -1 you can insert before the comma
               keys = 'aosenuth', -- Because I use dvorak BTW
               check_comma = true,
               highlight = 'Search',
               highlight_grey = 'IncSearch',
            },
         })
      end,
   },

   -- Treesitter
   {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'User FractalEnd',
      dependencies = {
         {
            'JoosepAlviste/nvim-ts-context-commentstring',
            module = true,
         },
         {
            'nvim-treesitter/playground',
            cmd = { 'TSHighlightCapturesUnderCursor', 'TSPlaygroundToggle' },
            keys = '<Leader>tsh',
            config = function()
               require('nvim-treesitter.configs').setup({
                  playground = {
                     enable = true,
                     disable = {},
                     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                     persist_queries = false, -- Whether the query persists across vim sessions
                     keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                     },
                  },
               })
               vim.keymap.set(
                  'n',
                  '<Leader>tsh',
                  ':TSHighlightCapturesUnderCursor<CR>'
               )
            end,
         },
      },
      config = function() require('plugins.treesitter') end,
   },

   -- Git Signs
   {
      'lewis6991/gitsigns.nvim',
      event = 'User IsGit',
      config = function() require('plugins.gitsigns') end,
   },

   -- Telescope
   {
      'nvim-telescope/telescope.nvim',
      keys = {
         '<Leader>gr',
         '<Leader>t/',
         '<Leader>t//',
         '<Leader>tf',
         '<Leader>tg',
         '<Leader>tp',
         '<Leader>tt',
      },
      config = function() require('plugins.telescope') end,
   },

   -- JetJBP colorscheme
   {
      -- url = "santigo-zero/jetjbp.nvim",
      dir = '~/workspace/repositories/jetjbp.nvim',
      dev = true,
      lazy = true,
      -- config = function()
      --    vim.api.nvim_set_hl(0, '@variable', { fg = '#74749C' })
      -- end,
   },

   {
      'santigo-zero/right-corner-diagnostics.nvim',
      lazy = true,
      event = 'LspAttach',
      config = function()
         -- Recommended:
         -- NOTE: Apply this settings before calling the `setup()`.
         vim.diagnostic.config({
            -- Disable default virtual text since you are using this plugin
            -- already :)
            virtual_text = false,

            -- Do not display diagnostics while you are in insert mode, so if you have
            -- `auto_cmds = true` it will not update the diagnostics while you type.
            update_in_insert = false,
         })

         -- Default config:
         require('rcd').setup({
            -- Where to render the diagnostics: top or bottom, the latter sitting at
            -- the bottom line of the buffer, not of the terminal.
            position = 'bottom',

            -- In order to print the diagnostics we need to use autocommands, you can
            -- disable this behaviour and call the functions yourself if you think
            -- your autocmds work better than the default ones with this option:
            auto_cmds = true,
         })
      end,
   },

   -- color utils
   {
      'max397574/colortils.nvim',
      cmd = 'Colortils',
      config = function() require('colortils').setup() end,
   },

   {
      'amadeus/vim-convert-color-to',
   },

   {
      'navarasu/onedark.nvim',
      config = function() require('onedark').load() end,
   },

   -- Nvim lspconfig
   {
      'neovim/nvim-lspconfig',
      config = function() require('plugins.lsp') end,
   },

   -- Mason
   {
      'williamboman/mason.nvim',
      event = 'User FractalEnd',
   },

   -- Mason lspconfig
   {
      'williamboman/mason-lspconfig.nvim',
      event = 'User FractalEnd',
   },

   -- Null LS
   {
      'jose-elias-alvarez/null-ls.nvim',
      event = 'User FractalEnd',
      config = function() require('plugins.lsp.null-ls') end,
   },

   -- CMP
   {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
         'saadparwaiz1/cmp_luasnip',
         'rafamadriz/friendly-snippets',
         'hrsh7th/cmp-nvim-lsp',
         'hrsh7th/cmp-nvim-lua',
         'hrsh7th/cmp-buffer',
         'hrsh7th/cmp-nvim-lsp-signature-help',
         'hrsh7th/cmp-path',
         'hrsh7th/cmp-cmdline',
         'L3MON4D3/LuaSnip',
      },
      config = function() require('plugins.cmp') end,
   },

   -- Colorizer
   {
      'NvChad/nvim-colorizer.lua',
      event = 'BufRead',
      config = function()
         require('colorizer').setup()
         require('colorizer').attach_to_buffer(0, { css = true, svelte = true })
      end,
   },
}

require('lazy').setup(plugins)
