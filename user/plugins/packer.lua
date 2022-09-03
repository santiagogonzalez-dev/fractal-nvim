local M = {}
local packer_compiled_path = string.format('%s%s', vim.fn.stdpath 'config', '/user/plugins/packer_compiled.lua')
local packer

function M.packer_load()
   vim.cmd.packadd 'packer.nvim'
   packer = require 'packer'
end

function M.check_packer()
   local packer_installed = require('csj.utils').is_installed 'opt/packer.nvim'
   local plugins_dir = string.format('%s%s', vim.fn.stdpath 'data', '/site/pack/packer') -- /home/user/.local/share/nvim/site/pack/packer
   if not packer_installed then
      vim.fn.delete(packer_compiled_path) -- Delete the packer_compiled

      -- Clone packer
      vim.fn.system {
         'git',
         'clone',
         '--depth',
         '1',
         'https://github.com/wbthomason/packer.nvim',
         plugins_dir .. '/opt/packer.nvim',
      }

      -- vim.notify 'Installing packer.nvim, open neovim again and run :PackerSync'
      M.packer_load()
   else
      M.packer_load()
   end
end

function M.init_packer()
   packer.init {
      compile_path = packer_compiled_path, -- Path for packer_compiled.lua
      git = { clone_timeout = 360 },
      display = {
         open_fn = function()
            return require('packer.util').float { border = 'rounded' } -- Have packer use a popup window
         end,
      },
   }
end

function M.list_plugins()
   return packer.startup(function(use)
      use { 'wbthomason/packer.nvim', opt = true } -- Packer
      use { 'nvim-lua/plenary.nvim', module = 'plenary' } -- Plenary
      use 'kyazdani42/nvim-web-devicons'

      -- Surround
      use {
         'kylechui/nvim-surround',
         event = 'User LoadPlugins',
         config = function()
            require('nvim-surround').setup()
         end,
      }

      -- Accelerated jk
      use {
         'rainbowhxch/accelerated-jk.nvim',
         keys = { 'j', 'k', 'w', 'b', '+', '-' },
         config = function()
            require('accelerated-jk').setup {
               enable_deceleration = true,
               acceleration_motions = { 'w', 'b', '+', '-' },
            }
            vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
            vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
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
               patterns = {
                  '.git',
                  'package.json',
                  'pom.xml',
                  '.zshrc',
                  'wezterm.lua',
               },
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
               mappings = {
                  basic = true,
                  extra = true,
                  extended = true,
               },
               pre_hook = function(ctx)
                  local U = require 'Comment.utils'
                  local location = nil
                  if ctx.ctype == U.ctype.blockwise then
                     location = require('ts_context_commentstring.utils').get_cursor_location()
                  elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                     location = require('ts_context_commentstring.utils').get_visual_start_location()
                  end
                  return require('ts_context_commentstring.internal').calculate_commentstring {
                     key = ctx.ctype == U.ctype.linewise and '__default' or '__multiline',
                     location = location,
                  }
               end,
            }
            require 'Comment.ft'({ 'dosini', 'zsh', 'help' }, { '#%s' })
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
         end,
      }

      -- Treesitter
      use {
         'nvim-treesitter/nvim-treesitter',
         event = 'User LoadPlugins',
         run = ':TSUpdate',
         requires = {
            { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'Comment.nvim' },
            {
               'nvim-treesitter/playground',
               cmd = 'TSPlaygroundToggle',
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
            require 'plugins.treesitter'
         end,
      }

      -- GitSigns
      use {
         'lewis6991/gitsigns.nvim',
         event = 'User IsGit',
         requires = 'nvim-lua/plenary.nvim',
         config = function()
            require 'plugins.gitsigns'
         end,
      }

      -- Telescope
      use {
         'nvim-telescope/telescope.nvim',
         module = 'telescope',
         keys = {
            '<Leader>gr',
            '<Leader>t/',
            '<Leader>t//',
            '<Leader>tf',
            '<Leader>tg',
            '<Leader>tp',
            '<Leader>tt',
         },
         requires = 'nvim-lua/plenary.nvim',
         config = function()
            vim.cmd 'PackerLoad project.nvim'
            require 'plugins.telescope'
         end,
      }

      -- LSP
      use {
         'neovim/nvim-lspconfig',
         event = 'User LoadPlugins',
         config = function()
            require 'plugins.lsp'
         end,
      }

      -- Mason
      use {
         'williamboman/mason.nvim',
         opt = true,
      }

      -- Mason Lsp Installer
      use {
         'williamboman/mason-lspconfig.nvim',
         opt = true,
      }

      -- Null-LS
      use {
         'jose-elias-alvarez/null-ls.nvim',
         opt = true,
         config = function()
            require 'plugins.lsp.null-ls'
         end,
      }

      -- Completion, snippets
      use {
         'hrsh7th/nvim-cmp',
         requires = {
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
         config = function()
            require 'plugins.cmp'
         end,
      }

      -- Colorizer
      use {
         'norcalli/nvim-colorizer.lua',
         config = function()
            require('colorizer').setup()
         end,
      }

      -- Indent blankline
      use {
         'lukas-reineke/indent-blankline.nvim',
         event = 'User LoadPlugins',
         config = function()
            require('indent_blankline').setup {
               show_current_context = true,
               show_current_context_start = false,
               show_end_of_line = true,
               show_trailing_blankline_indent = false,
            }
            vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { link = 'Whitespace' }) -- All the lines
            vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { link = 'Function' }) -- Current place
         end,
      }

      -- Virtual colorcolumn
      use {
         'lukas-reineke/virt-column.nvim',
         event = 'User LoadPlugins',
         config = function()
            require('virt-column').setup {
               char = '│',
               virtcolumn = '',
            }
            vim.schedule(function()
               vim.cmd.VirtColumnRefresh()
            end)
         end,
      }

      use {
         'mfussenegger/nvim-dap',
         event = 'User LoadPlugins',
      }

      use {
         'rcarriga/nvim-dap-ui',
         event = 'User LoadPlugins',
         config = function()
            require 'plugins.dap'
         end,
      }

      return packer
   end)
end

function M.setup()
   M.check_packer()
   M.init_packer()
   return M.list_plugins()
end

return M