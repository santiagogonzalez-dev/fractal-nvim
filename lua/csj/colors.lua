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
    " highlight Normal guibg=NONE ctermbg=NONE " Transparent background
    highlight NvimTreeNormal guibg=#26233A " Change NvimTreeNormal background color
    " highlight NvimTreeNormal guibg=NONE ctermbg=NONE
    highlight HopNextKey guifg=orange gui=nocombine " Hop orange colors
    highlight Visual guifg=nocombine gui=reverse " Colors in visual mode
    highlight MatchParen guibg=orange " Match parens in orange
    highlight IndentBlanklineContextChar guifg=#c4a7e7 gui=nocombine
    highlight iCursor guifg=nocombine guibg=orange " Insert cursor color orange
    highlight PmenuSel blend=0 " Make selected option in popup menu being solid color
    match errorMsg /\s\+$/ " Show trail character in red
]])
