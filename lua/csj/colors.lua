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

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'orange', bg = '#21202e'})
vim.api.nvim_set_hl(0, 'MatchParen',   { bg = 'orange'})
vim.api.nvim_set_hl(0, 'Visual',       { nocombine = true, reverse = true })
vim.api.nvim_set_hl(0, 'Comment', { italic = true, bold = true, fg = '#66627d' })
