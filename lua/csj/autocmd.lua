-- FileType options
vim.api.nvim_create_augroup('_filetype_options', {})

vim.api.nvim_create_autocmd('FileType', {
    desc = 'Quit with q in this filetypes',
    group = '_filetype_options',
    pattern = 'qf,help,man,lspinfo,startuptime,Trouble',
    callback = function()
        vim.keymap.set('n', 'q', '<CMD>close<CR>')
    end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Filetype set correctly',
    group = '_filetype_options',
    pattern = '*.conf',
    callback = function()
        vim.opt.filetype = 'dosini'
    end,
})

-- Cursor only on active window
vim.api.nvim_create_augroup('_cursor_active_window', {})

vim.api.nvim_create_autocmd('WinEnter', {
    desc = 'Show cursor only in active window',
    group = '_cursor_active_window',
    command = 'setlocal cursorline cursorcolumn',
})

vim.api.nvim_create_autocmd('WinLeave', {
    desc = 'Show cursor only in active window',
    group = '_cursor_active_window',
    command = 'setlocal nocursorline nocursorcolumn',
})

-- Session managment
vim.api.nvim_create_augroup('_session_opts', {})

vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Open file at the last position it was edited earlier',
    group = '_session_opts',
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif]],
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
    desc = 'Actions when the file is changed outside of Neovim',
    group = '_session_opts',
    callback = function()
        vim.notify('The file has been changed, reloading the buffer', vim.log.levels.WARN)
    end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'CursorHold' }, {
    desc = 'Actions when the file is changed outside of Neovim',
    group = '_session_opts',
    command = [[if getcmdwintype() == '' | checktime | endif]],
})

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Create missing directories before saving the buffer',
    once = true,
    group = '_session_opts',
    callback = function()
        vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
    end,
})

vim.api.nvim_create_autocmd('VimResized', {
    desc = 'Autoresize, ensures splits are equal width when resizing vim',
    group = '_session_opts',
    command = 'tabdo wincmd =',
})

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Trim whitespace on save',
    group = '_session_opts',
    command = [[:%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight on yank',
    group = '_session_opts',
    callback = vim.highlight.on_yank,
})

-- Number column actions
local _switch_cursorcolumn = vim.api.nvim_create_augroup('_switch_cursorcolumn', {})
local _first_load = vim.api.nvim_create_augroup('_first_load', { clear = true })

vim.api.nvim_create_autocmd('CursorMoved', {
    desc = 'Enable relativenumber after 3 seconds',
    group = _first_load,
    once = true,
    callback = function()
        vim.defer_fn(function()
            vim.opt.relativenumber = true
        end, 3000)
    end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
    desc = 'Switch the cursorline mode based on context',
    group = _switch_cursorcolumn,
    command = "if &nu && mode() != 'i' | set rnu | endif",
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    desc = 'Switch the cursorline mode based on context',
    group = _switch_cursorcolumn,
    command = 'if &nu | set nornu | endif',
})

vim.api.nvim_create_autocmd('CmdLineEnter', {
    desc = 'Switch the cursorline mode based on context',
    group = _switch_cursorcolumn,
    callback = function()
        vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd('CmdLineLeave', {
    desc = 'Switch the cursorline mode based on context',
    buffer = 0,
    group = _switch_cursorcolumn,
    callback = function()
        vim.opt.relativenumber = true
    end,
})
