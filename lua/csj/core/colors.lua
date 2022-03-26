vim.o.termguicolors = true -- Enable colors in the terminal

require('rose-pine').setup {
  dark_variant = 'main',
  -- dark_variant = 'moon',
  disable_italics = false,
}

vim.cmd([[
  try
    set background=dark
    colorscheme rose-pine
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])

vim.cmd([[ highlight PmenuSel blend=0 ]]) -- Make selected option in popup menu being solid color
vim.cmd([[ match errorMsg /\s\+$/ ]]) -- Show trail character in red

-- :so $VIMRUNTIME/syntax/hitest.vim
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'orange', bg = '#21202e' }) -- 21202e 2a283e
vim.api.nvim_set_hl(0, 'Visual', { nocombine = true, reverse = true })
vim.api.nvim_set_hl(0, 'Search', { fg = 'orange', bg = 'purple' })
vim.api.nvim_set_hl(0, 'Number', { fg = '#ea9d34' })
vim.api.nvim_set_hl(0, 'TSVariable', { fg = '#908caa' })
-- vim.api.nvim_set_hl(0, 'TSFuncBuiltin', { fg = '#3e8fb0' })
vim.api.nvim_set_hl(0, 'InactiveWindow', { bg = '#1f1d2e' }) -- 1f1d2e 15131e
vim.api.nvim_set_hl(0, 'LineNr', { bold = true, fg = '#44415a' })
vim.api.nvim_set_hl(0, 'FoldColumn', { fg = '#44415a' })
vim.api.nvim_set_hl(0, 'Folded', { fg = '#575279' })
vim.api.nvim_set_hl(0, 'Comment', { italic = true, fg = '#575279' })
