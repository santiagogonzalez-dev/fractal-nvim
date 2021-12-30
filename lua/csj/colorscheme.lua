-- local noon_afternoon = '18:00' -- After 6PM set dark mode
-- local nigth_morning = '09:00' -- Keep the dark mode till 9AM
-- local actual_time = os.date('%H:%M')

-- if (actual_time >= noon_afternoon or actual_time <= nigth_morning) then
--     vim.cmd([[
--         set background=dark
--         colorscheme rose-pine
--     ]])
-- elseif actual_time > nigth_morning then
--     vim.g.rose_pine_variant = 'dawn'
--     vim.cmd([[
--         set background=light
--         colorscheme rose-pine
--     ]])
-- end

vim.cmd([[
    set background=dark
    colorscheme rose-pine
]])
