local statusline = {}
local component = require('csj.core.statusline.components')

function statusline.init()
   vim.opt.laststatus = 3

   vim.api.nvim_set_hl(
      0,
      '1SP',
      { bg = vim.api.nvim_get_hl_by_name('StatusLine', true).foreground, fg = vim.api.nvim_get_hl_by_name('Visual', true).background }
   )
   vim.api.nvim_set_hl(
      0,
      '2SP',
      { bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background, fg = vim.api.nvim_get_hl_by_name('Visual', true).background }
   )
   vim.api.nvim_set_hl(
      0,
      '3SP',
      { bg = vim.api.nvim_get_hl_by_name('StatusLine', true).foreground, fg = vim.api.nvim_get_hl_by_name('StatusLine', true).background }
   )

   return table.concat {
      '%#1SP# ', -- Round separator
      '%#Visual#',
      component.lineinfo(),
      '%#2SP#', -- Round separator
      ' ',
      '%#StatusLine#',
      component.filepath(),
      component.filename(),
      '%#StatusLine#',
      '%=%', -- Put component in the right side
      component.vcs(),
      '%#3SP#', -- Round separator
      ' ',
   }
end

return statusline
