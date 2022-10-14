local M = {}
local utils = require('fractal.utils')
local packer_compiled_path = string.format(
   '%s%s',
   vim.fn.stdpath('config'),
   '/user/plugins/packer_compiled.lua'
)
local packer

function M.packer_load()
   vim.cmd.packadd('packer.nvim')
   packer = require('packer')
end

function M.packer() return packer end

function M.check_packer()
   local packer_installed = utils.is_installed('opt/packer.nvim')
   local plugins_dir =
      string.format('%s%s', vim.fn.stdpath('data'), '/site/pack/packer') -- /home/user/.local/share/nvim/site/pack/packer
   if not packer_installed then
      vim.fn.delete(packer_compiled_path) -- Delete the packer_compiled

      -- Clone packer
      vim.fn.system({
         'git',
         'clone',
         '--depth',
         '1',
         'https://github.com/wbthomason/packer.nvim',
         plugins_dir .. '/opt/packer.nvim',
      })

      -- vim.notify 'Installing packer.nvim, open neovim again and run :PackerSync'
      M.packer_load()
   else
      M.packer_load()
   end
end

function M.init_packer()
   packer.init({
      compile_path = packer_compiled_path, -- Path for packer_compiled.lua
      git = { clone_timeout = 360 },
      display = {
         open_fn = function()
            return require('packer.util').float({ border = 'rounded' }) -- Have packer use a popup window
         end,
      },
   })
end

function M.list_plugins()
   return packer.startup(function(use)
      -- Packer
      use({
         'wbthomason/packer.nvim',
         commit = '6afb67460283f0e990d35d229fd38fdc04063e0a',
         opt = true,
      })

      use('kyazdani42/nvim-web-devicons')

      -- Plenary
      use({
         'nvim-lua/plenary.nvim',
         commit = '4b7e52044bbb84242158d977a50c4cbcd85070c7',
         module = 'plenary',
      })

      -- Surround
      use({
         'kylechui/nvim-surround',
         tag = 'v1.0.0',
         event = 'User LoadPlugins',
         config = function() require('nvim-surround').setup() end,
      })

      -- Accelerated jk
      use({
         'rainbowhxch/accelerated-jk.nvim',
         commit = '38bbbf9258aab876906588ea979901ed3ed569c6',
         keys = { 'j', 'k', 'w', 'b', '+', '-' },
         config = function()
            require('accelerated-jk').setup({
               enable_deceleration = true,
               acceleration_motions = { 'w', 'b', '+', '-' },
            })
            vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
            vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
         end,
      })

      -- Project
      use({
         'ahmedkhalf/project.nvim',
         commit = '628de7e433dd503e782831fe150bb750e56e55d6',
         module = 'project',
         opt = true,
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
      })

      -- Comment
      use({
         'numToStr/Comment.nvim',
         commit = 'd9cfae1059b62f7eacc09dba181efe4894e3b086',
         keys = {
            'gcc',
            'gc',
            'gcb',
            'gb',
         },
         config = function()
            require('Comment').setup({
               padding = true,
               sticky = true,
               ignore = '^$',
               mappings = {
                  basic = true,
                  extra = true,
                  extended = true,
               },
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
            require('Comment.ft')({ 'dosini', 'zsh', 'help' }, { '#%s' })
         end,
      })

      -- Autopairs
      use({
         'windwp/nvim-autopairs',
         commit = 'a5b27c51def41297aaa60272150b6bbeeed6a448',
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
      })

      -- Treesitter
      use({
         'nvim-treesitter/nvim-treesitter',
         commit = 'aebc6cf6bd4675ac86629f516d612ad5288f7868',
         event = 'User LoadPlugins',
         run = ':TSUpdate',
         requires = {
            {
               'JoosepAlviste/nvim-ts-context-commentstring',
               commit = '4d3a68c41a53add8804f471fcc49bb398fe8de08',
               after = 'Comment.nvim',
            },
            {
               'nvim-treesitter/nvim-treesitter-textobjects',
               commit = '41e8d8964e5c874d9ce5e37d00a52f37f218502e',
               after = 'nvim-treesitter',
               config = function()
                  require('nvim-treesitter.configs').setup({
                     textobjects = {
                        select = {
                           enable = true,

                           -- Automatically jump forward to textobj, similar to targets.vim
                           lookahead = true,

                           keymaps = {
                              -- You can use the capture groups defined in textobjects.scm
                              ['af'] = '@function.outer',
                              ['if'] = '@function.inner',
                              ['ac'] = '@class.outer',
                              -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
                              ['ic'] = {
                                 query = '@class.inner',
                                 desc = 'Select inner part of a class region',
                              },
                           },
                           -- You can choose the select mode (default is charwise 'v')
                           selection_modes = {
                              ['@parameter.outer'] = 'v', -- charwise
                              ['@function.outer'] = 'V', -- linewise
                              ['@class.outer'] = '<c-v>', -- blockwise
                           },
                           -- If you set this to `true` (default is `false`) then any textobject is
                           -- extended to include preceding xor succeeding whitespace. Succeeding
                           -- whitespace has priority in order to act similarly to eg the built-in
                           -- `ap`.
                           include_surrounding_whitespace = false,
                        },
                     },
                  })
               end,
            },
            {
               'nvim-treesitter/playground',
               commit = 'e6a0bfaf9b5e36e3a327a1ae9a44a989eae472cf',
               cmd = { 'TSHighlightCapturesUnderCursor', 'TSPlaygroundToggle' },
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
               end,
            },
         },
         config = function() require('plugins.treesitter') end,
      })

      -- GitSigns
      use({
         'lewis6991/gitsigns.nvim',
         tag = 'v0.5',
         event = 'User IsGit',
         requires = 'nvim-lua/plenary.nvim',
         config = function() require('plugins.gitsigns') end,
      })

      -- Telescope
      use({
         'nvim-telescope/telescope.nvim',
         commit = '76ea9a898d3307244dce3573392dcf2cc38f340f',
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
            vim.cmd('PackerLoad project.nvim')
            require('plugins.telescope')
         end,
      })

      -- Right Corner Diagnostics
      use({
         'santigo-zero/right-corner-diagnostics.nvim',
         event = 'LspAttach',
         config = function() require('rcd').setup({ position = 'bottom' }) end,
      })

      -- Colorizer
      use({
         'NvChad/nvim-colorizer.lua',
         commit = '9dd7ecde55b06b5114e1fa67c522433e7e59db8b',
         event = 'BufEnter',
         config = function() require('colorizer').setup() end,
      })

      -- JetJBP
      use('santigo-zero/jetjbp.nvim')

      -- Neodim
      use({
         'zbirenbaum/neodim',
         commit = 'cf7e00fde692f1a97ff606a9cff3472d217f677e',
         event = 'LspAttach',
         config = function()
            require('neodim').setup({
               alpha = 0.75,
               blend_color = '#000000',
               update_in_insert = {
                  enable = true,
                  delay = 100,
               },
               hide = {
                  virtual_text = true,
                  signs = true,
                  underline = true,
               },
            })
         end,
      })

      -- Indent blankline
      use({
         'lukas-reineke/indent-blankline.nvim',
         commit = 'db7cbcb40cc00fc5d6074d7569fb37197705e7f6',
         event = 'User LoadPlugins',
         config = function()
            require('indent_blankline').setup({
               show_current_context = true,
               show_current_context_start = false,
               show_end_of_line = true,
               show_trailing_blankline_indent = false,
            })
            vim.api.nvim_set_hl(
               0,
               'IndentBlanklineChar',
               { link = 'Whitespace' }
            ) -- All the lines
            vim.api.nvim_set_hl(
               0,
               'IndentBlanklineContextChar',
               { link = 'Function' }
            ) -- Current place
         end,
      })

      -- Virtual colorcolumn
      use({
         'lukas-reineke/virt-column.nvim',
         tag = 'v1.5.4',
         event = 'User LoadPlugins',
         config = function()
            require('virt-column').setup({
               char = '│',
               virtcolumn = '',
            })
            vim.schedule(function() vim.cmd.VirtColumnRefresh() end)
         end,
      })

      -- LSP
      use({
         'neovim/nvim-lspconfig',
         commit = 'af43c300d4134db3550089cd4df6c257e3734689',
         event = 'User LoadPlugins',
         config = function() require('plugins.lsp') end,
      })

      -- Mason
      use({
         'williamboman/mason.nvim',
         commit = '53e419ce550b1bf37605d48d9f226143590e07ea',
         opt = true,
      })

      -- Mason Lsp Installer
      use({
         'williamboman/mason-lspconfig.nvim',
         commit = '0051870dd728f4988110a1b2d47f4a4510213e31',
         opt = true,
      })

      -- Null-LS
      use({
         'jose-elias-alvarez/null-ls.nvim',
         commit = 'c0c19f32b614b3921e17886c541c13a72748d450',
         opt = true,
         config = function() require('plugins.lsp.null-ls') end,
      })

      -- Completion, snippets
      use({
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
         config = function() require('plugins.cmp') end,
      })

      -- DAP
      use({
         'mfussenegger/nvim-dap',
         commit = '0b320f5bd4e5f81e8376f9d9681b5c4ee4483c25',
         event = 'User LoadPlugins',
         requires = {
            {
               'rcarriga/nvim-dap-ui',
               event = 'User LoadPlugins',
            },
         },
         config = function() require('plugins.dap') end,
      })

      -- JDTLS
      use({
         'mfussenegger/nvim-jdtls',
         commit = '75d27daa061458dd5735b5eb5bbc48d3baad1186',
         event = 'User LoadPlugins',
      })

      -- LSP Inlay Hints
      use({
         'lvimuser/lsp-inlayhints.nvim',
         commit = '9bcd6fe25417b7808fe039ab63d4224f2071d24a',
         event = 'User LoadPlugins',
         config = function()
            require('lsp-inlayhints').setup()
            vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
            vim.api.nvim_create_autocmd('LspAttach', {
               group = 'LspAttach_inlayhints',
               callback = function(args)
                  if not (args.data and args.data.client_id) then return end

                  local bufnr = args.buf
                  local client = vim.lsp.get_client_by_id(args.data.client_id)
                  require('lsp-inlayhints').on_attach(client, bufnr)
               end,
            })
         end,
      })

      -- Semantic Tokens
      use({
         'theHamsta/nvim-semantic-tokens',
         commit = '7e8dca30692af9c87cc6acb7107b44db0d71eb90',
         event = 'User LoadPlugins',
         config = function()
            require('nvim-semantic-tokens').setup({
               preset = 'default',
               highlighters = {
                  require('nvim-semantic-tokens.table-highlighter'),
               },
            })
         end,
      })
   end)
end

function M.setup()
   M.check_packer()
   M.init_packer()
   return M.list_plugins()
end

return M
