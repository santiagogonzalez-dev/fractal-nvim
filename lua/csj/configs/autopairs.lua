-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, 'nvim-autopairs')
if not status_ok then
    return
end

npairs.setup({
    check_ts = true,
    ts_config = {
        javascript = { 'template_string' },
        java = false, -- There's some problems with java and treesitter, disabled for now
    },
    enable_check_bracket_line = true, -- Check for closing brace so it will not add a close pair
    fast_wrap = {
        map = '<C-f>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        offset = -1, -- Offset from pattern match, with -1 you can insert before the comma
        keys = 'aoeusnthdiqjkzvwmbxlrcgp', -- Because I use dvorak BTW
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
    },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    return
end
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
