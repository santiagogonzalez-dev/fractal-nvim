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
  group = session_opts,
  callback = function()
    return vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
  end,
})

-- First load
local first_load = vim.api.nvim_create_augroup('first_load', {})

vim.api.nvim_create_autocmd('UIEnter', {
  desc = 'Print the output of flag --startuptime startuptime.txt',
  group = first_load,
  pattern = 'init.lua',
  once = true,
  callback = function()
    vim.defer_fn(function()
      return vim.fn.filereadable('startuptime.txt') == 1
        and vim.cmd(':!tail -n3 startuptime.txt')
        and vim.fn.delete('startuptime.txt')
    end, 1000)
  end,
})

-- Globals
local buffer_settings = vim.api.nvim_create_augroup('buffer_settings', {})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Quit with q in this filetypes',
  group = buffer_settings,
  pattern = {
    'help',
    'lspinfo',
    'man',
    'netrw',
    'qf',
    'startuptime',
  },
  callback = function()
    vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = 0 })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Quit! with q! in this filetypes',
  group = buffer_settings,
  pattern = 'TelescopePrompt',
  callback = function()
    vim.keymap.set('n', 'q', ':q!<CR>', { buffer = 0 })
  end,
})

-- TODO(santigo-zero): Put this elsewhere
vim.api.nvim_create_autocmd('OptionSet', {
  desc = 'Make the cursorline appear only on the active window/pan',
  pattern = 'cursorcolumn',
  callback = function()
    vim.api.nvim_create_autocmd('WinEnter', {
      group = buffer_settings,
      callback = function()
        vim.opt.cursorline = true
        vim.opt.cursorcolumn = true
      end,
    })
    vim.api.nvim_create_autocmd('WinLeave', {
      group = buffer_settings,
      callback = function()
        vim.opt.cursorline = false
        vim.opt.cursorcolumn = false
      end,
    })
  end,
})

vim.api.nvim_create_autocmd('CmdLineEnter', {
  desc = 'Hotfix for cmdheight = 0 not showing :s///g',
  pattern = 'buffer_settings',
  callback = function()
    vim.opt.cmdheight = 1
  end,
})

vim.api.nvim_create_autocmd('CmdLineLeave', {
  desc = 'Hotfix for cmdheight = 0 not showing :s///g',
  pattern = 'buffer_settings',
  callback = function()
    vim.opt.cmdheight = 0
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Trim whitespace on save',
  group = 'session_opts',
  callback = function()
    if not vim.o.binary and vim.o.filetype ~= 'diff' then
      local current_view = vim.fn.winsaveview()
      vim.cmd([[keeppatterns %s/\s\+$//e]])
      return vim.fn.winrestview(current_view)
    end
  end,
})

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Autoresize, ensures splits are equal width when resizing vim',
  group = 'session_opts',
  command = 'tabdo wincmd =',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = 'session_opts',
  callback = function()
    pcall(vim.highlight.on_yank, { higroup = 'Visual', timeout = 600 })
  end,
})
