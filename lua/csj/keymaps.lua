local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
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

-- Semicolon
keymap('n', '<Leader>;', '$a;<Esc>', opts)
keymap('v', '<Leader>;', ":'<,'>norm A;<Cr>", opts)

-- Colon
keymap('n', '<Leader>:', '$a:<Esc>', opts)

-- Backslash
keymap('n', '<Leader>\\', '$a \\<Esc>', opts)

-- Comma
keymap('n', '<Leader>,', '$a,<Esc>', opts)
keymap('v', '<Leader>,', ":'<,'>norm A,<Cr>", opts)

-- Dot
keymap('n', '<Leader>.', '$a.<Esc>', opts)

-- Avoid moving the cursor with space, enter or backspace when in normal mode
keymap('n', '<Space>', '<Nop>', opts)
keymap('n', '<Cr>', '<Nop>', opts)
keymap('n', '<Bs>', '<Nop>', opts)

-- Write and reload the file
keymap('n', '<Leader>e', '<Cmd>w<Cr> | <Cmd>source %<Cr>zz', opts)

-- Toggle cursor line and column
keymap('n', '<Leader>C', '<Cmd>set cul! cuc!<Cr>', opts)

-- Insert skeleton
keymap('n', '<Leader>sk', ':0read ~/.config/nvim/skeletons/', opts)

-- Quit
keymap('n', '<Leader>qq', '<Cmd>q<Cr>', opts)

-- Smart quit
vim.keymap.set('n', '<C-q>', require('csj.functions').close_or_quit)

-- Close buffer
keymap('n', '<Leader>qb', '<Cmd>bdelete<Cr>', opts)

-- Quit all buffers
keymap('n', '<Leader>Q', '<Cmd>bufdo bdelete<Cr>', opts)

-- Write buffer
keymap('n', '<Leader>w', '<Cmd>w<Cr>', opts)

-- Write to all buffers and quit
keymap('n', '<Leader>x', ':wqa<Cr>', opts)

-- Write buffers as sudo
keymap('n', '<Leader>W', '%!sudo tee > /dev/null %', opts)

-- Navigate buffers
keymap('n', '<Tab>', ':bnext<Cr>', opts)
keymap('n', '<S-Tab>', ':bprevious<Cr>', opts)
keymap('n', '<S-h>', ':bnext<Cr>', opts)
keymap('n', '<S-l>', ':bprevious<Cr>', opts)

-- Window Navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize windows
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-- Move current block of text up and down
keymap('n', '<A-j>', ':m .+1<Cr>==', opts) -- Normal mode
keymap('n', '<A-k>', ':m .-2<Cr>==', opts)
keymap('v', '<A-j>', ":m '>+1<Cr>gv=gv", opts) -- Visual mode
keymap('v', '<A-k>', ":m '<-2<Cr>gv=gv", opts)
keymap('i', '<A-j>', "<Esc>:m .+1<Cr>==gi", opts) -- Insert mode
keymap('i', '<A-k>', "<Esc>:m .-2<Cr>==gi", opts)

-- Center commands
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('v', 'y', 'myy`y', opts)
keymap('v', 'Y', 'myY`y', opts)
keymap('v', 'J', 'mzJ`z', opts)

-- Opposite to J
keymap('n', 'K', 'i<Cr><Esc>', opts)

-- Delete word under cursor and paste contents
keymap('n', '<Leader>P', [["_diwP]], opts)

-- Folds
keymap('n', 'zo', 'zo^', opts)
keymap('n', 'zp', 'zfip', opts)
keymap('n', '<Leader>m', '<Cmd>mkview<Cr>', opts)

-- Paste text without yanking
keymap('v', 'p', '"_dP', opts)

-- Keep visual selection after shifting code block
keymap('x', '<', '<gv', opts)
keymap('x', '>', '>gv', opts)

-- Undo break points
keymap('i', ',', ',<C-g>u', opts)
keymap('i', '.', '.<C-g>u', opts)
keymap('i', '!', '!<C-g>u', opts)
keymap('i', '?', '?<C-g>u', opts)
keymap('i', ' ', ' <C-g>u', opts)
keymap('i', '_', '_<C-g>u', opts)
keymap('i', '-', '-<C-g>u', opts)
keymap('i', '=', '=<C-g>u', opts)
keymap('i', '<Cr>', '<Cr><C-g>u', opts)

-- Better navigation inside wrapped text
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", nore_exp_sil)
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", nore_exp_sil)

-- Packer
keymap('n', '<Leader>ps', '<Cmd>PackerSync<Cr>', opts)
keymap('n', '<Leader>pc', '<Cmd>PackerCompile<Cr>', opts)

-- Hop
keymap('n', '<Leader>h', ':HopPattern<Cr>', opts)

-- Toggle nvim-tree
keymap('n', '<Leader>v', '<Cmd>NvimTreeToggle<Cr>', opts) -- keymap('n', '<leader>v', ':Lex 30<cr>', opts)

-- Toggle Indent Blankline
keymap('n', '<Leader>i', '<Cmd>IndentBlanklineToggle<Cr>', opts)

-- Gitsigns
keymap('n', '<Leader>gj', '<Cmd>Gitsigns next_hunk<Cr>', opts) -- Move to the next hunk
keymap('n', '<Leader>gk', '<Cmd>Gitsigns prev_hunk<Cr>', opts) -- Move to the previous hunk
keymap('n', '<Leader>ghp', '<Cmd>Gitsigns preview_hunk<Cr>', opts) -- Preview hunk
keymap('n', '<Leader>ghr', '<Cmd>Gitsigns reset_hunk<Cr>', opts) -- Reset hunk
keymap('n', '<Leader>ghb', '<Cmd>Gitsigns reset_buffer<Cr>', opts) -- Reset buffer hunk

-- Cycle through relative number and number
keymap('n', '<Leader>nt', '<Cmd>call Cycle_numbering()<Cr>', opts)

-- Telescope
keymap('n', '<Leader>t', ':Telescope<Cr>', opts)
-- Lists files in your current working directory, respects .gitignore
keymap('n', '<Leader>ff', '<Cmd>lua require"telescope.builtin".find_files(require("telescope.themes").get_dropdown({}))<Cr>', opts)
-- Fuzzy search through the output of git ls-files command, respects .gitignore, optionally ignores untracked files
keymap('n', '<Leader>fg', '<Cmd>lua require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({ previewer = false }))<Cr>', opts)
keymap('n', '<Leader>b', '<Cmd>lua require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))<Cr>', opts)
keymap('n', '<Leader>p', '<Cmd>lua require("telescope").extensions.projects.projects()<Cr>', opts)
keymap('n', '<Leader>fd', '<Cmd>Telescope live_grep<Cr>', opts) -- live_grep respects .gitignore
keymap('n', '<Leader>r', '<Cmd>Telescope lsp_references<Cr>', opts)
keymap('n', '<Leader>gb', '<Cmd>Telescope git_branches<Cr>', opts)

-- Keymaps
local M = {}
function M.lsp_keymaps(bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
    buf_set_keymap('n', '<Leader>F', '<Cmd>lua vim.lsp.buf.formatting_sync()<Cr>', opts)
    buf_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
    buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<Cr>', opts)
    buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<Cr>', opts)
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<Cr>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<Cr>', opts)
    buf_set_keymap('n', 'gl', '<Cmd>lua vim.diagnostic.open_float()<Cr>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<Cr>', opts)
end
return M
