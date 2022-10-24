-- Enable builtin treesitter parsers, this also disables `syntax`.
vim.g.ts_highlight_lua = true

-- Disable builtins plugins.
vim.opt.loadplugins = false

-- Temporarily disable this settings.
vim.cmd.filetype "off"
vim.cmd.filetype "plugin indent off"
vim.opt.shadafile = "NONE"

vim.schedule(function()
   if not vim.opt.loadplugins:get() then
      vim.cmd "runtime! plugin/**/*.vim"
      vim.cmd "runtime! plugin/**/*.lua"
   end

   -- Enable them again.
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
      end, 30)
   else
      -- Manually call ftplugin.
      vim.defer_fn(function()
         vim.cmd.filetype "detect"
      end, 30)
   end

   vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("BufEnter", {})
      vim.api.nvim_exec_autocmds("UIEnter", {})
   end, 0)

   require "fractal.core"
end)
