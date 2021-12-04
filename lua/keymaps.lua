local keymap = vim.api.nvim_set_keymap
local nore_sil = { noremap = true, silent = true }
local nore_exp_sil = { noremap = true, expr = true, silent = true }

-- Modes
--    normal_mode = "n",
--    insert_mode = "i",
--    visual_mode = "v",
--    visual_block_mode = "x",
--    term_mode = "t",
--    command_mode = "c",

-- Avoid moving the cursor with space, enter or backspace when in normal mode
keymap('n', '<Space>', '<Nop>', nore_sil)
keymap('n', '<Cr>', '<Nop>', nore_sil)
keymap('n', '<Bs>', '<Nop>', nore_sil)

-- Semicolon
keymap('n', '<Leader>;', '$a;<Esc>', nore_sil)

-- Colon
keymap('n', '<Leader>:', '$a:<Esc>', nore_sil)

-- Backslash
keymap('n', '<Leader>\\', '$a \\<Esc>', nore_sil)

-- Comma
keymap('n', '<Leader>,', '$a,<Esc>', nore_sil)
keymap('v', '<Leader>,', ":'<,'>norm A,<Cr>", nore_sil)

-- Dot
keymap('n', '<Leader>.', '$a.<Esc>', nore_sil)

-- Write and reload the file
keymap('n', '<Leader>e', ':w | :e%<Cr>zz', nore_sil)

-- Toggle spell checking
keymap('n', '<Leader>s', ':set spell!<Cr>', nore_sil)

-- Highlight toggle for searched words
keymap('n', '<Leader>n', ':set hlsearch!<Cr>', nore_sil)

-- Toggle cursor line and column
keymap('n', '<Leader>c', ':set cul! cuc!<Cr>', nore_sil)

-- Toggle cursor line and column
keymap('n', '<Leader>sk', ':read ~/.config/nvim/skeletons/', nore_sil)

-- Quit all buffers
keymap('n', '<Leader>q', ':bufdo bdelete<Cr>', nore_sil)

-- Close buffer
keymap('n', '<Leader>bw', ':bw<Cr>', nore_sil)

-- Write buffer
keymap('n', '<Leader>w', ':w<Cr>', nore_sil)

-- Write buffers as sudo
keymap('n', '<Leader>W', '%!sudo tee > /dev/null %', nore_sil)

-- Write to all buffers and quit
keymap('n', '<Leader>x', ':xa<Cr>', nore_sil)

-- Go gf to open non-existing files
keymap('n', 'gf', ':edit <cfile><Cr>', nore_sil)

-- Move between windows with
keymap('n', '<A-h>', '<C-w>h', nore_sil)
keymap('n', '<A-l>', '<C-w>l', nore_sil)
keymap('n', '<A-j>', '<C-w>j', nore_sil)
keymap('n', '<A-k>', '<C-w>k', nore_sil)

-- Move current block
keymap('n', '<C-j>', ':m .+1<Cr>==', nore_sil)
keymap('n', '<C-k>', ':m .-2<Cr>==', nore_sil)
keymap('x', '<C-j>', ":m '>+1<Cr>gv-gv", nore_sil)
keymap('x', '<C-k>', ":m '<-2<Cr>gv-gv", nore_sil)

-- Center commands
keymap('n', 'n', 'nzzzv', nore_sil)
keymap('n', 'N', 'Nzzzv', nore_sil)
keymap('v', 'y', 'myy`y', nore_sil)
keymap('v', 'Y', 'myY`y', nore_sil)
keymap('v', 'J', 'mzJ`z', nore_sil)

-- Keep visual selection after shifting code block
keymap('x', '<', '<gv', nore_sil)
keymap('x', '>', '>gv', nore_sil)

-- Navigate buffers using TAB and SHIFT-TAB
keymap('n', '<Tab>', ':bnext<Cr>', nore_sil)
keymap('n', '<S-Tab>', ':bprevious<Cr>', nore_sil)

-- Naviagate buffers SHIFT-L SHIFT-H
keymap('n', '<S-l>', ':bnext<CR>', nore_sil)
keymap('n', '<S-h>', ':bprevious<CR>', nore_sil)


-- Undo break points
keymap('i', ',', ',<C-g>u', nore_sil)
keymap('i', '.', '.<C-g>u', nore_sil)
keymap('i', '!', '!<C-g>u', nore_sil)
keymap('i', '?', '?<C-g>u', nore_sil)
keymap('i', ' ', ' <C-g>u', nore_sil)
keymap('i', '_', '_<C-g>u', nore_sil)
keymap('i', '-', '-<C-g>u', nore_sil)
keymap('i', '=', '=<C-g>u', nore_sil)
keymap('i', '<Cr>', '<Cr><C-g>u', nore_sil)

-- Better navigation inside wrapped text
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", nore_exp_sil)
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", nore_exp_sil)

-- Highlight last pasted code with gvp
vim.cmd([[ nnoremap <expr> gvp '`[' . strpart(getregtype(), 0, 1) . '`]' ]])

-- Menu navigation
keymap('c', '<C-j>',  'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } )
keymap('c', '<C-k>',  'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } )
