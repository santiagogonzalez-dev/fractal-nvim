                               -- KEYMAPPINGS --

-- Leader key
vim.g.mapleader = ' '

-- Quick actions
vim.api.nvim_set_keymap('n', '<Leader>;', '$a;<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>:', '$a:<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>,', '$a,<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>x', ':xa<CR>', {noremap = true, silent = true})

-- Insert empty line without leaving normal mode
vim.api.nvim_set_keymap('n', '<Leader>o', 'o<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>O', 'O<Esc>', {noremap = true, silent = true})

-- Switch buffers using TAB and SHIFT-TAB
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', { noremap = true, silent = true })

-- Capitalize word under cursor
vim.api.nvim_set_keymap('n', '<C-C>', 'b~', {noremap = true, silent = true})

-- Move current block
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-j>', ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-k>', ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- Center searches
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- Execute buffer with node
vim.api.nvim_set_keymap('n', '<Leader>bn', ':w !node<CR>', { noremap = true, silent = true })  -- :!node %<CR>
vim.api.nvim_set_keymap('n', '<Leader>tn', ':terminal node %<CR>', { noremap = true, silent = true })

-- Reselect selection after shifting code block
vim.api.nvim_set_keymap('x', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '>', '>gv', { noremap = true, silent = true })

-- Toggle to show/hide searched terms
vim.api.nvim_set_keymap('n', '<C-N>', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- Yank until the end of line with Y
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Undo break points
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '!', '!<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '?', '?<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', ' ', ' <C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '_', '_<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<CR>', '<CR><C-g>u', {noremap = true, silent = true})

-- Toggle spell checking
vim.api.nvim_set_keymap('n', '<Leader>s', ':set spell!<CR>', {noremap = true, silent = true})

-- Move between windows
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', { noremap = true, silent = true })

-- Rearrange windows using arrows
vim.api.nvim_set_keymap('n', '<down>', ':wincmd J<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<left>', ':wincmd H<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<up>', ':wincmd K<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<right>', ':wincmd L<CR>', {noremap = true, silent = true})
