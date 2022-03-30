vim.o.termguicolors = true -- Enable colors in the terminal

vim.cmd('PackerLoad rose-pine')
vim.cmd([[
  try
    set background=dark
    colorscheme rose-pine
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])

vim.cmd('highlight PmenuSel blend=0') -- Make selected option in popup menu being solid color
vim.fn.matchadd('errorMsg', '\\s\\+$') -- Show trail character in red

-- :so $VIMRUNTIME/syntax/hitest.vim
local set_hl = require('csj.core.utils').set_hl
set_hl('Visual', { nocombine = true, reverse = true })
set_hl('Search', { fg = 'orange', bg = 'purple' })
set_hl('Number', { fg = '#ea9d34' })
set_hl('TSVariable', { fg = '#908caa' })
set_hl('TSFuncBuiltin', { fg = '#3e8fb0' })
set_hl('InactiveWindow', { bg = '#1f1d2e' }) -- 1f1d2e 15131e
set_hl('LineNr', { fg = '#44415a' })
set_hl('FoldColumn', { fg = '#44415a' })
set_hl('Folded', { fg = '#575279' })
set_hl('Comment', { italic = true, fg = '#575279' })
