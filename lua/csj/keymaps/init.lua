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
    vim.keymap.set('n', almost, '<Nop>')
end

-- Undo break points
local break_points = {
    ',',
    '.',
    '!',
    '?',
    '<Space>',
    '_',
    '-',
    '=',
    '<CR>',
}

for _, b in pairs(break_points) do
    vim.keymap.set('i', b, b .. '<C-g>u')
end

-- Make di<motions> behave as it should
local places = {
    '"',
    "'",
    '{',
    '}',
    '(',
    ')',
    '[',
    ']',
}

for _, p in pairs(places) do
    vim.keymap.set('n', 'di' .. p, 'mzdi' .. p .. '`z')
end

vim.keymap.set('n', '<Leader>u', '<CMD>update<CR>') -- Update
vim.keymap.set('n', '<Leader>w', '<CMD>wqall<CR>') -- Write and Quit
vim.keymap.set('n', '<A-c>', require('csj.core.utils').close_or_quit) -- Close or Quit
vim.keymap.set('n', '<Leader>e', '<CMD>edit<CR>') -- Reload file manually
vim.keymap.set('n', '<Leader>q', '<CMD>quit<CR>') -- Quit
vim.keymap.set('n', '<Leader>Q', '<CMD>bufdo bdelete<CR>') -- Delete all buffers
vim.keymap.set({ 'v', 'n' }, '$', 'g_') -- Make $ behave as spected in visual modes
vim.keymap.set('n', 'K', 'i<CR><ESC>') -- Opposite to J, give a utility to K
vim.keymap.set('n', '<A-n>', '<CMD>nohlsearch<CR>') -- Disable highlight
vim.keymap.set('n', '<Leader>p', [["_diwP]]) -- Paste in word under the cursor without overwriting the yank register
vim.keymap.set('n', "'", '`') -- Swap ' with `
vim.keymap.set('n', '<Leader>s', ':luafile %<CR>') -- Source lua file
vim.keymap.set('n', 'cg*', '*Ncgn') -- Global find-and-replace
vim.keymap.set('n', '<C-n>', ':bnext<CR>', { silent = true }) -- Switch to next buffer
vim.keymap.set('n', '<C-p>', ':bprevious<CR>', { silent = true }) -- Switch to prev buffer
vim.keymap.set('n', '<Tab>', 'za') -- Toggle folds
vim.keymap.set('n', '<S-Tab>', 'zm') -- Close all folds
vim.keymap.set('n', 'zo', '<CMD>silent! foldopen<CR>') -- Silence this keybind
vim.keymap.set('n', 'zc', '<CMD>silent! foldclose<CR>') -- Silence this keybind
vim.keymap.set('n', '<Leader>ps', '<CMD>PackerSync<CR>') -- PackerSync
vim.keymap.set('n', '<Leader>pc', '<CMD>PackerCompile profile=true<CR>') -- PackerCompile
vim.keymap.set('n', '<Leader>n', ':silent! Lexplore!<CR>') -- NetRW
vim.keymap.set('n', '<Leader>st', ':!tail -n3 time.md<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '', 'zmzo<ESC>') -- Keep only one fold open using special key on my keyboard

-- Resize windows
vim.keymap.set('n', '<C-Up>', ':resize +1<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -1<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize +1<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize -1<CR>')

-- Move current block of text up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==') -- Normal mode
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv") -- Visual mode
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('i', '<A-j>', '<ESC>:m .+1<CR>==gi') -- Insert mode
vim.keymap.set('i', '<A-k>', '<ESC>:m .-2<CR>==gi')

-- Center commands
vim.keymap.set('n', 'gi', 'gi<ESC>zzv')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`zzv')
vim.keymap.set('n', '.', '.zzzv')

-- Better #
vim.keymap.set('n', '#', '*Nzv')
vim.keymap.set('v', '#', [[y/\V<C-r>=escape(@",'/\')<CR><CR>N]])

-- Keep visual selection after shifting code block
vim.keymap.set({ 'v', 'x' }, '<', '<gv')
vim.keymap.set({ 'v', 'x' }, '>', '>gv')

-- Better navigation inside wrapped text, and center cursor
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
