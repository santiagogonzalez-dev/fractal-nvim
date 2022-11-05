vim.opt.loadplugins = false

vim.g.ts_highlight_lua = true

vim.cmd.syntax "off"
vim.cmd.filetype "off"
vim.cmd.filetype "plugin indent off"
vim.opt.shadafile = "NONE"

vim.schedule(function()
   if not vim.opt.loadplugins:get() then
      vim.cmd "runtime! plugin/**/*.vim"
      vim.cmd "runtime! plugin/**/*.lua"
   end

   vim.cmd.syntax "on"
   vim.cmd.filetype "on"
   vim.cmd.filetype "plugin indent on"

   vim.opt.shadafile = ""
   vim.cmd.rshada({ bang = true })

   if
      vim.fn.filereadable(
         vim.fn.expand(vim.api.nvim_eval_statusline("%F", {}).str)
      ) == 0
   then
      vim.api.nvim_exec_autocmds("BufNewFile", {})
   else
      -- vim.cmd.e() -- or vim.cmd.filetype 'detect' -- Load ftplugin.
      vim.defer_fn(function()
         vim.cmd.filetype "detect"
      end, 30)
   end

   vim.api.nvim_exec_autocmds("BufEnter", {})
   vim.api.nvim_exec_autocmds("UIEnter", {})

   require "fractal.core"
end)
