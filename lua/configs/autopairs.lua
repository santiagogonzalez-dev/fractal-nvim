require('nvim-autopairs').setup({
    check_ts = true,
    ts_config = {
        javascript = { 'template_string' },
        java = false,
    },
    enable_check_bracket_line = false,
})

-- require('nvim-autopairs.completion.cmp').setup {
--     map_cr = true, --  map <CR> on insert mode
--     map_complete = true, -- it will auto insert `(` after select function or method item
--     auto_select = true, -- automatically select the first item
-- }
