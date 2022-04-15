-- Session managment
vim.api.nvim_create_augroup('_session_opts', { clear = false })

vim.api.nvim_create_autocmd('WinNew', {
  group = '_session_opts',
  callback = function()
    vim.opt.laststatus = 3
  end,
})

vim.api.nvim_create_autocmd('WinLeave', {
  group = '_session_opts',
  callback = function()
    vim.opt.laststatus = 0
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = '_session_opts',
  pattern = { 'checkhealth', 'dockfile', 'dosini', 'help', 'netrw', 'sh', 'zsh' },
  command = 'syntax on',
})

vim.api.nvim_create_autocmd('FocusGained', {
  desc = 'Check if any file has changed when Vim is focused',
  group = '_session_opts',
  command = 'silent! checktime',
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
  desc = 'Actions when the file is changed outside of Neovim',
  group = '_session_opts',
  callback = function()
    vim.notify('File changed, reloading the buffer', vim.log.levels.WARN)
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Create missing directories before saving the buffer',
  once = true,
  group = '_session_opts',
  callback = function()
    return vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
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
  callback = function()
    if not vim.o.binary and vim.o.filetype ~= 'diff' then
      local current_view = vim.fn.winsaveview()
      vim.cmd([[keeppatterns %s/\s\+$//e]])
      vim.fn.winrestview(current_view)
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = '_session_opts',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 300 }
  end,
})

-- vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
--   desc = 'Show cursor only in active window',
--   group = '_session_opts',
--   callback = function()
--     vim.opt_local.cursorline = true
--     vim.opt_local.cursorcolumn = true
--   end,
-- })

-- vim.api.nvim_create_autocmd('WinLeave', {
--   desc = 'Show cursor only in active window',
--   group = '_session_opts',
--   callback = function()
--     vim.opt_local.cursorline = false
--     vim.opt_local.cursorcolumn = false
--   end,
-- })

-- First load
vim.api.nvim_create_augroup('_first_load', { clear = true })

vim.api.nvim_create_autocmd('UIEnter', {
  desc = 'Enable relativenumber after 2 seconds',
  group = '_first_load',
  once = true,
  callback = function()
    return vim.defer_fn(function()
      vim.opt.relativenumber = true
    end, 2000)
  end,
})

vim.api.nvim_create_autocmd('UIEnter', {
  desc = 'Print the output of flag --startuptime startuptime_nvim.md',
  group = '_first_load',
  pattern = 'init.lua',
  once = true,
  callback = function()
    if vim.fn.filereadable('startuptime_nvim.md') == 1 then
      return vim.defer_fn(function()
        vim.cmd(':!tail -n3 startuptime_nvim.md')
        vim.fn.delete('startuptime_nvim.md')
      end, 2000)
    end
  end,
})

-- Cursor column actions
vim.api.nvim_create_augroup('_switch_cursorcolumn', {})

vim.api.nvim_create_autocmd({ 'FocusGained', 'InsertLeave', 'CmdLineLeave' }, {
  desc = 'Switch the cursorline mode based on context',
  group = '_switch_cursorcolumn',
  callback = function()
    if vim.opt.number:get() and vim.fn.mode() ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  desc = 'Switch the cursorline mode based on context',
  group = '_switch_cursorcolumn',
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
})

vim.api.nvim_create_autocmd('CmdLineEnter', {
  desc = 'Switch the cursorline mode based on context',
  group = '_switch_cursorcolumn',
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd('CmdLineLeave', {
  desc = 'Switch the cursorline mode based on context',
  buffer = 0,
  group = '_switch_cursorcolumn',
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Globals
vim.api.nvim_create_augroup('buffer_settings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Quit with q in this filetypes',
  group = 'buffer_settings',
  pattern = 'netrw,qf,help,man,lspinfo,startuptime',
  callback = function()
    vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = 0 })
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Filetype set correctly',
  group = 'buffer_settings',
  pattern = '*.conf',
  callback = function()
    vim.opt.filetype = 'dosini'
  end,
})
