require('nvim-autopairs').setup({
    check_ts = true,
    ts_config = {
        javascript = { 'template_string' },
        java = false,  -- There's some problems with java and treesitter, disabled for now
    },
    enable_check_bracket_line = true,  -- Check for closing brace so it will not add a close pair
    fast_wrap = {
        map = '<C-f>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', '' ),
        offset = -1,  -- Offset from pattern match, with -1 you can insert before the comma
    end_key = '$',
    keys = 'aoeusnthdiqjkzvwmbxlrcgp',  -- Because I use dvorak BTW
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment'
},
})

require('cmp').event:on( 'confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
