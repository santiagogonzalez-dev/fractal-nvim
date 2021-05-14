vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')
-- vim.cmd('inoremap <expr> <TAB> (\"\\<C-n>\")')
-- vim.cmd('inoremap <expr> <S-TAB> (\"\\<C-p>\")')

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- Invert number row to symbols
-- vim.api.nvim_set_keymap('i', '1', '!', {}) -- 1
-- vim.api.nvim_set_keymap('i', '2', '@', {}) -- 2
-- vim.api.nvim_set_keymap('i', '3', '#', {}) -- 3
-- vim.api.nvim_set_keymap('i', '4', '$', {}) -- 4
-- vim.api.nvim_set_keymap('i', '5', '%', {}) -- 5
-- vim.api.nvim_set_keymap('i', '6', '^', {}) -- 6
-- vim.api.nvim_set_keymap('i', '7', '&', {}) -- 7
-- vim.api.nvim_set_keymap('i', '8', '*', {}) -- 8
-- vim.api.nvim_set_keymap('i', '9', '(', {}) -- 9
-- vim.api.nvim_set_keymap('i', '0', ')', {}) -- 0

-- Invert symbols row to number
-- vim.api.nvim_set_keymap('i', '!', '1', {}) -- 1
-- vim.api.nvim_set_keymap('i', '@', '2', {}) -- 2
-- vim.api.nvim_set_keymap('i', '#', '3', {}) -- 3
-- vim.api.nvim_set_keymap('i', '$', '4', {}) -- 4
-- vim.api.nvim_set_keymap('i', '%', '5', {}) -- 5
-- vim.api.nvim_set_keymap('i', '^', '6', {}) -- 6
-- vim.api.nvim_set_keymap('i', '&', '7', {}) -- 7
-- vim.api.nvim_set_keymap('i', '*', '8', {}) -- 8
-- vim.api.nvim_set_keymap('i', '(', '9', {}) -- 9
-- vim.api.nvim_set_keymap('i', ')', '0', {}) -- 0
