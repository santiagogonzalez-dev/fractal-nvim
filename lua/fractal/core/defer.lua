-- require "fractal.core.not"

-- Temporarily disable ftplugin and shadafile.
vim.cmd.filetype('off')
vim.cmd.filetype('plugin indent off')
vim.opt.shadafile = 'NONE'

-- PROFILING: About profiling, all the settings before this comment are going
-- to be run first, then everything under `plugins`, then `after/plugins`, and
-- lastly the main function will be scheduled and run so that we defer the load
-- of the config.
vim.schedule(function()
   if not vim.opt.loadplugins:get() then
      vim.cmd('runtime! plugin/**/*.vim')
      vim.cmd('runtime! plugin/**/*.lua')
   end

   -- Enable filetype settings and shadafile.
   vim.cmd.filetype('on')
   vim.cmd.filetype('plugin indent on')
   vim.opt.shadafile = ''
   vim.cmd.rshada({ bang = true })

   local buf_curr_path = vim.fn.expand('%F')
   if not require('fractal.utils').readable(buf_curr_path) then
      vim.defer_fn(
         function() vim.api.nvim_exec_autocmds('BufNewFile', {}) end,
         0
      )
   else
      vim.defer_fn(function() vim.cmd.filetype('detect') end, 0) -- Manually call ftplugin.
   end

   vim.defer_fn(function()
      vim.api.nvim_exec_autocmds('BufEnter', {})
      vim.api.nvim_exec_autocmds('UIEnter', {})
   end, 0)

   require('fractal.core')
end)
