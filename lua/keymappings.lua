--- KEYMAPPINGS ---


-- leader space
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = " "

-- Better window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Switch buffers
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- Move current line / block with Alt-j/k ala vscode.
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- Better nav for omnicomplete
vim.cmd 'inoremap <expr> <c-j> ("\\<C-n>")'
vim.cmd 'inoremap <expr> <c-k> ("\\<C-p>")'

-- Toggle hincremental search
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- Yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- Highlight on yank
vim.api.nvim_exec([[
  augroup yankhighlight
    autocmd!
    autocmd textyankpost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)
