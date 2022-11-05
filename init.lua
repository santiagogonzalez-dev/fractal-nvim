local M = {}

vim.opt.loadplugins = false -- Disable builtin plugins
vim.g.ts_highlight_lua = true -- Enable treesitter parsers

-- Temporarily disable this settings.
vim.cmd.syntax "off"
vim.cmd.filetype "off"
vim.cmd.filetype "plugin indent off"
vim.opt.shadafile = "NONE"

function M.defer(fnc)
   return vim.defer_fn(fnc, 30)
end

function M.main()
   if not vim.opt.loadplugins:get() then
      vim.cmd "runtime! plugin/**/*.vim"
      vim.cmd "runtime! plugin/**/*.lua"
   end

   vim.cmd.syntax "on"
   vim.cmd.filetype "on"
   vim.cmd.filetype "plugin indent on"

   vim.opt.shadafile = ""
   vim.cmd.rshada({ bang = true })

   if vim.fn.filereadable(vim.fn.expand "%F") == 0 then
      M.defer(function()
         vim.api.nvim_exec_autocmds("BufNewFile", {})
      end)
   else
      M.defer(function()
         vim.cmd.filetype "detect" -- Manually call ftplugin.
      end)
   end

   M.defer(function()
      vim.api.nvim_exec_autocmds("BufEnter", {})
      vim.api.nvim_exec_autocmds("UIEnter", {})
   end)

   require "fractal.core"
end

M.defer(M.main)

return M
