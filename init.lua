-- Disable builtin plugins.
vim.opt.loadplugins = false

vim.g.loaded_2html_plugin = false
vim.g.loaded_bugreport = false
vim.g.loaded_compiler = false
vim.g.loaded_getscript = false
vim.g.loaded_getscriptPlugin = false
vim.g.loaded_gzip = false
vim.g.loaded_logiPat = false
vim.g.loaded_logipat = false
vim.g.loaded_man = false
vim.g.loaded_matchParen = false
vim.g.loaded_matchit = false
vim.g.loaded_netrwFileHandlers = false
vim.g.loaded_netrwSettings = false
vim.g.loaded_optwin = false
vim.g.loaded_perl_provider = false
vim.g.loaded_rplugin = false
vim.g.loaded_rrhelper = false
vim.g.loaded_spec = false
vim.g.loaded_synmenu = false
vim.g.loaded_syntax = false
vim.g.loaded_tar = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_tutor = false
vim.g.loaded_vimball = false
vim.g.loaded_vimballPlugin = false
vim.g.loaded_zip = false
vim.g.loaded_zipPlugin = false

-- Disable language providers.
vim.g.loaded_python3_provider = false
vim.g.loaded_node_provider = false
vim.g.loaded_ruby_provider = false
vim.g.loaded_perl_provider = false

-- Temporarily disable ftplugin and shadafile.
vim.cmd.filetype "off"
vim.cmd.filetype "plugin indent off"
vim.opt.shadafile = "NONE"

-- Enable bundled treesitter parsers, this also turns off `syntax`.
-- https://github.com/neovim/neovim/issues/14090#issuecomment-1237820552
vim.g.ts_highlight_lua = true

-- PROFILING: About profiling, all the settings before this comment are going
-- to be run first, then everything under `plugins`, then `after/plugins`, and
-- lastly the main function will be scheduled and run so that we defer the load
-- of the config.
vim.schedule(function()
   if not vim.opt.loadplugins:get() then
      vim.cmd "runtime! plugin/**/*.vim"
      vim.cmd "runtime! plugin/**/*.lua"
   end

   -- Enable filetype settings and shadafile.
   vim.cmd.filetype "on"
   vim.cmd.filetype "plugin indent on"
   vim.opt.shadafile = ""
   vim.cmd.rshada({ bang = true })

   local curr_buf = vim.fn.expand "%F"
   local utils = require "fractal.utils"
   if not utils.readable(curr_buf) then
      -- Manually trigger autocmd, necessary for skeletons.
      vim.defer_fn(function()
         vim.api.nvim_exec_autocmds("BufNewFile", {})
      end, 0)
   else
      -- Manually call ftplugin.
      vim.defer_fn(function()
         vim.cmd.filetype "detect"
      end, 0)
   end

   vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("BufEnter", {})
      vim.api.nvim_exec_autocmds("UIEnter", {})
   end, 0)

   require "fractal.core"
end)
