require('nvim_comment').setup({
    marker_padding = true,
    comment_empty = false,
    create_mappings = true,
    line_mapping = 'gcc',
    operator_mapping = 'gc',
    hook = nil,
})

-- Keymappings
vim.api.nvim_set_keymap('n', '<Leader>c', ':CommentToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<Leader>c', ':\'<,\'>CommentToggle<CR>', {noremap = true, silent = true})
