----  KEYMAPPINGS  ----

local api = vim.api
local cmd = vim.cmd
local g = vim.g

-- Leader key
api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
g.mapleader = " "

-- Better window movement
api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Better indenting
api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Switch buffers using TAB
api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- Move current line / block with Alt-j/k ala vscode.
api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
api.nvim_set_keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
api.nvim_set_keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- Better nav for omnicomplete
cmd 'inoremap <expr> <c-j> ("\\<C-n>")'
cmd 'inoremap <expr> <c-k> ("\\<C-p>")'

-- Toggle hincremental search
api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- Yank until the end of line with Y
api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- Highlight on yank
api.nvim_exec([[
  augroup yankhighlight
    autocmd!
    autocmd textyankpost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)
