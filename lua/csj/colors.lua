vim.o.termguicolors = true -- Enable colors in the terminal

require('rose-pine').setup {
    dark_variant = 'main',
    disable_italics = true,
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
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'orange', bg = '#21202e' })
vim.api.nvim_set_hl(0, 'LineNr', { bold = true, fg = '#44415a' })
vim.api.nvim_set_hl(0, 'Comment', { italic = true, bold = true, fg = '#44415a' })
vim.api.nvim_set_hl(0, 'MatchParen', { bg = 'orange' })
vim.api.nvim_set_hl(0, 'Visual', { nocombine = true, reverse = true })
vim.api.nvim_set_hl(0, 'Search', { fg = 'orange', bg = 'purple' })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#2a283e' })
vim.api.nvim_set_hl(0, 'Number', { fg = 'orange' })
vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#393552' })
vim.api.nvim_set_hl(0, 'DiagnosticHeader', { fg = '#2cb27f', bold = true })
vim.api.nvim_set_hl(0, 'TSVariable', { fg = '#908caa' })
