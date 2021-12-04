require('Comment').setup({
    padding = true,  -- Add a space b/w comment and the line
    sticky = true,  -- Whether the cursor should stay at its position
    ignore = '^$',  -- Lines to be ignored while comment/uncomment.
    mappings = {
        basic = true,
        extra = true,
        extended = false,
    },
    toggler = {
        line = 'gcc',
        block = 'gbc',
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    pre_hook = nil,
    post_hook = nil,
})

local ft = require('Comment.ft')
ft({'dosini', 'zsh', 'help'}, {'#%s'})
