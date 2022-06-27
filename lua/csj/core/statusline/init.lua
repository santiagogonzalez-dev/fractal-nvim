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
      '%#StatusLineAccentBlue#',
      component.filename(),
      '%#StatusLine#',
      ' ',
      component.filewritable(),
      '%=%', -- Put component in the right side
      component.vcs(),
   }
end

return statusline
