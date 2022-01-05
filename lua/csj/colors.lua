vim.g.rose_pine_variant = 'base'

vim.cmd([[
    set background=dark
    colorscheme rose-pine
]])

vim.cmd([[
    highlight NvimTreeNormal guibg=#26233A " Change NvimTreeNormal background color
    highlight HopNextKey guifg=orange gui=nocombine " Hop orange colors
    highlight Visual guifg=nocombine gui=reverse " Colors in visual mode
    highlight PmenuSel blend=0 " Make selected option in popup menu being solid color
    highlight iCursor guifg=nocombine guibg=orange " Insert cursor color orange
    highlight MatchParen guibg=orange " Match parens in orange
    match errorMsg /\s\+$/ " Show trail character in red
    " highlight Normal guibg=NONE ctermbg=NONE " Transparent background
]])
