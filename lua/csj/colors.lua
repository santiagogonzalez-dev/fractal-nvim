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
    highlight Visual guifg=nocombine gui=reverse " Colors in visual mode
    highlight MatchParen guibg=orange " Match parens in orange
    highlight PmenuSel blend=0 " Make selected option in popup menu being solid color
    highlight CursorLineNr guibg=#21202e guifg=orange " Make number on gutter in orange
    match errorMsg /\s\+$/ " Show trail character in red
]])
