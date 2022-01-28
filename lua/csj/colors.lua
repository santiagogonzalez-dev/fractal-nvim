vim.g.rose_pine_variant = 'base'
vim.g.rose_pine_disable_italics = true

vim.cmd([[
    try
        set background=dark
        colorscheme rose-pine
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
]])

vim.cmd([[
    highlight NvimTreeNormal guibg=#26233A " Change NvimTreeNormal background color
    highlight HopNextKey guifg=orange gui=nocombine " Hop orange colors
    highlight Visual guifg=nocombine gui=reverse " Colors in visual mode
    highlight MatchParen guibg=orange " Match parens in orange
    highlight IndentBlanklineContextChar guifg=#c4a7e7 gui=nocombine
    highlight iCursor guifg=nocombine guibg=orange " Insert cursor color orange
    highlight PmenuSel blend=0 " Make selected option in popup menu being solid color
    highlight CursorColumn guibg=#1f1d2e
    highlight CursorLine guibg=#1f1d2e
    highlight ColorColumn guibg=#26233a
    highlight CursorLineSign guibg=#1f1d2e
    highlight CursorLineNr guibg=#1f1d2e
    match errorMsg /\s\+$/ " Show trail character in red
]])
