vim.api.nvim_create_autocmd({
    event = 'TextYankPost',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual' })
    end,
    desc = 'Highlight on yank',
})

vim.api.nvim_create_autocmd({
    event = 'FileType',
    pattern = 'qf,help,man,lspinfo,startuptime',
    callback = function()
        vim.keymap.set('n', 'q', '<Cmd>close<Cr>')
    end,
    desc = 'Quit with q in this filetypes',
})

vim.api.nvim_create_autocmd({
    event = { 'BufNewFile', 'BufRead' },
    pattern = '*.conf',
    callback = function()
        vim.opt.filetype = 'dosini'
    end,
    desc = 'Filetype set correctly',
})

vim.api.nvim_create_autocmd({
    event = 'VimResized',
    pattern = '*',
    command = 'tabdo wincmd =',
    desc = 'Autoresize, ensures splits are equal width when resizing vim',
})

vim.api.nvim_create_autocmd({
    event = 'BufWritePre',
    pattern = '*',
    command = [[:%s/\s\+$//e]],
    desc = 'Trim whitespace on save',
})

vim.api.nvim_create_autocmd({
    event = 'WinEnter',
    pattern = '*',
    command = 'setlocal cursorline cursorcolumn',
    desc = 'Show cursor only in active window'
})

vim.api.nvim_create_autocmd({
    event = 'WinLeave',
    pattern = '*',
    command = 'setlocal nocursorline nocursorcolumn',
})

vim.api.nvim_create_autocmd({
    event = 'BufEnter',
    pattern = '*',
    callback = function()
        vim.opt.formatoptions:remove({ 'o' })
    end,
    desc = 'Remove continuation of comments when creating a new line via `o`',
})

vim.api.nvim_create_autocmd({
    event = 'CmdLineLeave',
    pattern = ':',
    callback = function()
        vim.defer_fn(function()
            vim.cmd('echo ""')
        end, 12000)
    end,
    desc = 'Hide last run command in the command line after N seconds',
})

vim.api.nvim_create_autocmd({
    event = 'BufReadPost',
    pattern = '*',
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif]],
    desc = 'Open file at the last position it was edited earlier',
})

vim.api.nvim_create_autocmd({
    event = 'BufWritePre',
    pattern = '*',
    once = true,
    callback = function()
        vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
    end,
    desc = 'Create missing directories before saving the buffer',
})

vim.api.nvim_create_autocmd({
    event = { 'CursorHold', 'CursorHoldI' },
    pattern = '*',
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
    desc = 'LSP Diagnostics',
})

-- Skeletons
vim.cmd([[
    augroup _insert_skeleton
        autocmd!
        autocmd BufNewFile * silent! execute '0r ~/.config/nvim/skeletons/skeleton.'.expand("<afile>:e")
        autocmd BufNewFile * silent! execute 'norm Gdd'
    augroup END
]])

-- Switch to numbers when while on insert mode or cmd mode, and to relative numbers when in normal mode
vim.cmd([[
    augroup _number_toggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
        autocmd CmdLineEnter * set norelativenumber
        autocmd CmdLineLeave * set relativenumber
    augroup END
]])
