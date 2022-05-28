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
   vim.cmd('packadd packer.nvim')
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
   return
end

packer.init {
   -- Path for packer_compiled.lua
   compile_path = vim.fn.stdpath('config') .. '/lua/csj/plugins/packer_compiled.lua',

   -- Have packer use a popup window
   display = {
      open_fn = function()
         return require('packer.util').float { border = 'rounded' }
      end,
   },
}

return packer.startup(function(use)
   use('wbthomason/packer.nvim') -- Packer
   use { 'nvim-lua/plenary.nvim', module = 'plenary' } -- Plenary
   use { 'metakirby5/codi.vim', cmd = 'Codi' } -- Codi
   use('tpope/vim-surround') -- Surround
   use('tpope/vim-repeat') -- Repeat
   use('kyazdani42/nvim-web-devicons')

   -- Impatient
   use {
      'lewis6991/impatient.nvim',
      config = function()
         require('impatient').enable_profile()
      end,
   }

   -- Accelerated jk
   use {
      'rainbowhxch/accelerated-jk.nvim',
      keys = { 'j', 'k' },
      config = function()
         vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)')
         vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)')
      end,
   }

   -- Project
   use {
      'ahmedkhalf/project.nvim',
      module = 'project',
      opt = true,
      config = function()
         require('project_nvim').setup {
            detection_methods = { 'lsp', 'pattern' },
            patterns = { '.git', 'package.json', 'pom.xml', '.zshrc', 'wezterm.lua' },
            show_hidden = true, -- Show hidden files in telescope when searching for files in a project
         }
      end,
   }

   -- Comment
   use {
      'numToStr/Comment.nvim',
      keys = { 'gcc', 'gc', 'gcb', 'gb' },
      config = function()
         require('Comment').setup {
            padding = true,
            sticky = true,
            ignore = '^$',
            pre_hook = function(ctx)
               local U = require('Comment.utils')
               local location = nil
               if ctx.ctype == U.ctype.block then
                  location = require('ts_context_commentstring.utils').get_cursor_location()
               elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                  location = require('ts_context_commentstring.utils').get_visual_start_location()
               end
               return require('ts_context_commentstring.internal').calculate_commentstring {
                  key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
                  location = location,
               }
            end,
         }
         require('Comment.ft')({ 'dosini', 'zsh', 'help' }, { '#%s' })
      end,
   }

   -- Autopairs
   use {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
         require('nvim-autopairs').setup {
            check_ts = true,
            ts_config = {
               javascript = { 'template_string' },
            },
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
         }
         -- local cmp_ok, cmp = pcall(require, 'cmp')
         -- if not cmp_ok then
         --     return
         -- else
         --     local cmp_autopairs = require('nvim-autopairs.completion.cmp')
         --     cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
         -- end
      end,
   }

   -- Treesitter
   use {
      'nvim-treesitter/nvim-treesitter',
      event = 'User LoadPlugins',
      run = ':TSUpdate',
      requires = {
         'nvim-treesitter/nvim-treesitter-textobjects',
         {
            'JoosepAlviste/nvim-ts-context-commentstring',
            after = 'Comment.nvim',
         },
         {
            'nvim-treesitter/playground',
            config = function()
               require('nvim-treesitter.configs').setup {
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
               }
            end,
         },
      },
      config = function()
         require('csj.plugins.treesitter')
      end,
   }

   -- GitSigns
   use {
      'lewis6991/gitsigns.nvim',
      event = 'User IsGit',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
         require('csj.plugins.gitsigns')
      end,
   }

   -- Telescope
   use {
      'nvim-telescope/telescope.nvim',
      module = 'telescope',
      keys = {
         'gr',
         't/',
         't//',
         'tf',
         'tp',
         'tt',
      },
      requires = 'nvim-lua/plenary.nvim',
      config = function()
         vim.cmd('PackerLoad project.nvim')
         require('csj.plugins.telescope')
      end,
   }

   -- Indent Blankline
   use {
      'lukas-reineke/indent-blankline.nvim',
      event = 'User LoadPlugins',
      config = function()
         require('indent_blankline').setup {
            show_current_context = true,
            show_current_context_start = false,
            show_end_of_line = true,
            show_trailing_blankline_indent = false,
            -- char = ' ',
            -- char = '▎',
            space_char_blankline = ' ',
            max_indent_increase = 1,
         }
      end,
   }

   -- Colorizer
   use {
      'norcalli/nvim-colorizer.lua',
      event = 'User LoadPlugins',
      config = function()
         local colorizer = vim.api.nvim_create_augroup('nvim-colorizer', {})
         vim.api.nvim_create_autocmd('BufReadPost', {
            group = colorizer,
            command = 'ColorizerAttachToBuffer',
         })
         vim.cmd('ColorizerAttachToBuffer')
      end,
   }

   -- LSP
   use {
      'neovim/nvim-lspconfig',
      event = 'User LoadPlugins',
      requires = {
         'williamboman/nvim-lsp-installer',
         'jose-elias-alvarez/null-ls.nvim',
      },
      config = function()
         require('csj.lsp')
      end,
   }

   -- Completion, snippets
   use {
      'hrsh7th/nvim-cmp',
      event = 'User LoadPlugins',
      requires = {
         'saadparwaiz1/cmp_luasnip',
         'hrsh7th/cmp-nvim-lsp',
         'hrsh7th/cmp-buffer',
         'hrsh7th/cmp-nvim-lsp-signature-help',
         'hrsh7th/cmp-path',
         'hrsh7th/cmp-cmdline',
         'L3MON4D3/LuaSnip',
      },
      config = function()
         require('csj.plugins.cmp')
      end,
   }

   if PACKER_BOOTSTRAP then
      require('packer').sync()
   end
   return packer
end)
