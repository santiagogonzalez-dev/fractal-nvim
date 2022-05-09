-- Make dead keys
local dead_keys = { '<Space>', '<BS>', '<CR>', '<Down>', '<Left>', '<Right>', '<Up>', 'q:' }
for _, almost in ipairs(dead_keys) do
    vim.keymap.set({ 'n', 'v', 'x' }, almost, '<Nop>')
end

-- Undo break points
local break_points = { ',', '.', '!', '?', '<Space>', '_', '-', '=', '<CR>' }
for _, b in pairs(break_points) do
    vim.keymap.set('i', b, b .. '<C-g>u')
end

-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Leader>u', '<CMD>update<CR>', { desc = 'Update the file' })
vim.keymap.set('n', '<Leader>E', '<CMD>edit<CR>', { desc = 'Reload file manually' })
vim.keymap.set('n', '<Leader>q', '<CMD>quit<CR>', { desc = 'Quit neovim' })
vim.keymap.set('n', '<Leader>w', '<CMD>wqall<CR>', { desc = 'Write and Quit' })
vim.keymap.set('n', '<C-c>', require('csj.utils').close_or_quit, { desc = 'Close or Quit' })
vim.keymap.set('n', '<Leader>Q', '<CMD>bufdo bdelete<CR>', { desc = 'Delete all buffers' })
vim.keymap.set({ 'v', 'n' }, '$', 'g_', { desc = 'Make $ behave as spected in visual modes' })
vim.keymap.set('n', 'K', 'i<CR><ESC>', { desc = 'Opposite to J' })
vim.keymap.set('n', '<A-n>', '<CMD>nohlsearch<CR>', { desc = 'Disable highlight' })
vim.keymap.set('n', '<Leader>p', [["_diwP]], { desc = 'Paste in word under the cursor without overwriting the yank register' })
vim.keymap.set('n', "'", '`', { desc = "Swap ' with `" })
vim.keymap.set('n', '<Leader>s', ':luafile %<CR>', { desc = 'Source lua file' })
vim.keymap.set('n', 'cg*', '*Ncgn', { desc = 'Find and replace next match of the word under cursor' })
vim.keymap.set('n', '<C-n>', ':bnext<CR>', { silent = true, desc = 'Switch to next buffer' })
vim.keymap.set('n', '<C-p>', ':bprevious<CR>', { silent = true, desc = 'Switch to prev buffer' })
vim.keymap.set('n', 'zo', '<CMD>silent! foldopen<CR>', { desc = 'Silence this keybind' })
vim.keymap.set('n', 'zc', '<CMD>silent! foldclose<CR>', { desc = 'Silence this keybind' })
vim.keymap.set('n', '<Leader>ps', '<CMD>PackerSync<CR>', { desc = 'PackerSync' })
vim.keymap.set('n', '<Leader>pc', '<CMD>PackerCompile profile=true<CR>', { desc = 'PackerCompile' })
vim.keymap.set('n', 'gvp', [['`[' . strpart(getregtype(), 0, 1) . '`]']], { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'n is always next' })
vim.keymap.set({ 'n', 'x', 'o' }, 'N', '"nN"[v:searchforward]', { expr = true, desc = 'N is always previous' })
vim.keymap.set('n', '^^', '0', { desc = 'Better ^' })

vim.keymap.set('n', '<Leader>e', ':silent! Lexplore!<CR>', { silent = true, desc = 'Open NetRW' })
vim.keymap.set('n', '<Leader>ee', ':silent! Lexplore! %:p:h<CR>', { silent = true, desc = 'Open NetRW in the directory of the current buffer' })

vim.keymap.set('n', '<C-Up>', ':resize +1<CR>', { desc = 'Resize windows' })
vim.keymap.set('n', '<C-Down>', ':resize -1<CR>', { desc = 'Resize windows' })
vim.keymap.set('n', '<C-Left>', ':vertical resize +1<CR>', { desc = 'Resize windows' })
vim.keymap.set('n', '<C-Right>', ':vertical resize -1<CR>', { desc = 'Resize windows' })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move current block of text up and down' }) -- Normal mode
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move current block of text up and down' })
vim.keymap.set({ 'v', 'x' }, '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move current block of text up and down' }) -- Visual mode
vim.keymap.set({ 'v', 'x' }, '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move current block of text up and down' })

vim.keymap.set('n', '<Tab>', 'za', { desc = 'Toggle folds' })
vim.keymap.set('n', '<S-Tab>', 'zm', { desc = 'Close all folds' })
vim.keymap.set({ 'n', 'v', 'x' }, '<F16>', 'zmzo<ESC>', { desc = 'Keep only one fold open using special key on my keyboard' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center commands' }) -- toehuteu
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center commands' })
vim.keymap.set('n', 'J', 'mzJ`zzv', { desc = 'Center commands' })

-- TODO(santigo-zero): ci( and ci) will work normally, and  c( and c) should work line wise, fix this
-- The same goes for di( and di) and d( and d)
-- vim.keymap.set('n', 'c)', 'ci)', { desc = 'c} does the same and I prefer using it'})
-- vim.keymap.set('n', 'c(', 'ci(', { desc = 'c{ does the same and I prefer using it'})

-- -- TODO find better mappings, and create a function for + and -
-- vim.keymap.set('n', '<S-l>', utils.l_motion, { desc = 'Alternative behaviour to l' })
-- vim.keymap.set('n', '<S-h>', utils.h_motion, { desc = 'Alternative behaviour to h' })
vim.keymap.set('n', '<Leader>j', '+')
vim.keymap.set('n', '<Leader>k', '-')

vim.keymap.set('n', '#', '*Nzv', { desc = 'Better #' })
vim.keymap.set('v', '#', [[y/\V<C-r>=escape(@",'/\')<CR><CR>N]], { desc = 'Better #' })

vim.keymap.set({ 'v', 'x' }, '<', '<gv', { desc = 'Keep visual selection after shifting code block' })
vim.keymap.set({ 'v', 'x' }, '>', '>gv', { desc = 'Keep visual selection after shifting code block' })

vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Better navigation inside wrapped text, and center cursor' })
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Better navigation inside wrapped text, and center cursor' })
