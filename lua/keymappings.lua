-- KEYMAPPINGS --

local opts = { noremap = true, silent = true }
-- Quick actions
vim.api.nvim_set_keymap('n', '<Leader>;', '$a;<Esc>', opts)
vim.api.nvim_set_keymap('n', '<Leader>:', '$a:<Esc>', opts)
vim.api.nvim_set_keymap('n', '<Leader>,', '$a,<Esc>', opts)
vim.api.nvim_set_keymap('n', '<Leader>x', ':xa<CR>', opts)

-- Insert empty line without leaving normal mode
vim.api.nvim_set_keymap('n', '<Leader>o', 'o<Esc>', opts)
vim.api.nvim_set_keymap('n', '<Leader>O', 'O<Esc>', opts)

-- Switch buffers using TAB and SHIFT-TAB
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

-- May PageUp and PageDown
vim.api.nvim_set_keymap("n", "<PageUp>", ":bnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<PageDown>", ":bprev<CR>", opts)

-- Capitalize word under cursor
vim.api.nvim_set_keymap('n', '<C-C>', 'b~', opts)

-- Move current block
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', opts)
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>==', opts)
vim.api.nvim_set_keymap('x', '<C-j>', ":m '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap('x', '<C-k>', ":m '<-2<CR>gv-gv", opts)

-- Center searches
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)

-- Execute buffer with node
vim.api.nvim_set_keymap('n', '<Leader>bn', ':w !node<CR>', opts)  -- :!node %<CR>
vim.api.nvim_set_keymap('n', '<Leader>tn', ':terminal node %<CR>', opts)

-- Reselect selection after shifting code block
vim.api.nvim_set_keymap('x', '<', '<gv', opts)
vim.api.nvim_set_keymap('x', '>', '>gv', opts)

-- Toggle to show/hide searched terms
vim.api.nvim_set_keymap('n', '<C-N>', ':set hlsearch!<CR>', opts)

-- Yank until the end of line with Y
vim.api.nvim_set_keymap('n', 'Y', 'y$', opts)

-- Undo break points
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', opts)
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', opts)
vim.api.nvim_set_keymap('i', '!', '!<C-g>u', opts)
vim.api.nvim_set_keymap('i', '?', '?<C-g>u', opts)
vim.api.nvim_set_keymap('i', ' ', ' <C-g>u', opts)
vim.api.nvim_set_keymap('i', '_', '_<C-g>u', opts)
vim.api.nvim_set_keymap('i', '<CR>', '<CR><C-g>u', opts)

-- Toggle spell checking
vim.api.nvim_set_keymap('n', '<Leader>s', ':set spell!<CR>', opts)

-- Move between windows
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', opts)
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', opts)

-- Rearrange windows using arrows
vim.api.nvim_set_keymap('n', '<down>', ':wincmd J<CR>', opts)
vim.api.nvim_set_keymap('n', '<left>', ':wincmd H<CR>', opts)
vim.api.nvim_set_keymap('n', '<up>', ':wincmd K<CR>', opts)
vim.api.nvim_set_keymap('n', '<right>', ':wincmd L<CR>', opts)

-- Highlight line and create mark
vim.cmd([[ nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR> ]])
