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

vim.cmd([[ highlight PmenuSel blend=0 ]]) -- Make selected option in popup menu being solid color
vim.cmd([[ match errorMsg /\s\+$/ ]]) -- Show trail character in red

-- :so $VIMRUNTIME/syntax/hitest.vim
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'orange', bg = '#21202e' })
vim.api.nvim_set_hl(0, 'MatchParen', { bg = 'orange' })
vim.api.nvim_set_hl(0, 'Visual', { nocombine = true, reverse = true })
vim.api.nvim_set_hl(0, 'Search', { fg = 'orange', bg = 'purple' })
vim.api.nvim_set_hl(0, 'Comment', {
   italic = true,
   bold = true,
   -- fg = '#403d52',
   fg = '#66627d',
})
vim.api.nvim_set_hl(0, 'Number', { fg = 'orange' })
