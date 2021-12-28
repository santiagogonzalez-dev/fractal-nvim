local noon_afternoon = '18:00' -- After 6PM set dark mode
local nigth_morning = '09:00' -- Keep the dark mode till 9AM

local function set_colorscheme(time_of_the_day) -- If 'time' is true the function will return settings for a dark theme
    if time_of_the_day == true then
        -- Settings for a dark colorscheme
        vim.cmd([[
            try
                set background=dark
                colorscheme rose-pine
            catch /^Vim\%((\a\+)\)\=:E185/
                colorscheme default
            endtry
        ]])
    elseif time_of_the_day == false then
        -- Settings for a light colorscheme
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
end

local actual_time = os.date('%H:%M')

if (actual_time > noon_afternoon or actual_time < nigth_morning) then
    set_colorscheme(true)
elseif actual_time > nigth_morning then
    set_colorscheme(false)
end
