local M = {}
local set = vim.keymap.set
local expr = { expr = true }
local buffer = { buffer = true }

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

    -- Semicolon
    set('n', '<Leader>;', '$a;<Esc>')
    set('v', '<Leader>;', ":'<,'>norm A;<Cr>")

    -- Colon
    set('n', '<Leader>:', '$a:<Esc>')

    -- Backslash
    set('n', '<Leader>\\', '$a \\<Esc>')

    -- Comma
    set('n', '<Leader>,', '$a,<Esc>')
    set('v', '<Leader>,', ":'<,'>norm A,<Cr>")

    -- Dot
    set('n', '<Leader>.', '$a.<Esc>')

    -- Avoid moving the cursor with space, enter or backspace when in normal mode
    set('n', '<Space>', '<Nop>')
    set('n', '<Cr>', '<Nop>')
    set('n', '<Bs>', '<Nop>')

    -- Write and reload the file
    set('n', '<Leader>e', '<Cmd>w<Cr> | <Cmd>source %<Cr>zz')

    -- Toggle cursor line and column
    set('n', '<Leader>C', '<Cmd>set cul! cuc!<Cr>')

    -- Insert skeleton
    set('n', '<Leader>sk', ':0read ~/.config/nvim/skeletons/')

    -- Quit
    set('n', '<Leader>qq', '<Cmd>q<Cr>')

    -- Smart quit
    set('n', '<C-q>', require('csj.functions').close_or_quit)

    -- Close buffer
    set('n', '<Leader>qb', '<Cmd>bdelete<Cr>')

    -- Quit all buffers
    set('n', '<Leader>Q', '<Cmd>bufdo bdelete<Cr>')

    -- Write buffer
    set('n', '<Leader>w', '<Cmd>w<Cr>')

    -- Write to all buffers and quit
    set('n', '<Leader>x', '<Cmd>wqa<Cr>')

    -- Write buffers as sudo
    set('n', '<Leader>W', '%!sudo tee > /dev/null %')

    -- Navigate buffers
    set('n', '<Tab>', ':bnext<Cr>')
    set('n', '<S-Tab>', ':bprevious<Cr>')
    set('n', '<S-h>', ':bnext<Cr>')
    set('n', '<S-l>', ':bprevious<Cr>')

    -- Window Navigation
    set('n', '<C-h>', '<C-w>h')
    set('n', '<C-j>', '<C-w>j')
    set('n', '<C-k>', '<C-w>k')
    set('n', '<C-l>', '<C-w>l')

    -- Resize windows
    set('n', '<C-Up>', ':resize +2<CR>')
    set('n', '<C-Down>', ':resize -2<CR>')
    set('n', '<C-Left>', ':vertical resize +2<CR>')
    set('n', '<C-Right>', ':vertical resize -2<CR>')

    -- Move current block of text up and down
    set('n', '<A-j>', ':m .+1<Cr>==') -- Normal mode
    set('n', '<A-k>', ':m .-2<Cr>==')
    set('v', '<A-j>', ":m '>+1<Cr>gv=gv") -- Visual mode
    set('v', '<A-k>', ":m '<-2<Cr>gv=gv")
    set('i', '<A-j>', "<Esc>:m .+1<Cr>==gi") -- Insert mode
    set('i', '<A-k>', "<Esc>:m .-2<Cr>==gi")

    -- Center commands
    set('n', 'n', 'nzzzv')
    set('n', 'N', 'Nzzzv')
    set('v', 'y', 'myy`y')
    set('v', 'Y', 'myY`y')
    set('v', 'J', 'mzJ`z')

    -- Opposite to J
    set('n', 'K', 'i<Cr><Esc>')

    -- Folds
    set('n', 'zo', 'zo^')
    set('n', 'zp', 'zfip')
    set('n', '<Leader>m', '<Cmd>mkview<Cr>')

    -- Paste text without overwriting yank register
    set('v', 'p', '"_dP')

    -- Delete word under cursor and paste contents
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
    set('n', '<Leader>pc', '<Cmd>PackerCompile<Cr>')

    -- Hop
    set('n', '<Leader>h', ':HopPattern<Cr>')

    -- Toggle nvim-tree
    set('n', '<Leader>v', '<Cmd>NvimTreeToggle<Cr>') -- set('n', '<leader>v', ':Lex 30<cr>')

    -- Toggle Indent Blankline
    set('n', '<Leader>i', '<Cmd>IndentBlanklineToggle<Cr>')

    -- Gitsigns
    set('n', '<Leader>gj', '<Cmd>Gitsigns next_hunk<Cr>') -- Move to the next hunk
    set('n', '<Leader>gk', '<Cmd>Gitsigns prev_hunk<Cr>') -- Move to the previous hunk
    set('n', '<Leader>ghp', '<Cmd>Gitsigns preview_hunk<Cr>') -- Preview hunk
    set('n', '<Leader>ghr', '<Cmd>Gitsigns reset_hunk<Cr>') -- Reset hunk
    set('n', '<Leader>ghb', '<Cmd>Gitsigns reset_buffer<Cr>') -- Reset buffer hunk

    -- Cycle through relative number and number
    set('n', '<Leader>nt', '<Cmd>call Cycle_numbering()<Cr>')

    -- Telescope
    set('n', '<Leader>t', ':Telescope<Cr>')
    -- Lists files in your current working directory, respects .gitignore
    set('n', '<Leader>ff', '<Cmd>lua require"telescope.builtin".find_files(require("telescope.themes").get_dropdown({}))<Cr>')
    -- Fuzzy search through the output of git ls-files command, respects .gitignore, optionally ignores untracked files
    set('n', '<Leader>fg', '<Cmd>lua require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({ previewer = false }))<Cr>')
    set('n', '<Leader>b', '<Cmd>lua require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))<Cr>')
    set('n', '<Leader>p', '<Cmd>lua require("telescope").extensions.projects.projects()<Cr>')
    set('n', '<Leader>fd', '<Cmd>Telescope live_grep<Cr>') -- live_grep respects .gitignore
    set('n', '<Leader>r', '<Cmd>Telescope lsp_references<Cr>')
    set('n', '<Leader>gb', '<Cmd>Telescope git_branches<Cr>')
end

function M.lsp_keymaps()
    set('n', '<Leader>ca', vim.lsp.buf.code_action, buffer)
    set('n', '<Leader>F', vim.lsp.buf.formatting_sync, buffer)
    set('n', 'gD', vim.lsp.buf.declaration, buffer)
    set('n', 'gd', vim.lsp.buf.definition, buffer)
    set('n', 'gl', vim.diagnostic.open_float, buffer)
    set('n', 'gr', vim.lsp.buf.references, buffer)
    set('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<Cr>', buffer)
    set('n', ']d', '<Cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<Cr>', buffer)
end

return M
