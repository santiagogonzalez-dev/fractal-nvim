local dead_keys = {
  '<BS>',
  '<CR>',
  '<Down>',
  '<Left>',
  '<Right>',
  '<Space>',
  '<Up>',
  'q:',
}
for _, almost in ipairs(dead_keys) do -- Make dead keys
  vim.keymap.set({ 'n', 'v', 'x' }, almost, '<Nop>')
end

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
for _, b in pairs(break_points) do -- Undo break points
  vim.keymap.set('i', b, string.format('%s%s', b, '<C-g>u'))
end

-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Simple keymappings
vim.keymap.set('n', '<Leader>u', vim.cmd.update, { desc = 'Update the file' })
vim.keymap.set('n', '<Leader>qq', vim.cmd.quitall, { desc = 'Quit neovim' })
vim.keymap.set('n', '<Leader>Q', '<CMD>bufdo bdelete<CR>', { desc = 'Delete all buffers' })
vim.keymap.set('n', '<Leader>w', vim.cmd.wqall, { desc = 'Write and Quit' })
vim.keymap.set('n', '<Leader>p', '"_diwP', { desc = 'Paste under cursor without overwriting the yank register' })
vim.keymap.set('n', '<Leader>s', ':luafile %<CR>', { desc = 'Source lua file' })
vim.keymap.set('n', '<Leader>E', vim.cmd.e, { desc = 'Reedit the buffer', silent = true })
vim.keymap.set('n', '<Leader>e', ':silent! Lexplore!<CR>', { desc = 'Open NetRW', silent = true })
vim.keymap.set('n', '<Leader>ee', ':silent! Lexplore! %:p:h<CR>', { desc = 'Open NetRW in the dir of the buffer' })

vim.keymap.set('n', '<C-n>', vim.cmd.bnext, { desc = 'Switch to next buffer', silent = true })
vim.keymap.set('n', '<C-p>', vim.cmd.bprevious, { desc = 'Switch to prev buffer', silent = true })

vim.g.last_accessed_buffer = false
vim.keymap.set('n', 'g<Tab>', function()
  if vim.g.last_accessed_buffer == false then
    vim.cmd.bprevious()
    vim.g.last_accessed_buffer = true
  else
    vim.cmd.bnext()
    vim.g.last_accessed_buffer = false
  end
end, { desc = 'Go back and forth between two buffers' })

vim.keymap.set('n', '<Leader>lcc', vim.cmd.LuaCacheClear, { desc = 'Impatient.nvim: Clear cache' })
vim.keymap.set('n', '<Leader>ps', vim.cmd.PackerSync, { desc = 'Packer: PackerSync' })
vim.keymap.set('n', '<Leader>pc', '<CMD>PackerCompile profile=true<CR>', { desc = 'Packer: PackerCompile' })
vim.keymap.set('n', '<Leader>pcc', function()
  vim.cmd.PackerCompile('profile=true')
  vim.cmd.LuaCacheClear()
end)

vim.keymap.set('n', "'", '`', { desc = "Swap ' with `" })
vim.keymap.set('n', '`', "'", { desc = "Swap ` with '" })
vim.keymap.set({ 'n', 'v', 'x' }, ';', ':', { desc = 'Swap ; with :' })
vim.keymap.set({ 'n', 'v', 'x' }, ':', ';', { desc = 'Swap : with ;' })
vim.keymap.set('n', ':', ';', { desc = 'Swap : with ;' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Center J' })
vim.keymap.set('n', 'K', 'i<CR><ESC>', { desc = 'Normal <CR> behaviour, opposite to J' })
vim.keymap.set('n', '<A-n>', vim.cmd.nohlsearch, { desc = 'Disable highlight' })
vim.keymap.set({ 'n', 'v' }, '$', 'g_', { desc = 'Better $, behaves as expected' })
vim.keymap.set('n', 'gvp', "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true })
vim.keymap.set('n', 'cg*', '*Ncgn', { desc = 'Find and replace next match of the word under cursor' })
vim.keymap.set({ 'n', 'x', 'o' }, 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'n is always next' })
vim.keymap.set({ 'n', 'x', 'o' }, 'N', '"nN"[v:searchforward]', { expr = true, desc = 'N is always previous' })
vim.keymap.set('n', 'dD', '0D', { desc = 'This only makes sense to me' })
vim.keymap.set('n', '^^', '0', { desc = 'Better ^' })

vim.keymap.set('n', 'gx', function()
  vim.fn.jobstart({ 'xdg-open', vim.fn.expand('<cfile>', nil, nil) }, { detach = true })
end, { desc = 'Better gx' })

vim.keymap.set('n', 'dd', function()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    -- vim.notify('Not overriding the yank register', vim.log.levels.WARN)
    return '"_dd'
  else
    return 'dd'
  end
end, {
  desc = 'Better dd, does not override the yank register if it is a blank line',
  noremap = true,
  expr = true,
  nowait = true,
})

vim.keymap.set('n', '<C-Up>', ':resize +1<CR>', { desc = 'Resize windows' })
vim.keymap.set('n', '<C-Down>', ':resize -1<CR>', { desc = 'Resize windows' })
vim.keymap.set('n', '<C-Left>', ':vertical resize +1<CR>', { desc = 'Resize windows' })
vim.keymap.set('n', '<C-Right>', ':vertical resize -1<CR>', { desc = 'Resize windows' })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move current block of text up and down', silent = true }) -- Normal mode
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move current block of text up and down', silent = true })
vim.keymap.set({ 'v', 'x' }, '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move block of text up and down', silent = true }) -- Visual mode
vim.keymap.set({ 'v', 'x' }, '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move block of text up and down', silent = true })

vim.keymap.set('n', '<Tab>', 'za', { desc = 'Toggle folds', silent = true })
vim.keymap.set('n', '<S-Tab>', 'zm', { desc = 'Close all folds', silent = true })
vim.keymap.set('n', 'zo', '<CMD>silent! foldopen<CR>', { desc = 'Silence this keybind', silent = true })
vim.keymap.set('n', 'zc', '<CMD>silent! foldclose<CR>', { desc = 'Silence this keybind', silent = true })

vim.keymap.set('n', '#', '*Nzv', { desc = 'Better #' })
vim.keymap.set('v', '#', [[y/\V<C-r>=escape(@",'/\')<CR><CR>N]], { desc = 'Better #' })

vim.keymap.set({ 'v', 'x' }, '<', '<gv', { desc = 'Keep visual selection after shifting code block' })
vim.keymap.set({ 'v', 'x' }, '>', '>gv', { desc = 'Keep visual selection after shifting code block' })
vim.keymap.set('n', '/', '/<Up>', { desc = 'Better search' })
vim.keymap.set('n', '//', '/', { desc = 'Better search' })
