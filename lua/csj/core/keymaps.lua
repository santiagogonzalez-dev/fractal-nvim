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
  local places = { 'af', 'if', 'ac', 'ic', 'p', '"', "'", '{', '}', '(', ')', '[', ']' }
  for _, p in pairs(places) do
    set('n', 'di' .. p, 'mzdi' .. p .. '`z')
  end

  -- Makeview, write and quit
  set('n', '<Leader>w', function()
    vim.cmd('mkview')
    vim.cmd('wqall')
  end)

  set('n', '<A-c>', function()
    return require('csj.core.utils').close_or_quit() -- Close or Quit
  end)
  set('n', '<Leader>u', '<CMD>update<CR>') -- Update
  set('n', '<Leader>e', '<CMD>edit<CR>') -- Reload the file manually
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
  set({ 'n', 'v', 'x' }, '<F16>', 'zf') -- Create folds with F16
  set('n', '<Leader>ps', '<CMD>PackerSync<CR>') -- PackerSync
  set('n', '<Leader>pc', '<CMD>PackerCompile profile=true<CR>') -- PackerCompile

  -- Window Navigation
  set('n', '<C-h>', '<C-w>h')
  set('n', '<C-j>', '<C-w>j')
  set('n', '<C-k>', '<C-w>k')
  set('n', '<C-l>', '<C-w>l')

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
  set('n', 'zc', 'zczz')

  set('n', '#', '#Nzzzv')
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
  set('n', 'tff', '<CMD>Telescope file_browser<CR>')
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
  set({ 'v', 'x' }, '<Leader><Leader>f', vim.lsp.buf.range_formatting)
  set('n', '<Leader><Leader>f', vim.lsp.buf.formatting)
  cmdline('Format', vim.lsp.buf.formatting_sync, {})

  -- Diagnostics
  set('n', 'dia', vim.diagnostic.setqflist)
  set('n', 'gl', vim.diagnostic.open_float, { buffer = true })
  set('n', '<Leader>td', function()
    return require('csj.core.utils').toggle_diagnostics()
  end)

  -- Rename
  set('n', 'r', function()
    return require('csj.core.utils').rename()
  end)

  set('n', 'gd', vim.lsp.buf.definition) -- Definitions
  set('n', 'gD', vim.lsp.buf.declaration) -- Declaration
  -- set('n', 'gr', vim.lsp.buf.references, { buffer = true }) -- References
end

-- Treesitter
M.treesitter_keybinds = function()
  return require('nvim-treesitter.configs').setup {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn', -- Start the selection by nodes
        node_incremental = 'gnn', -- Increment to the node with higher order
        node_decremental = 'gnp', -- Decrement to the node with lower order
        scope_incremental = 'gns', -- Select the entire group  of nodes including the braces
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer', -- Include the function keyword/s
          ['if'] = '@function.inner', -- Select just the insides of the function
          ['ac'] = '@class.outer', -- Include the class keyword
          ['ic'] = '@class.inner', -- Select just the insides of the keyword
        },
      },
      swap = {
        enable = false, -- Disabled for now, it's not that useful
        swap_next = { ['<Leader>a'] = '@parameter.inner' }, -- Move paramaters around
        swap_previous = { ['<Leader>A'] = '@parameter.inner' }, -- Move paramaters around
      },
      move = {
        enable = true,
        set_jumps = true, -- Whether to set jumps in the jumplist
        -- First [ means previous, first ] means next
        -- m is for function, M for function end
        goto_previous_start = {
          ['[m'] = '@function.outer', -- Move to the previous or actual node or function(not just keywords)
          ['[['] = '@class.outer', -- Move to the previous or actual class keyword
        },
        goto_next_start = {
          [']m'] = '@function.outer', -- Move to the function keyword
          [']]'] = '@class.outer', -- Move to the class keyword
        },
        goto_next_end = {
          [']M'] = '@function.outer', -- Move to the end of the function
          [']['] = '@class.outer', -- Move to the end of the class
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      lsp_interop = {
        enable = true,
        border = 'rounded',
        peek_definition_code = {
          ['gdf'] = '@function.outer',
          ['gdF'] = '@class.outer',
        },
      },
    },
  }
end

return M
