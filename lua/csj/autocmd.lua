vim.api.nvim_create_autocmd('TextYankPost', {
   desc = 'Highlight on yank',
   callback = function()
      vim.highlight.on_yank({ higroup = 'Visual' })
   end,
})

vim.api.nvim_create_autocmd('FileType', {
   desc = 'Quit with q in this filetypes',
   pattern = 'qf,help,man,lspinfo,startuptime,Trouble',
   callback = function()
      vim.keymap.set('n', 'q', '<Cmd>close<Cr>')
   end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
   desc = 'Filetype set correctly',
   pattern = '*.conf',
   callback = function()
      vim.opt.filetype = 'dosini'
   end,
})

vim.api.nvim_create_autocmd('VimResized', {
   desc = 'Autoresize, ensures splits are equal width when resizing vim',
   command = 'tabdo wincmd =',
})

vim.api.nvim_create_autocmd('BufWritePre', {
   desc = 'Trim whitespace on save',
   command = [[:%s/\s\+$//e]],
})

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

vim.api.nvim_create_autocmd('CmdLineLeave', {
   desc = 'Hide last run command in the command line after N seconds',
   pattern = ':',
   callback = function()
      vim.defer_fn(function()
         vim.cmd('echo ""')
      end, 1000)
   end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
   desc = 'Open file at the last position it was edited earlier',
   command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif]],
})

vim.api.nvim_create_autocmd('BufWritePre', {
   desc = 'Create missing directories before saving the buffer',
   callback = function()
      vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
   end,
})

vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
   desc = 'LSP Diagnostics',
   callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
   end,
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
