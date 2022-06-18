local statusline = {}
local component = require('csj.core.statusline.components')

function statusline.init()
   vim.opt.laststatus = 3

   return table.concat {
      '%#StatusLineAccent#',
      component.lineinfo(),
      '%#StatusLine#',
      ' ',
      component.filepath(),
      component.filename(),
      '%=%', -- Put component in the right side
      component.vcs(),
   }
end

return statusline
