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
  compile_path = vim.fn.stdpath('config') .. '/lua/csj/plugins/packer_compiled.lua', -- Path for packer_compiled.lua
  git = { clone_timeout = 360 },
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' } -- Have packer use a popup window
    end,
  },
}

return packer.startup(function(use)
  use('wbthomason/packer.nvim') -- Packer
  use { 'nvim-lua/plenary.nvim', module = 'plenary' } -- Plenary
  use { 'metakirby5/codi.vim', cmd = 'Codi' } -- Codi
  use('kyazdani42/nvim-web-devicons')

  -- Surround
  use {
    'kylechui/nvim-surround',
    event = 'User LoadPlugins',
    config = function()
      require('nvim-surround').setup()
    end,
  }

  -- Stay-in-place
  use {
    'gbprod/stay-in-place.nvim',
    keys = { '>', '>>', '<', '<<', '=', '==' },
    config = function()
      require('stay-in-place').setup()
    end,
  }

  -- Accelerated jk
  use {
    '~/workspace/accelerated-jk.nvim',
    keys = { 'j', 'k', 'w', 'b', '+', '-' },
    config = function()
      require('accelerated-jk').setup({
        enable_deceleration = true,
        acceleration_motions = { 'w', 'b', '+', '-' }
      })
      vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
      vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
    end,
  }

  -- Vim bufsurf
  use {
    'ton/vim-bufsurf',
    config = function()
      vim.cmd([[
        nmap ]b <Plug>(buf-surf-forward)
        nmap [b <Plug>(buf-surf-back)
      ]])
    end,
  }

  -- Dim unused functions, variables, parameters
  use {
    'zbirenbaum/neodim',
    event = 'LspAttach',
    config = function()
      require('neodim').setup {
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
      }
    end,
  }

  -- Impatient
  use {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient').enable_profile()
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
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    event = 'User LoadPlugins',
    run = ':TSUpdate',
    requires = {
      { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'Comment.nvim' },
      -- {
      --   'nvim-treesitter/playground',
      --   config = function()
      --     require('nvim-treesitter.configs').setup {
      --       playground = {
      --         enable = true,
      --         disable = {},
      --         updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      --         persist_queries = false, -- Whether the query persists across vim sessions
      --         keybindings = {
      --           toggle_query_editor = 'o',
      --           toggle_hl_groups = 'i',
      --           toggle_injected_languages = 't',
      --           toggle_anonymous_nodes = 'a',
      --           toggle_language_display = 'I',
      --           focus_language = 'f',
      --           unfocus_language = 'F',
      --           update = 'R',
      --           goto_node = '<cr>',
      --           show_help = '?',
      --         },
      --       },
      --     }
      --   end,
      -- },
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
      require('csj.plugins.telescope')
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
    config = function()
      require('csj.lsp')
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
      require('csj.lsp.null-ls')
    end,
  }

  -- LSP Lines, diagnostics
  use {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'LspAttach',
    config = function()
      require('lsp_lines').setup()
      vim.keymap.set('', '<Leader>l', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
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
      require('csj.plugins.cmp')
    end,
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
  return packer
end)
