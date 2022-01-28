local M = {}
local set = vim.keymap.set
local expr, buffer, silent = { expr = true }, { buffer = true }, { silent = true }

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
    set('n', '<Cr>', '<Nop>')
    set('n', '<Bs>', '<Nop>')

    -- Insert skeleton
    set('n', '<Leader>sk', ':0read ~/.config/nvim/skeletons/')

    -- Reload the file manually
    set('n', '<Leader>e', '<Cmd>edit!<Cr>')

    -- Close or Quit
    set('n', '<Leader>qq', require('csj.functions').close_or_quit)

    -- Delete all buffers
    set('n', '<Leader>q', '<Cmd>bufdo bdelete<Cr>')

    -- Write
    set('n', '<Leader>w', '<Cmd>write<Cr>', silent)

    -- Quit
    set('n', '<Leader>Q', '<Cmd>quit<Cr>')

    -- Write to all buffers and quit
    set('n', '<Leader>W', '<Cmd>wqall<Cr>')

    -- Navigate buffers
    set('n', '<Tab>', ':bnext<Cr>', silent)
    set('n', '<S-Tab>', ':bprevious<Cr>', silent)
    set('n', '<S-l>', ':bnext<Cr>', silent)
    set('n', '<S-h>', ':bprevious<Cr>', silent)

    -- Window Navigation
    set('n', '<C-h>', '<C-w>h')
    set('n', '<C-j>', '<C-w>j')
    set('n', '<C-k>', '<C-w>k')
    set('n', '<C-l>', '<C-w>l')

    -- Resize windows
    set('n', '<C-Up>', ':resize +1<CR>', silent)
    set('n', '<C-Down>', ':resize -1<CR>', silent)
    set('n', '<C-Left>', ':vertical resize +1<CR>', silent)
    set('n', '<C-Right>', ':vertical resize -1<CR>', silent)

    -- Move current block of text up and down
    set('n', '<A-j>', ':m .+1<Cr>==', silent) -- Normal mode
    set('n', '<A-k>', ':m .-2<Cr>==', silent)
    set('v', '<A-j>', ":m '>+1<Cr>gv=gv", silent) -- Visual mode
    set('v', '<A-k>', ":m '<-2<Cr>gv=gv", silent)
    set('i', '<A-j>', '<Esc>:m .+1<Cr>==gi', silent) -- Insert mode
    set('i', '<A-k>', '<Esc>:m .-2<Cr>==gi', silent)

    -- Center commands
    set('n', 'n', 'nzzzv')
    set('n', 'N', 'Nzzzv')
    set('v', 'y', 'myy`y')
    set('v', 'Y', 'myY`y')
    set('v', 'J', 'mzJ`z')

    -- Opposite to J
    set('n', 'K', 'i<Cr><Esc>')

    -- Make view
    set('n', '<Leader>m', '<Cmd>mkview<Cr>')

    -- Paste in word under the cursor without overwriting the yank register
    set('n', '<Leader>P', [["_diwP]])

    -- Keep visual selection after shifting code block
    set('x', '<', '<gv')
    set('x', '>', '>gv')

    -- Undo break points
    set('i', ',', ',<C-g>u')
    set('i', '.', '.<C-g>u')
    set('i', '!', '!<C-g>u')
    set('i', '?', '?<C-g>u')
    set('i', ' ', ' <C-g>u')
    set('i', '_', '_<C-g>u')
    set('i', '-', '-<C-g>u')
    set('i', '=', '=<C-g>u')
    set('i', '<Cr>', '<Cr><C-g>u')

    -- Better navigation inside wrapped text
    set('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr)
    set('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr)

    -- Packer
    set('n', '<Leader>ps', '<Cmd>PackerSync<Cr>')
    set('n', '<Leader>pc', '<Cmd>PackerCompile profile=true<Cr>')

    -- Nvim-tree
    set('n', '<Leader>v', '<Cmd>NvimTreeToggle<Cr>')
end

-- LSP
function M.lsp_keymaps()
    set('n', '<Leader>lr', '<Cmd>LspRestart<Cr>', buffer)
    set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer)
    set('v', '<Leader>ca', vim.lsp.buf.range_code_action, buffer)
    set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer)
    set('n', '<Leader>F', vim.lsp.buf.formatting_sync, buffer)
    set('n', '<Leader>R', vim.lsp.buf.rename, buffer)
    set('n', 'gD', vim.lsp.buf.declaration, buffer)
    set('n', 'gd', vim.lsp.buf.definition, buffer)
    set('n', 'gl', vim.diagnostic.open_float, buffer)
    set('n', 'gr', vim.lsp.buf.references, buffer)
end

return M
