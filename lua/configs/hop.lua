require('hop').setup({
	keys = 'aoeusnthlrcg,.p'
})

-- Keymappings
vim.api.nvim_set_keymap('n', '<Leader>m', ':HopPattern<CR>', {noremap = true, silent = true})
