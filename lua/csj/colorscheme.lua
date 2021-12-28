if os.date('%H:%M') >= '18:00' then
    vim.cmd([[
        try
            set background=dark
            colorscheme rose-pine
        catch /^Vim\%((\a\+)\)\=:E185/
            colorscheme default
        endtry
    ]])
else
    vim.g.rose_pine_variant = 'dawn'
    vim.cmd([[
        try
            set background=light
            colorscheme rose-pine
        catch /^Vim\%((\a\+)\)\=:E185/
            colorscheme default
        endtry
    ]])
end

-- vim.cmd([[
--     try
--         set background=dark
--         colorscheme rose-pine
--     catch /^Vim\%((\a\+)\)\=:E185/
--         colorscheme default
--         set background=dark
--     endtry
-- ]])
