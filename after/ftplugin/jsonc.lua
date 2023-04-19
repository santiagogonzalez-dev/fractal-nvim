local tab_lenght = 2
vim.opt_local.tabstop = tab_lenght
vim.opt_local.shiftwidth = tab_lenght
vim.opt_local.colorcolumn = '80,120'
vim.opt_local.textwidth = 80
vim.opt_local.conceallevel = 2

-- Add trailing comma
vim.keymap.set('n', 'o', function()
   local line = vim.api.nvim_get_current_line()

   local should_add_comma = string.find(line, '[^,{[]$')
   if should_add_comma then
      return 'A,<cr>'
   else
      return 'o'
   end
end, { buffer = true, expr = true })
