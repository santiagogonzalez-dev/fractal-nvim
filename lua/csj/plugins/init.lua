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
  -- Impatient
  use {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient').enable_profile()
    end,
  }

  use { 'nvim-lua/plenary.nvim', module = 'plenary' } -- Plenary
  use { 'metakirby5/codi.vim', cmd = 'Codi' } -- Codi
  use('wbthomason/packer.nvim') -- Packer
  use('tpope/vim-surround') -- Surround
  use('tpope/vim-repeat') -- Repeat

  -- Project
  use {
    'ahmedkhalf/project.nvim',
    opt = true,
    module = 'project',
    config = function()
      require('project_nvim').setup {
        detection_methods = { 'lsp', 'pattern' },
        patterns = { '.git', 'package.json', 'pom.xml', '.zshrc', 'wezterm.lua' },
        show_hidden = true, -- Show hidden files in telescope when searching for files in a project
      }
    end,
  }

  -- Colorscheme, Rosé Pine
  use {
    'rose-pine/neovim',
    as = 'rose-pine',
    -- opt = true,
    config = function()
      require('rose-pine').setup {
        dark_variant = 'main',
        -- dark_variant = 'moon',
        disable_italics = false,
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
      local cmp_ok, cmp = pcall(require, 'cmp')
      if not cmp_ok then
        return
      else
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
      end
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    opt = true,
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'Comment.nvim',
      },
    },
    config = function()
      require('csj.plugins.treesitter')
    end,
  }

  -- Completion and snippets
  use {
    'hrsh7th/nvim-cmp', -- The completion plugin
    opt = true,
    requires = {
      'hrsh7th/cmp-buffer', -- Buffer completion
      'hrsh7th/cmp-cmdline', -- Cmdline completion
      'hrsh7th/cmp-nvim-lsp', -- LSP completion
      'hrsh7th/cmp-nvim-lua', -- LSP completion for Lua
      'hrsh7th/cmp-path', -- Path completion
    },
    config = function()
      require('csj.plugins.cmp')
    end,
  }

  use {
    'L3MON4D3/LuaSnip', -- Snippet engine
    after = 'nvim-cmp',
    requires = {
      'rafamadriz/friendly-snippets', -- Additional snippets
      'saadparwaiz1/cmp_luasnip', -- Snippet completion
    },
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    opt = true,
    requires = {
      -- Neovim Language Server Installer
      {
        'williamboman/nvim-lsp-installer',
        config = function()
          require('csj.lsp.lsp-installer')
        end,
      },
      -- Null-LS
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require('csj.lsp.null-ls')
        end,
      },
    },
    config = function()
      require('csj.lsp')
    end,
  }

  -- Toggle term
  use {
    'akinsho/toggleterm.nvim',
    module = 'toggleterm',
    keys = [[<C-\>]],
    config = function()
      require('csj.plugins.toggleterm')
    end,
  }

  -- Git Signs
  use {
    'lewis6991/gitsigns.nvim',
    opt = true,
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('csj.plugins.gitsigns')
    end,
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    module = 'telescope',
    opt = true,
    requires = {
      'nvim-lua/plenary.nvim',
      'ahmedkhalf/project.nvim',
      {
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        after = 'telescope.nvim',
      },
    },
    config = function()
      require('csj.plugins.telescope')
    end,
  }

  -- Indent Blankline
  use {
    'lukas-reineke/indent-blankline.nvim',
    opt = true,
    config = function()
      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = false,
        show_end_of_line = true,
        show_trailing_blankline_indent = false,
        -- char = '',
        -- char = '▎',
        space_char_blankline = ' ',
        max_indent_increase = 1,
      }
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#393552' })
      -- vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#393552' })
      vim.cmd('IndentBlanklineRefresh')
    end,
  }

  -- Vim Hexokinase
  use {
    'RRethy/vim-hexokinase',
    opt = true,
    run = 'cd /home/st/.local/share/nvim/site/pack/packer/opt/vim-hexokinase && make hexokinase',
    config = function()
      vim.cmd('HexokinaseTurnOn')
    end,
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
