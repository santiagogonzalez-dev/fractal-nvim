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

-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Avoid moving the cursor with space, enter or backspace when in normal mode
keymap('n', '<Space>', '<Nop>', nore_sil)
keymap('n', '<Cr>', '<Nop>', nore_sil)
keymap('n', '<Bs>', '<Nop>', nore_sil)

-- Semicolon
keymap('n', '<Leader>;', '$a;<Esc>', nore_sil)
keymap('v', '<Leader>;', ":'<,'>norm A;<Cr>", nore_sil)

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
keymap('n', '<Leader>Q', ':bufdo bdelete<Cr>', nore_sil)

-- Close buffer
keymap('n', '<Leader>bw', ':bw<Cr>', nore_sil)

-- Write buffer
keymap('n', '<Leader>w', ':w<Cr>', nore_sil)

-- Write to all buffers and quit
keymap('n', '<Leader>x', ':xa<Cr>', nore_sil)

-- Write buffers as sudo
keymap('n', '<Leader>W', '%!sudo tee > /dev/null %', nore_sil)

-- Navigate buffers
keymap('n', '<Tab>', ':bnext<Cr>', nore_sil)
keymap('n', '<S-Tab>', ':bprevious<Cr>', nore_sil)
keymap('n', '<A-l>', ':bnext<Cr>', nore_sil)
keymap('n', '<A-h>', ':bprevious<Cr>', nore_sil)

-- Move current block of text up and down
keymap('n', '<C-j>', ':m .+1<Cr>==', nore_sil) -- Normal mode
keymap('n', '<C-k>', ':m .-2<Cr>==', nore_sil)
keymap('v', '<C-j>', ":m '>+1<Cr>gv-gv", nore_sil) -- Visual mode
keymap('v', '<C-k>', ":m '<-2<Cr>gv-gv", nore_sil)

-- Center commands
keymap('n', 'n', 'nzzzv', nore_sil)
keymap('n', 'N', 'Nzzzv', nore_sil)
keymap('v', 'y', 'myy`y', nore_sil)
keymap('v', 'Y', 'myY`y', nore_sil)
keymap('v', 'J', 'mzJ`z', nore_sil)

-- Keep visual selection after shifting code block
keymap('x', '<', '<gv', nore_sil)
keymap('x', '>', '>gv', nore_sil)

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
keymap('n', 'gvp', [['`[' . strpart(getregtype(), 0, 1) . '`]']], nore_sil)

-- Additional mappings for Comments
keymap('n', '<Leader>/', '<Cmd>lua require("Comment").toggle()<Cr>', nore_sil)
keymap('v', '<Leader>/', ':lua require(\'Comment.api\').gc(vim.fn.visualmode())<cr>', nore_sil)

-- Toggle nvim-tree
keymap('n', '<Leader>v', ':NvimTreeToggle<Cr>', nore_sil)

-- Toggle Indent Blankline
keymap('n', '<Leader>i', ':IndentBlanklineToggle<Cr>', nore_sil)

-- Cycle through relative number and number
keymap('n', '<Leader>n', ':call Cycle_numbering()<Cr>', nore_sil)

keymap('n', '<Leader>t', ':Telescope ', nore_sil)
keymap('n', '<Leader>tl', ':Telescope live_grep<Cr>', nore_sil)
