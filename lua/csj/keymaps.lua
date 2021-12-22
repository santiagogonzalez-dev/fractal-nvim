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
keymap('n', '<Leader>s', '<Cmd>set spell!<Cr>', nore_sil)

-- Highlight toggle for searched words
keymap('n', '<Leader>n', '<Cmd>set hlsearch!<Cr>', nore_sil)

-- Toggle cursor line and column
keymap('n', '<Leader>c', '<Cmd>set cul! cuc!<Cr>', nore_sil)

-- Toggle cursor line and column
keymap('n', '<Leader>sk', ':read ~/.config/nvim/skeletons/', nore_sil)

-- Quit all buffers
keymap('n', '<Leader>Q', ':bufdo bdelete<Cr>', nore_sil)

-- Close buffer
keymap('n', '<Leader>bw', ':bw<Cr>', nore_sil)

-- Write buffer
keymap('n', '<Leader>w', '<Cmd>w<Cr>', nore_sil)

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

-- Resize windows
keymap('n', '<C-Up>', ':resize +2<CR>', nore_sil)
keymap('n', '<C-Down>', ':resize -2<CR>', nore_sil)
keymap('n', '<C-Left>', ':vertical resize +2<CR>', nore_sil)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', nore_sil)

-- Center commands
keymap('n', 'n', 'nzzzv', nore_sil)
keymap('n', 'N', 'Nzzzv', nore_sil)
keymap('v', 'y', 'myy`y', nore_sil)
keymap('v', 'Y', 'myY`y', nore_sil)
keymap('v', 'J', 'mzJ`z', nore_sil)

-- Paste text without yanking
keymap('v', 'p', '"_dP', nore_sil)

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
keymap('n', 'gvp', [[ '`[' . strpart(getregtype(), 0, 1) . '`]' ]], nore_sil)

-- Packer
keymap('n', '<Leader>ps', ':PackerSync<Cr>', nore_sil)
keymap('n', '<Leader>pc', ':PackerCompile<Cr>', nore_sil)

-- Hop
keymap('n', '<Leader>h', ':HopPattern<Cr>', nore_sil)

-- Toggle nvim-tree
keymap('n', '<Leader>v', '<Cmd>NvimTreeToggle<Cr>', nore_sil)
-- keymap('n', '<leader>v', ':Lex 30<cr>', nore_sil)

-- Toggle Indent Blankline
keymap('n', '<Leader>i', '<Cmd>IndentBlanklineToggle<Cr>', nore_sil)

-- Cycle through relative number and number
keymap('n', '<Leader>nt', '<Cmd>call Cycle_numbering()<Cr>', nore_sil)

-- Telescope
keymap('n', '<Leader>t', '<Cmd>Telescope<Cr>', nore_sil)
-- keymap('n', '<Leader>f', '<Cmd>Telescope find_files<Cr>', nore_sil)
keymap('n', '<Leader>f', '<Cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false }))<Cr>', nore_sil)
keymap('n', '<Leader>g', '<Cmd>Telescope live_grep<Cr>', nore_sil)
keymap('n', '<Leader>d', '<Cmd>Telescope lsp_definitions<Cr>', nore_sil)
keymap('n', '<Leader>r', '<Cmd>Telescope lsp_references<Cr>', nore_sil)
keymap('n', '<Leader>b', '<Cmd>Telescope git_branches<Cr>', nore_sil)

-- Keymaps
local maps = {}
function maps.lsp_keymaps(bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', '<Leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<Cr>', nore_sil)
    buf_set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', nore_sil)
    buf_set_keymap('n', '<Leader>F', '<Cmd>lua vim.lsp.buf.formatting()<Cr>', nore_sil)
    buf_set_keymap('n', '<Leader>q', '<Cmd>lua vim.diagnostic.setloclist()<Cr>', nore_sil)
    buf_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<Cr>', nore_sil)
    buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<Cr>', nore_sil)
    buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<Cr>', nore_sil)
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<Cr>', nore_sil)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<Cr>', nore_sil)
    buf_set_keymap('n', 'gl', '<Cmd>lua vim.diagnostic.open_float()<Cr>', nore_sil) -- 'vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })'
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<Cr>', nore_sil)

    -- buf_set_keymap('n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<Cr>', nore_sil)
    -- buf_set_keymap('n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<Cr>', nore_sil)
    -- buf_set_keymap('n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<Cr>', nore_sil)
    -- buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', nore_sil)
    -- buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', nore_sil)
    -- buf_set_keymap('n', '<Space>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<Cr>', nore_sil)
    -- buf_set_keymap('n', '<Space>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<Cr>', nore_sil)
    -- buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', nore_sil)
    -- buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.diagnostic.open_float()<Cr>', nore_sil)
    -- buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<Cr>', nore_sil)
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', nore_sil)
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', nore_sil)
    -- buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<Cr>', nore_sil)
    -- buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<Cr>', nore_sil)
end
return maps
