local wrap = require('fractal.utils').wrap
local blink_crosshair = require('fractal.utils').blink_crosshair
local readable = require('fractal.utils').readable
local session_opts = vim.api.nvim_create_augroup('session_opts', {})

vim.api.nvim_create_autocmd('Filetype', {
   desc = "Open help and man pages in a vertical split if there's not enough space",
   group = session_opts,
   pattern = { 'help', 'man' },
   callback = function()
      if vim.opt.lines:get() * 4 < vim.opt.columns:get() and not vim.w.help_is_moved then
         vim.cmd('wincmd L')
         vim.w.help_is_moved = true
      end
   end,
})

vim.api.nvim_create_autocmd('FocusGained', {
   command = 'silent! checktime',
   desc = 'Check if any file has changed when Vim is focused',
   group = session_opts,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
   desc = 'Actions when the file is changed outside of Neovim',
   group = session_opts,
   callback = function() vim.notify('File changed, reloading the buffer', vim.log.levels.WARN) end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
   desc = 'Create directories before saving a buffer, should come by default',
   group = session_opts,
   callback = function() return vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p') end,
})

local first_load = vim.api.nvim_create_augroup('first_load', {})

vim.api.nvim_create_autocmd('UIEnter', {
   desc = 'Print the output of flag --startuptime startuptime.txt',
   group = first_load,
   once = true,
   pattern = '*.lua',
   callback = wrap(vim.defer_fn, function()
      if readable('startuptime.txt') then
         vim.cmd(':!tail -n3 startuptime.txt')
         vim.fn.delete('startuptime.txt')
      end
   end, 1000),
})

-- Globals
local buffer_settings = vim.api.nvim_create_augroup('buffer_settings', {})

vim.api.nvim_create_autocmd('FileType', {
   desc = 'Quit with q in this filetypes',
   group = buffer_settings,
   pattern = { 'help', 'lspinfo', 'man', 'netrw', 'qf' },
   callback = function() vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = 0 }) end,
})

vim.api.nvim_create_autocmd('FileType', {
   desc = 'Quit! with q! in this filetypes',
   group = buffer_settings,
   pattern = 'TelescopePrompt',
   callback = function() vim.keymap.set('n', 'q', ':q!<CR>', { buffer = 0 }) end,
})

vim.api.nvim_create_autocmd('UIEnter', {
   desc = 'Make the cursorline appear only on the active focused window/pan',
   group = buffer_settings,
   callback = function()
      if not vim.opt.cursorcolumn:get() then return end

      vim.api.nvim_create_autocmd({ 'FocusGained', 'WinEnter' }, {
         group = buffer_settings,
         callback = function()
            vim.opt.cursorline = true
            vim.opt.cursorcolumn = true
            blink_crosshair()
         end,
      })

      vim.api.nvim_create_autocmd({ 'FocusLost', 'WinLeave' }, {
         group = buffer_settings,
         callback = function()
            vim.opt.cursorline = false
            vim.opt.cursorcolumn = false
         end,
      })
   end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
   desc = 'Trim whitespace on save',
   group = session_opts,
   callback = function()
      if not vim.o.binary and vim.o.filetype ~= 'diff' then
         local current_view = vim.fn.winsaveview()
         vim.cmd([[keeppatterns %s/\s\+$//e]])
         return vim.fn.winrestview(current_view)
      end
   end,
})

vim.api.nvim_create_autocmd('VimResized', {
   command = 'tabdo wincmd =',
   desc = 'Autoresize, ensures splits are equal width when resizing vim',
   group = session_opts,
})

vim.api.nvim_create_autocmd('TextYankPost', {
   callback = wrap(vim.highlight.on_yank, { higroup = 'Visual', timeout = 600 }),
   desc = 'Highlight on yank',
   group = session_opts,
})

local mouse_original_value = vim.api.nvim_get_option('mouse')
vim.api.nvim_create_autocmd('InsertEnter', {
   desc = 'Disable mouse in insert mode',
   group = session_opts,
   callback = function() vim.opt.mouse = '' end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
   desc = 'Restore default values for mouse',
   group = session_opts,
   callback = function() vim.opt.mouse = mouse_original_value end,
})
