local statusline = {}
local component = require('csj.core.statusline.components')

vim.api.nvim_set_hl(0, 'StatusLineAccent', { bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background, fg = vim.api.nvim_get_hl_by_name('Function', true).foreground })

function statusline.init()
   vim.opt.laststatus = 3

   return table.concat {
      '%#StatusLine#',
      component.lineinfo(),
      component.filepath(),
      '%#StatusLineAccent#', -- Change colors for the filename using the Function hl group
      component.filename(),
      '%#StatusLine#',
      '%=%', -- Put component in the right side
      component.vcs(),
   }
end

return statusline
