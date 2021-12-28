-- Some notes: The hour is going to be determined by the first 4 characters, so for 04:00 PM you would use 1600000000,
-- and you need to set the numbers to be exactly 10 characters long, since os.time() returns that, to change it exactly
-- you would need to print on the command mode this :lua lua print(os.time()).  The logic would be something like, if
-- the time of the OS is above the value that you gave then it will set neovim to the dark mode, in this example I use
-- the rose-pine colorscheme

if os.time() >= 1800000000 then
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
