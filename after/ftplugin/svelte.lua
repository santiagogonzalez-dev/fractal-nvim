local tab_lenght = 2
vim.opt_local.tabstop = tab_lenght
vim.opt_local.shiftwidth = tab_lenght
vim.opt_local.colorcolumn = "80,100"
vim.opt_local.textwidth = 90

vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost', 'InsertLeave' }, {
   callback = function ()
      if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
         vim.api.nvim_command('silent update')
      end
   end
})
