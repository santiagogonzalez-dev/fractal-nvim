-- -- Actions on active/inactive window
-- vim.api.nvim_create_augroup('_focused_window_behaviour', {})

-- vim.api.nvim_create_autocmd('WinEnter', {
--   desc = 'Show cursor only in active window',
--   group = '_focused_window_behaviour',
--   callback =function ()
--     vim.opt_local.cursorline = true
--     vim.opt_local.cursorcolumn = true
--   end
-- })

-- vim.api.nvim_create_autocmd('WinLeave', {
--   desc = 'Show cursor only in active window',
--   group = '_focused_window_behaviour',
--   callback = function()
--     vim.opt_local.cursorline = false
--     vim.opt_local.cursorcolumn = false
--   end,
-- })

-- Session managment
vim.api.nvim_create_augroup('_session_opts', { clear = false })

vim.api.nvim_create_autocmd('FocusGained', {
  desc = 'Check if any file has changed when Vim is focused',
  group = '_session_opts',
  command = 'silent! checktime',
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  group = '_session_opts',
  callback = function()
    if vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf()) then
      if not vim.tbl_contains({ 'help', 'packer', 'toggleterm' }, vim.bo.ft) then
        if vim.fn.line([['"]]) > 1 and vim.fn.line([['"]]) <= vim.fn.line('$') then
          return vim.cmd([[norm g'"]]) -- g'" for including column
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
  desc = 'Actions when the file is changed outside of Neovim',
  group = '_session_opts',
  callback = function()
    vim.notify('File changed, reloading the buffer', vim.log.levels.WARN)
  end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'CursorHold' }, {
  desc = 'Actions when the file is changed outside of Neovim',
  group = '_session_opts',
  command = "if getcmdwintype() == '' | checktime | endif",
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
  command = [[:%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = '_session_opts',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 300 }
  end,
})

-- First load
vim.api.nvim_create_augroup('_first_load', { clear = true })

vim.api.nvim_create_autocmd('CursorMoved', {
  desc = 'Enable relativenumber after 2 seconds',
  group = '_first_load',
  once = true,
  callback = function()
    return vim.defer_fn(function()
      vim.opt.relativenumber = true
    end, 2000)
  end,
})

-- Cursor column actions
vim.api.nvim_create_augroup('_switch_cursorcolumn', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  desc = 'Switch the cursorline mode based on context',
  group = '_switch_cursorcolumn',
  command = "if &nu && mode() != 'i' | set rnu | endif",
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  desc = 'Switch the cursorline mode based on context',
  group = '_switch_cursorcolumn',
  command = 'if &nu | set nornu | endif',
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

-- Save and restore sessions
vim.api.nvim_create_augroup('_save_session', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWinLeave', 'BufLeave' }, {
  desc = 'Save the view of the buffer',
  pattern = '*.*',
  group = '_save_session',
  command = 'mkview',
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Load the view of the buffer',
  pattern = '*.*',
  group = '_save_session',
  command = 'silent! loadview',
})
