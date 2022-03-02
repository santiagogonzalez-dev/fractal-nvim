local M = {}
local expr = { expr = true }
local set = vim.keymap.set
local buffer = { buffer = true }

-- General keybinds
function M.general_keybinds()
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
   set('n', '<Space>', '<Nop>')
   set('n', '<CR>', '<Nop>')
   set('n', '<Bs>', '<Nop>')

   -- Insert skeleton
   set('n', '<Leader>sk', ':0read ~/.config/nvim/skeletons/')

   -- Reload the file manually
   set('n', '<Leader>e', '<Cmd>edit!<CR>')

   -- Close or Quit
   set('n', '<M-c>', require('csj.functions').close_or_quit)

   -- Write/Update
   set('n', '<Leader>w', '<Cmd>up<CR>')

   -- Write to all buffers and quit
   set('n', '<Leader>W', '<Cmd>wqall<CR>')

   -- Quit
   set('n', '<Leader>q', '<Cmd>quit<CR>')

   -- Delete all buffers
   set('n', '<Leader>Q', '<Cmd>bufdo bdelete<CR>')

   -- Navigate buffers
   set('n', '<Tab>', ':bnext<CR>')
   set('n', '<S-Tab>', ':bprevious<CR>')
   set('n', '<S-l>', ':bnext<CR>')
   set('n', '<S-h>', ':bprevious<CR>')

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
   set('i', '<A-j>', '<Esc>:m .+1<CR>==gi') -- Insert mode
   set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')

   -- Center commands
   set('n', 'gi', 'gi<Esc>zzi')
   set('n', 'n', 'nzzzv')
   set('n', 'N', 'Nzzzv')
   set('v', 'y', 'myy`y')
   set('v', 'Y', 'myY`y')
   set('v', 'J', 'mzJ`z')

   -- Highlight word with #
   set('n', '#', '#N')
   set('v', '#', [[y/\V<C-r>=escape(@",'/\')<CR><CR>N]])

   -- Moving inside Neovim
   set({ 'n', 'v' }, 'g.', '`.') -- Go to the last place you modified
   set('n', 'go', '<C-o>') -- Go to previous place
   set('n', 'gO', '<C-i>') -- Go to next place
   set('n', 'gp', '<C-^>') -- Go to previous buffer
   set('n', 'gn', ':bnext<cr>') -- Go to next buffer
   set('n', 'gm', '%') -- Go to the matching paren
   set('n', 'gf', ':edit <cfile><cr>') -- Go to file even if it doesn't exists

   -- Opposite to J, give a utility to K
   set('n', 'K', 'i<CR><Esc>')

   -- Make view
   set('n', '<Leader>m', '<Cmd>mkview<CR>')

   -- Disable highlight
   set('n', '<C-n>', '<cmd>nohlsearch<cr>')

   -- Paste in word under the cursor without overwriting the yank register
   set('n', '<Leader>p', [["_diwP]])

   -- Keep visual selection after shifting code block
   set({ 'v', 'x' }, '<', '<gv')
   set({ 'v', 'x' }, '>', '>gv')

   -- Swap ' with `
   set('n', "'", '`')
   set('n', '`', "'")

   -- Undo break points
   set('i', ',', ',<C-g>u')
   set('i', '.', '.<C-g>u')
   set('i', '!', '!<C-g>u')
   set('i', '?', '?<C-g>u')
   set('i', ' ', ' <C-g>u')
   set('i', '_', '_<C-g>u')
   set('i', '-', '-<C-g>u')
   set('i', '=', '=<C-g>u')
   set('i', '<CR>', '<CR><C-g>u')

   -- Insert character or string at the end of the line
   set('n', '<Leader>.', require('csj.functions').char_at_eol)

   -- Better navigation inside wrapped text
   set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", expr)
   set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", expr)

   -- Packer
   set('n', '<Leader>ps', '<Cmd>PackerSync<CR>')
   set('n', '<Leader>pc', '<Cmd>PackerCompile profile=true<CR>')

   -- Cursor On Node
   set('n', '<Leader>^', require('csj.functions').cursor_on_node)

   -- Source lua file
   -- TODO add more functionality to this keybind
   set('n', '<Leader>s', ':luafile %<CR>')

   -- NetRW
   set('n', '<Leader>v', ':Ex<CR>')
end

-- Nvim-tree
function M.nvimtree_keybinds()
   set('n', '<Leader>v', '<Cmd>NvimTreeToggle<CR>')
end

-- Gitsigns
function M.gitsigns_keybinds()
   set('n', 'ghr', '<Cmd>Gitsigns reset_hunk<CR>')
   set('n', 'ghb', '<Cmd>Gitsigns reset_buffer<CR>')
   set('n', 'ghj', '<Cmd>Gitsigns next_hunk<CR>')
   set('n', 'ghk', '<Cmd>Gitsigns prev_hunk<CR>')
   set('n', 'ghp', '<Cmd>Gitsigns preview_hunk<CR>')
end

-- Telescope
function M.telescope_keybinds()
   set('n', '<Leader>t', ':Telescope ')
   set('n', '<Leader>/', '<Cmd>Telescope current_buffer_fuzzy_find<CR>')
   set('n', '<Leader>//', '<Cmd>Telescope live_grep<CR>')
   set('n', '<Leader>f', require('csj.configs.telescope').project_files)
   set('n', '<Leader>P', '<Cmd>Telescope projects<CR>')
end

-- LSP
function M.lsp_keymaps()
   set({ 'n', 'v', 'x' }, '<Leader>ls', function()
      vim.lsp.stop_client(vim.lsp.get_active_clients())
   end, buffer)
   set({ 'v', 'x' }, '<Leader>ca', vim.lsp.buf.range_code_action, buffer)
   set({ 'v', 'x' }, '<Leader>F', vim.lsp.buf.range_formatting, buffer)
   set('n', '<Leader>F', vim.lsp.buf.formatting_sync, buffer)
   set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer)
   set('n', '<Leader>R', vim.lsp.buf.rename, buffer)
   set('n', 'gD', vim.lsp.buf.declaration, buffer)
   set('n', 'gf', vim.lsp.buf.definition, buffer)
   set('n', 'gl', vim.diagnostic.open_float, buffer)
   set('n', 'gr', vim.lsp.buf.references, buffer)
end

return M
