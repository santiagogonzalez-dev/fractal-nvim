-- Default tab size, this is not applied if you specified a different one in
-- ftplugin
local tab_lenght = 4
vim.opt.shiftwidth = tab_lenght / 2 -- Size of a > or < when indenting
vim.opt.tabstop = tab_lenght -- Tab length

vim.api.nvim_create_autocmd('Filetype', {
   desc = "Open help and man pages in a vertical split if there's not enough space",
   pattern = { 'help', 'man' },
   callback = function()
      if (vim.opt.lines:get() * 4) < vim.opt.columns:get() then
         if not vim.w.help_is_moved or vim.w.help_is_moved ~= 'right' then
            vim.cmd.wincmd 'L'
            vim.w.help_is_moved = 'right'
         end
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
