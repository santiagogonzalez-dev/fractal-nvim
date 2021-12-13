vim.cmd([[
    try
        set background=dark
        colorscheme rose-pine
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
]])
