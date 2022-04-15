local set = vim.keymap.set

-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make dead keys
local dead_keys = {
  '<Space>',
  '<CR>',
  '<BS>',
  '<Left>',
  '<Right>',
  '<Up>',
  '<Down>',
}

for _, almost in ipairs(dead_keys) do
  set('n', almost, '<Nop>')
end

-- Undo break points
local break_points = { ',', '.', '!', '?', '<Space>', '_', '-', '=', '<CR>' }
for _, b in pairs(break_points) do
  set('i', b, b .. '<C-g>u')
end

-- Make di<motions> behave as it should
local places = { '"', "'", '{', '}', '(', ')', '[', ']' }
for _, p in pairs(places) do
  set('n', 'di' .. p, 'mzdi' .. p .. '`z')
end

set('n', '<Leader>u', '<CMD>update<CR>') -- Update
set('n', '<Leader>w', '<CMD>wqall<CR>') -- Write and Quit
set('n', '<A-c>', require('csj.core.utils').close_or_quit) -- Close or Quit
set('n', '<Leader>e', '<CMD>edit<CR>') -- Reload file manually
set('n', '<Leader>q', '<CMD>quit<CR>') -- Quit
set('n', '<Leader>Q', '<CMD>bufdo bdelete<CR>') -- Delete all buffers
set({ 'v', 'n' }, '$', 'g_') -- Make $ behave as spected in visual modes
set('n', 'K', 'i<CR><ESC>') -- Opposite to J, give a utility to K
set('n', '<A-n>', '<CMD>nohlsearch<CR>') -- Disable highlight
set('n', '<Leader>p', [["_diwP]]) -- Paste in word under the cursor without overwriting the yank register
set('n', "'", '`') -- Swap ' with `
set('n', '<Leader>s', ':luafile %<CR>') -- Source lua file
set('n', 'cg*', '*Ncgn') -- Global find-and-replace
set('n', '<C-n>', ':bnext<CR>', { silent = true }) -- Switch to next buffer
set('n', '<C-p>', ':bprevious<CR>', { silent = true }) -- Switch to prev buffer
set('n', '<Tab>', 'za') -- Toggle folds
set('n', '<S-Tab>', 'zm') -- Close all folds
set('n', 'zo', '<CMD>silent! foldopen<CR>') -- Silence this keybind
set('n', 'zc', '<CMD>silent! foldclose<CR>') -- Silence this keybind
set('n', '<Leader>ps', '<CMD>PackerSync<CR>') -- PackerSync
set('n', '<Leader>pc', '<CMD>PackerCompile profile=true<CR>') -- PackerCompile
set('n', '<Leader>n', ':silent! Lexplore!<CR>') -- NetRW
set('n', '<Leader>st', ':!tail -n3 time.md<CR>')
set({ 'n', 'v', 'x' }, '', 'zmzo<ESC>') -- Keep only one fold open using special key on my keyboard

-- Resize windows
set('n', '<C-Up>', ':resize +1<CR>')
set('n', '<C-Down>', ':resize -1<CR>')
set('n', '<C-Left>', ':vertical resize +1<CR>')
set('n', '<C-Right>', ':vertical resize -1<CR>')

-- Move current block of text up and down
set('n', '<A-j>', ':m .+1<CR>==') -- Normal mode
set('n', '<A-k>', ':m .-2<CR>==')
set('v', '<A-j>', ":m '>+1<CR>gv=gv") -- Visual mode
set('v', '<A-k>', ":m '<-2<CR>gv=gv")
set('i', '<A-j>', '<ESC>:m .+1<CR>==gi') -- Insert mode
set('i', '<A-k>', '<ESC>:m .-2<CR>==gi')

-- Center commands
set('n', 'gi', 'gi<ESC>zzv')
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')
set('n', 'J', 'mzJ`zzv')
set('n', '.', '.zzzv')

-- Better #
set('n', '#', '*Nzv')
set('v', '#', [[y/\V<C-r>=escape(@",'/\')<CR><CR>N]])

-- Keep visual selection after shifting code block
set({ 'v', 'x' }, '<', '<gv')
set({ 'v', 'x' }, '>', '>gv')

-- Better navigation inside wrapped text, and center cursor
set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
