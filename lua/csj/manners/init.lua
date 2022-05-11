local manners = {}

-- TODO(santigo-zero): ci( and ci) will work normally, and  c( and c) should work line wise, fix this
-- The same goes for di( and di) and d( and d). Also maintain the column when pasting
-- vim.keymap.set('n', 'c)', 'ci)', { desc = 'c} does the same and I prefer using it'})
-- vim.keymap.set('n', 'c(', 'ci(', { desc = 'c{ does the same and I prefer using it'})

-- Make dead keys
local dead_keys = { '<Space>', '<BS>', '<Down>', '<Left>', '<Right>', '<Up>', 'q:' }
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

-- Simple keymappings
vim.keymap.set('n', '<Leader>u', '<CMD>update<CR>', { desc = 'Update the file' })
vim.keymap.set('n', '<Leader>E', '<CMD>edit<CR>', { desc = 'Reload file manually' })
vim.keymap.set('n', '<Leader>q', '<CMD>quit<CR>', { desc = 'Quit neovim' })
vim.keymap.set('n', '<Leader>w', '<CMD>wqall<CR>', { desc = 'Write and Quit' })
vim.keymap.set('n', '<Leader>Q', '<CMD>bufdo bdelete<CR>', { desc = 'Delete all buffers' })
vim.keymap.set('n', '<Leader>p', [["_diwP]], { desc = 'Paste in word under the cursor without overwriting the yank register' })
vim.keymap.set('n', '<Leader>s', ':luafile %<CR>', { desc = 'Source lua file' })

vim.keymap.set('n', '<Leader>e', ':silent! Lexplore!<CR>', { silent = true, desc = 'Open NetRW' })
vim.keymap.set('n', '<Leader>ee', ':silent! Lexplore! %:p:h<CR>', { silent = true, desc = 'Open NetRW in the directory of the current buffer' })

vim.keymap.set('n', '<C-n>', ':bnext<CR>', { silent = true, desc = 'Switch to next buffer' })
vim.keymap.set('n', '<C-p>', ':bprevious<CR>', { silent = true, desc = 'Switch to prev buffer' })

vim.keymap.set('n', '<Leader>ps', '<CMD>PackerSync<CR>', { desc = 'Packer: PackerSync' })
vim.keymap.set('n', '<Leader>pc', '<CMD>PackerCompile profile=true<CR>', { desc = 'Packer: PackerCompile' })

vim.keymap.set('n', "'", '`', { desc = "Swap ' with `" })
vim.keymap.set('n', '<CR>', 'i<CR><ESC>', { desc = 'Normal <CR> behaviour, opposite to J' })
vim.keymap.set('n', '<A-n>', '<CMD>nohlsearch<CR>', { desc = 'Disable highlight' })
vim.keymap.set({ 'v', 'n' }, '$', 'g_', { desc = 'Make $ behave as spected in visual modes' })
vim.keymap.set('n', 'gvp', [['`[' . strpart(getregtype(), 0, 1) . '`]']], { expr = true })
vim.keymap.set('n', 'cg*', '*Ncgn', { desc = 'Find and replace next match of the word under cursor' })
vim.keymap.set({ 'n', 'x', 'o' }, 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'n is always next' })
vim.keymap.set({ 'n', 'x', 'o' }, 'N', '"nN"[v:searchforward]', { expr = true, desc = 'N is always previous' })
vim.keymap.set('n', '^^', '0', { desc = 'Better ^' })
vim.keymap.set('n', 'zo', '<CMD>silent! foldopen<CR>', { silent = true, desc = 'Silence this keybind' })
vim.keymap.set('n', 'zc', '<CMD>silent! foldclose<CR>', { silent = true, desc = 'Silence this keybind' })

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

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center commands' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center commands' })
vim.keymap.set('n', 'J', 'mzJ`zzv', { desc = 'Center commands' })

vim.keymap.set('n', '#', '*Nzv', { desc = 'Better #' })
vim.keymap.set('v', '#', [[y/\V<C-r>=escape(@",'/\')<CR><CR>N]], { desc = 'Better #' })

vim.keymap.set({ 'v', 'x' }, '<', '<gv', { desc = 'Keep visual selection after shifting code block' })
vim.keymap.set({ 'v', 'x' }, '>', '>gv', { desc = 'Keep visual selection after shifting code block' })

function manners.strict_cursor()
    -- TODO(santigo-zero): use the api, not vim.cmd
    local function h_motion()
        local cursor_position = vim.api.nvim_win_get_cursor(0)

        vim.cmd('normal ^')
        local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

        if cursor_position[2] <= first_non_blank_char[2] then
            return vim.cmd('normal 0')
        else
            vim.api.nvim_win_set_cursor(0, cursor_position)
            return vim.cmd('normal! h')
        end
    end

    local function l_motion()
        local cursor_position = vim.api.nvim_win_get_cursor(0)

        vim.cmd('normal ^')
        local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

        if cursor_position[2] < first_non_blank_char[2] then
            return vim.cmd('normal ^')
        else
            vim.api.nvim_win_set_cursor(0, cursor_position)
            return vim.cmd('normal! l')
        end
    end

    local function switcher(mode)
        if mode then
            vim.keymap.set('n', 'h', function()
                h_motion()
            end)
            vim.keymap.set('n', 'l', function()
                l_motion()
            end)
            vim.opt.virtualedit = ''
            vim.g.strict_cursor = false
        else
            vim.opt.virtualedit = 'all' -- Be able to put the cursor where there's not actual text
            vim.keymap.del('n', 'h')
            vim.keymap.del('n', 'l')
            vim.g.strict_cursor = true
        end
    end

    switcher(true) -- Enable strict cursor when running the function for the first time
    vim.keymap.set('n', '<Esc><Esc>', function()
        return switcher(vim.g.strict_cursor)
    end)
end
manners.strict_cursor() -- Use stricter cursor movements, only enable virtualedit cursor when pressing <Esc><Esc>

function manners.ask_for_input_on_last_buffer()
    local function actions()
        local count_bufs_by_type = function(loaded_only)
            loaded_only = (loaded_only == nil and true or loaded_only)
            local COUNT = {
                normal = 0,
                acwrite = 0,
                help = 0,
                nofile = 0,
                nowrite = 0,
                quickfix = 0,
                terminal = 0,
                prompt = 0,
            }
            for _, bufname in pairs(vim.api.nvim_list_bufs()) do
                if not loaded_only or vim.api.nvim_buf_is_loaded(bufname) then
                    local buf_type = vim.api.nvim_buf_get_option(bufname, 'buftype')
                    buf_type = buf_type ~= '' and buf_type or 'normal'
                    COUNT[buf_type] = COUNT[buf_type] + 1
                end
            end
            return COUNT
        end

        if count_bufs_by_type().normal <= 1 then
            vim.ui.select({ 'Delete the buffer', 'Quit neovim' }, {}, function(_, prompt)
                if tonumber(prompt) == 1 then
                    return vim.cmd('bd')
                elseif tonumber(prompt) == 2 then
                    return vim.cmd('q')
                end
            end)
        else
            return vim.cmd('bp | sp | bn | bd')
        end
    end
    vim.keymap.set('n', '<Leader>c', actions)
end
manners.ask_for_input_on_last_buffer() -- Ask user for input if there is only one active normal buffer

return manners
