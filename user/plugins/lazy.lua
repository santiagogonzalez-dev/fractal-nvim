local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
   { "kyazdani42/nvim-web-devicons" },
   { "nvim-lua/plenary.nvim" },

   -- Surround
   {
      "kylechui/nvim-surround",
      event = "User FractalEnd",
      config = function()
         require("nvim-surround").setup()
      end,
   },

   -- Accelerated jk
   {
      "rainbowhxch/accelerated-jk.nvim",
      keys = { "j", "k", "w", "b", "+", "-" },
      config = function()
         require("accelerated-jk").setup({
            enable_deceleration = true,
            acceleration_motions = { "w", "b", "+", "-" },
         })
         vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
         vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
      end,
   },

   -- Indent Blankline
   {
      "lukas-reineke/indent-blankline.nvim",
      event = "User FractalEnd",
      config = function()
         require("indent_blankline").setup({
            show_current_context = true,
            show_current_context_start = false,
            show_end_of_line = true,
            show_trailing_blankline_indent = false,
         })
         -- vim.api.nvim_set_hl(
         --    0,
         --    "IndentBlanklineChar",
         --    { link = "Whitespace" }
         -- ) -- All the lines
         -- vim.api.nvim_set_hl(
         --    0,
         --    "IndentBlanklineContextChar",
         --    { link = "Function" }
         -- ) -- Current place
      end,
   },

   -- Project
   {
      "ahmedkhalf/project.nvim",
      module = true,
      config = function()
         require("project_nvim").setup({
            detection_methods = { "lsp", "pattern" },
            patterns = {
               ".git",
               "package.json",
               "pom.xml",
               ".zshrc",
               "wezterm.lua",
            },
            show_hidden = true, -- Show hidden files in telescope when searching for files in a project
         })
      end,
   },
   {
      "numToStr/Comment.nvim",
      event = "User FractalEnd",
      config = function()
         require("Comment").setup()
      end,
   },

   -- Autopairs
   {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
         require("nvim-autopairs").setup({
            check_ts = true,
            ts_config = { javascript = { "template_string" } },
            disable_filetype = { "TelescopePrompt" },
            enable_afterquote = false, -- To use bracket pairs inside quotes
            enable_check_bracket_line = true, -- Check for closing brace so it will not add a close pair
            disable_in_macro = false,
            fast_wrap = {
               map = "<C-f>",
               chars = { "{", "[", "(", '"', "'", "<" },
               pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
               offset = -1, -- Offset from pattern match, with -1 you can insert before the comma
               keys = "aosenuth", -- Because I use dvorak BTW
               check_comma = true,
               highlight = "Search",
               highlight_grey = "IncSearch",
            },
         })
      end,
   },

   -- Treesitter
   {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = "User FractalEnd",
      dependencies = {
         {
            "nvim-treesitter/nvim-treesitter-context",
            config = function()
               require("treesitter-context").setup()
            end,
         },
         {
            "JoosepAlviste/nvim-ts-context-commentstring",
            module = true,
         },
         {
            "nvim-treesitter/nvim-treesitter-textobjects",
            config = function()
               require("nvim-treesitter.configs").setup({
                  textobjects = {
                     select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                           -- You can use the capture groups defined in textobjects.scm
                           ["af"] = "@function.outer",
                           ["if"] = "@function.inner",
                           ["ac"] = "@class.outer",
                           -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
                           ["ic"] = {
                              query = "@class.inner",
                              desc = "Select inner part of a class region",
                           },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        selection_modes = {
                           ["@parameter.outer"] = "v", -- charwise
                           ["@function.outer"] = "V", -- linewise
                           ["@class.outer"] = "<c-v>", -- blockwise
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
            "nvim-treesitter/playground",
            cmd = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" },
            keys = "<Leader>tsh",
            config = function()
               require("nvim-treesitter.configs").setup({
                  playground = {
                     enable = true,
                     disable = {},
                     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                     persist_queries = false, -- Whether the query persists across vim sessions
                     keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                     },
                  },
               })
               vim.keymap.set(
                  "n",
                  "<Leader>tsh",
                  ":TSHighlightCapturesUnderCursor<CR>"
               )
            end,
         },
      },
      config = function()
         require "plugins.treesitter"
      end,
   },

   -- Git Signs
   {
      "lewis6991/gitsigns.nvim",
      event = "User IsGit",
      config = function()
         require "plugins.gitsigns"
      end,
   },

   -- Telescope
   {
      "nvim-telescope/telescope.nvim",
      keys = {
         "<Leader>gr",
         "<Leader>t/",
         "<Leader>t//",
         "<Leader>tf",
         "<Leader>tg",
         "<Leader>tp",
         "<Leader>tt",
      },
      config = function()
         require "plugins.telescope"
      end,
   },

   -- JetJBP colorscheme
   {
      -- url = "santigo-zero/jetjbp.nvim",
      dir = "~/workspace/repositories/jetjbp.nvim",
      dev = true,
      lazy = true,
      config = function()
         vim.api.nvim_set_hl(0, "@variable", { fg = "#74749C" })
      end,
   },

   -- Nvim lspconfig
   {
      "neovim/nvim-lspconfig",
      config = function()
         require "plugins.lsp"
      end,
   },

   -- Mason
   {
      "williamboman/mason.nvim",
      event = "User FractalEnd",
   },

   -- Mason lspconfig
   {
      "williamboman/mason-lspconfig.nvim",
      event = "User FractalEnd",
   },

   -- Null LS
   {
      "jose-elias-alvarez/null-ls.nvim",
      event = "User FractalEnd",
      config = function()
         require "plugins.lsp.null-ls"
      end,
   },

   -- CMP
   {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
         "saadparwaiz1/cmp_luasnip",
         "rafamadriz/friendly-snippets",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "L3MON4D3/LuaSnip",
      },
      config = function()
         require "plugins.cmp"
      end,
   },

   -- Impatient
   {
      "lewis6991/impatient.nvim",
      config = function()
         require("impatient").enable_profile()
      end,
   },
}

require("lazy").setup(plugins)
