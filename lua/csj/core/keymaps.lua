local M = {}
local buffer = { buffer = true }
local set = vim.keymap.set -- For everything

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

    -- Avoid moving the cursor with space, enter or backspace in normal mode
    set('n', '<Space>', '<Nop>')
    set('n', '<CR>', '<Nop>')
    set('n', '<BS>', '<Nop>')

    -- Reload the file manually
    set('n', '<Leader>e', '<CMD>edit<CR>')

    -- Close or Quit
    set('n', '<A-c>', require('csj.core.functions').close_or_quit)

    -- Write/Update
    set('n', '<Leader>w', '<CMD>w<CR>')

    -- Write to all buffers and quit
    set('n', '<Leader>W', '<CMD>wqall<CR>')

    -- Quit
    set('n', '<Leader>q', '<CMD>quit<CR>')

    -- Delete all buffers
    set('n', '<Leader>Q', '<CMD>bufdo bdelete<CR>')

    -- Moving inside Neovim
    set({ 'n', 'v' }, 'g.', '`.') -- Go to the last place you modified
    set('n', 'go', '<C-o>') -- Go to previous place
    set('n', 'gO', '<C-i>') -- Go to next place
    set('n', 'gp', '<C-^>') -- Go to previous buffer
    set('n', 'gn', ':bnext<cr>') -- Go to next buffer
    set('n', 'gm', '%') -- Go to the matching paren
    set('n', 'gf', ':edit <cfile><CR>') -- Go to file even if it doesn't exists

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
    set('i', '<A-j>', '<ESC>:m .+1<CR>==gi') -- Insert mode
    set('i', '<A-k>', '<ESC>:m .-2<CR>==gi')

    -- Center commands
    set('n', 'gi', 'gi<ESC>zzi')
    set('n', 'n', 'nzzzv')
    set('n', 'N', 'Nzzzv')
    set('v', 'y', 'myy`y')
    set('v', 'Y', 'myY`y')
    set('v', 'J', 'mzJ`z')

    -- Highlight word with #
    set('n', '#', '#N')
    set('v', '#', [[y/\V<C-r>=escape(@",'/\')<CR><CR>N]])

    -- Make $ behave as spected in visual modes
    set({ 'v', 'n' }, '$', 'g_')

    -- Opposite to J, give a utility to K
    set('n', 'K', 'i<CR><ESC>')

    -- Disable highlight
    set('n', '<C-n>', '<CMD>nohlsearch<CR>')

    -- Paste in word under the cursor without overwriting the yank register
    set('n', '<Leader>p', [["_diwP]])

    -- Keep visual selection after shifting code block
    set({ 'v', 'x' }, '<', '<gv')
    set({ 'v', 'x' }, '>', '>gv')

    -- Swap ' with `
    set('n', "'", '`')

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
    set('n', '<Leader>.', require('csj.core.functions').char_at_eol)

    -- Better navigation inside wrapped text
    set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
    set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

    -- Packer
    set('n', '<Leader>ps', '<CMD>PackerSync<CR>')
    set('n', '<Leader>pc', '<CMD>PackerCompile profile=true<CR>')

    -- Source lua file
    set('n', '<Leader>s', ':luafile %<CR>')
end

-- Nvim-tree
M.nvimtree_keybinds = function()
    set('n', '<Leader>v', '<CMD>NvimTreeToggle<CR>')
end

M.treehopper_keybinds = function()
    set('o', 'm', ':<C-U>lua require("tsht").nodes()<CR>')
    set('v', 'm', ':lua require("tsht").nodes()<CR>')
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
    set('n', 'tt', '<CMD>Telescope<CR>')
    set('n', 't/', '<CMD>Telescope current_buffer_fuzzy_find theme=dropdown<CR>')
    set('n', 't//', '<CMD>Telescope live_grep theme=dropdown<CR>')
    set('n', 'tp', '<CMD>Telescope projects<CR>')
    set('n', 'tf', require('csj.core.telescope').project_files)
end

-- LSP
M.lsp_keymaps = function()
    -- Stop the LS
    set({ 'n', 'v', 'x' }, '<Leader>ls', function()
        vim.lsp.stop_client(vim.lsp.get_active_clients())
    end, buffer)

    -- Code actions
    set({ 'v', 'x' }, '<Leader>ca', vim.lsp.buf.range_code_action, buffer)
    set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer)

    -- Formatting
    set({ 'v', 'x' }, '<Leader><Leader>f', vim.lsp.buf.range_formatting, buffer)
    set('n', '<Leader><Leader>f', vim.lsp.buf.formatting, buffer)

    set('n', '<Leader>r', vim.lsp.buf.rename, buffer) -- Rename
    set('n', 'gd', vim.lsp.buf.definition, buffer) -- Definitions
    set('n', 'gl', vim.diagnostic.open_float, buffer) -- Open diagnostics in a floating window
    set('n', 'gD', vim.lsp.buf.declaration, buffer) -- Declaration
    set('n', 'gr', vim.lsp.buf.references, buffer) -- references
end

return M
