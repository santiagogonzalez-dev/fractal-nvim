vim.o.termguicolors = true -- Enable colors in the terminal

vim.cmd([[
   try
      set background=dark
      colorscheme rose-pine
   catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
      set background=dark
   endtry
]])

-- :so $VIMRUNTIME/syntax/hitest.vim
local set_hl = require('csj.core.utils').set_hl
vim.fn.matchadd('errorMsg', '\\s\\+$') -- Show trail character in red
set_hl('PmenuSel', { bg = '#313552', blend = 0 }) -- Make selected option in popup menu being solid color
set_hl('ColorColumn', {})
set_hl('Visual', { reverse = true })
set_hl('Search', { fg = 'orange', bg = 'purple' })
set_hl('Number', { italic = true, fg = '#ea9d34' })
set_hl('InactiveWindow', { bg = '#15131e' }) -- 1f1d2e 15131e
set_hl({ 'LineNr', 'StatusLine' }, { fg = '#44415a' })
set_hl('Folded', { fg = '#575279' })
set_hl('Comment', { italic = true, fg = '#575279' })

set_hl('TSVariable', { fg = '#908caa' })
-- set_hl('TSFuncBuiltin', { fg = '#3e8fb0' })

local identicalcursorline = vim.api.nvim_get_hl_by_name('CursorColumn', true)
set_hl('CursorLineNr', { bg = identicalcursorline.background })
