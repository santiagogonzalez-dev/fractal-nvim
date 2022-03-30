local M = {}
local set = vim.keymap.set
local cmdline = vim.api.nvim_add_user_command

-- General keybinds
M.general_keybinds = function()
  -- Remap space as leader key
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Make dead keys
  local dead_keys = { '<Space>', '<CR>', '<BS>', '<Left>', '<Right>', '<Up>', '<Down>' }
  for _, almost in ipairs(dead_keys) do
    set('n', almost, '<Nop>')
  end

  -- Undo break points
  local break_points = { ',', '.', '!', '?', '<Space>', '_', '-', '=', '<CR>' }
  for _, b in pairs(break_points) do
    set('i', b, b .. '<C-g>u')
  end

  -- Make di<motions> behave as it should
  local places = { 'p', '"', "'", '{', '}', '(', ')', '[', ']' }
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
  set('n', '<C-n>', '<CMD>nohlsearch<CR>') -- Disable highlight
  set('n', '<Leader>p', [["_diwP]]) -- Paste in word under the cursor without overwriting the yank register
  set('n', "'", '`') -- Swap ' with `
  set('n', '<Leader>s', ':luafile %<CR>') -- Source lua file
  set('n', 'cg*', '*Ncgn') -- Global find-and-replace
  set('n', '<Tab>', ':bnext<CR>') -- Tab to next buffer
  set('n', '<S-Tab>', ':bprevious<CR>') -- Shift-Tab to previous buffer
  set('n', '<Leader>ps', '<CMD>PackerSync<CR>') -- PackerSync
  set('n', '<Leader>pc', '<CMD>PackerCompile profile=true<CR>') -- PackerCompile
  set('n', '<Leader>n', ':Lexplore! 30<CR>', { silent = true }) -- NetRW
  set({ 'n', 'v', 'x' }, '<F16>', 'zmzo<ESC>') -- Keep only one fold open

  -- Window Navigation
  set('n', '<Leader>wh', '<C-w>h')
  set('n', '<Leader>wj', '<C-w>j')
  set('n', '<Leader>wk', '<C-w>k')
  set('n', '<Leader>wl', '<C-w>l')

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
  set('n', '#', '#Nzv')
  set('v', '#', [[y/\V<C-r>=escape(@",'/\')<CR><CR>N]])

  -- Keep visual selection after shifting code block
  set({ 'v', 'x' }, '<', '<gv')
  set({ 'v', 'x' }, '>', '>gv')

  -- Better navigation inside wrapped text, and center cursor
  set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
  set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
end

-- Gitsigns
M.gitsigns_keybinds = function(gitsigns)
  set('n', 'ghr', gitsigns.reset_hunk)
  set('n', 'ghb', gitsigns.reset_buffer)
  set('n', 'ghj', gitsigns.next_hunk)
  set('n', 'ghk', gitsigns.prev_hunk)
  set('n', 'ghp', gitsigns.preview_hunk)
end

-- Telescope
M.telescope_keybinds = function()
  set('n', 'gr', '<CMD>Telescope lsp_references theme=dropdown<CR>')
  set('n', 't/', '<CMD>Telescope live_grep theme=dropdown<CR>')
  set('n', 't//', '<CMD>Telescope current_buffer_fuzzy_find theme=dropdown<CR>')
  set('n', 'tf', require('csj.plugins.telescope').project_files)
  set('n', 'tp', '<CMD>Telescope projects<CR>')
  set('n', 'tt', '<CMD>Telescope<CR>')
end

-- LSP
M.lsp_keymaps = function()
  -- Stop the LS
  set({ 'n', 'v', 'x' }, '<Leader>ls', function()
    return vim.lsp.stop_client(vim.lsp.get_active_clients())
  end, { buffer = true })

  -- Code actions
  set({ 'v', 'x' }, '<Leader>ca', vim.lsp.buf.range_code_action)
  set('n', '<Leader>ca', vim.lsp.buf.code_action)

  -- Formatting
  set({ 'v', 'x' }, '<Leader><Leader>f', function()
    return vim.lsp.buf.range_formatting
  end)
  set('n', '<Leader><Leader>f', vim.lsp.buf.formatting)
  cmdline('Format', vim.lsp.buf.formatting_sync, {})

  set('n', '<Leader>d', vim.diagnostic.setqflist) -- Show all diagnostics
  set('n', 'gll', vim.diagnostic.open_float) -- Open in float window
  set('n', 'gl', vim.lsp.buf.hover) -- Open in float window
  set('n', '<Leader>dj', vim.diagnostic.goto_next) -- Go to next diagnostic
  set('n', '<Leader>dk', vim.diagnostic.goto_prev) -- Go to previous diagnostic
  set('n', '<Leader>td', require('csj.core.utils').toggle_diagnostics) -- Toggel diagnostics
  set('n', 'r', require('csj.core.utils').rename) -- Rename
  set('n', 'gd', vim.lsp.buf.definition) -- Definitions
  set('n', 'gD', vim.lsp.buf.declaration) -- Declaration
  -- set('n', 'gr', vim.lsp.buf.references) -- References
end

return M
