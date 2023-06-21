-- Default tab size
vim.opt.shiftwidth = 2 -- Size of a > or < when indenting
vim.opt.tabstop = 4 -- Tab length
vim.api.nvim_create_autocmd('Filetype', {
   desc = "Open help and man pages in a vertical split if there's not enough space",
   pattern = { 'help', 'man' },
   callback = function()
      if vim.opt.lines:get() * 4 < vim.opt.columns:get() and not vim.w.help_is_moved then
         vim.cmd('wincmd L')
         vim.w.help_is_moved = true
      end
   end,
})

-- My own implementation of map
---@param tbl table
---@param func function
---@return table
map = function(tbl, func)
   local T = {}
   for k, v in pairs(tbl) do
      T[k] = func(k, v)
   end
   return T
end
