local utils = require('csj.utils')

-- Session managment
local session_opts = vim.api.nvim_create_augroup('session_opts', { clear = false })

vim.api.nvim_create_autocmd('FocusGained', {
    desc = 'Check if any file has changed when Vim is focused',
    group = session_opts,
    command = 'silent! checktime',
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
    desc = 'Actions when the file is changed outside of Neovim',
    group = session_opts,
    callback = function()
        vim.notify('File changed, reloading the buffer', vim.log.levels.WARN)
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Create missing directories before saving the buffer',
    once = true,
    group = session_opts,
    callback = function()
        return vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
    end,
})

-- First load
local first_load = vim.api.nvim_create_augroup('first_load', { clear = true })

vim.api.nvim_create_autocmd('UIEnter', {
    desc = 'Enable relativenumber after 2 seconds',
    group = first_load,
    once = true,
    callback = function()
        return vim.defer_fn(function()
            vim.opt.relativenumber = true
        end, 2000)
    end,
})

vim.api.nvim_create_autocmd('UIEnter', {
    desc = 'Print the output of flag --startuptime startuptime_nvim.md',
    group = first_load,
    pattern = 'init.lua',
    once = true,
    callback = utils.wrap(vim.defer_fn, function()
        return vim.fn.filereadable('startuptime_nvim.md') == 1 and vim.cmd(':!tail -n3 startuptime_nvim.md') and vim.fn.delete('startuptime_nvim.md')
    end, 1000),
})

-- Cursor column actions
local switch_cursorcolumn = vim.api.nvim_create_augroup('switch_cursorcolumn', {})

vim.api.nvim_create_autocmd({ 'FocusGained', 'InsertLeave', 'CmdLineLeave' }, {
    desc = 'Switch the cursorline mode based on context',
    group = switch_cursorcolumn,
    callback = function()
        if vim.opt.number:get() and vim.fn.mode() ~= 'i' then
            vim.opt.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    desc = 'Switch the cursorline mode based on context',
    group = switch_cursorcolumn,
    callback = function()
        if vim.opt.number:get() then
            vim.opt.relativenumber = false
        end
    end,
})

vim.api.nvim_create_autocmd('CmdLineEnter', {
    desc = 'Switch the cursorline mode based on context',
    group = switch_cursorcolumn,
    callback = function()
        vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd('CmdLineLeave', {
    desc = 'Switch the cursorline mode based on context',
    buffer = 0,
    group = switch_cursorcolumn,
    callback = function()
        vim.opt.relativenumber = true
    end,
})

-- Globals
local buffer_settings = vim.api.nvim_create_augroup('buffer_settings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    desc = 'Quit with q in this filetypes',
    group = buffer_settings,
    pattern = 'netrw,qf,help,man,lspinfo,startuptime',
    callback = function()
        vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'cursorcolumn',
    callback=function ()
        vim.api.nvim_create_autocmd('WinEnter', {
            group = buffer_settings,
            callback=function ()
                vim.opt.cursorline = true
                vim.opt.cursorcolumn = true
            end
        })
        vim.api.nvim_create_autocmd('WinLeave', {
            group = buffer_settings,
            callback=function ()
                vim.opt.cursorline = false
                vim.opt.cursorcolumn = false
            end
        })
    end
})

-- Conditionals
local conditionals = vim.api.nvim_create_augroup('conditionals', {})
vim.api.nvim_create_autocmd('DirChanged', {
    group = conditionals,
    callback = utils.wrap(vim.schedule_wrap, utils.is_git()),
})
