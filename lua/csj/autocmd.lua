-- FileType options
vim.api.nvim_create_augroup('_filetype_options', {})

vim.api.nvim_create_autocmd('FileType', {
   desc = 'Quit with q in this filetypes',
   group = '_filetype_options',
   pattern = 'qf,help,man,lspinfo,startuptime,Trouble',
   callback = function()
      vim.keymap.set('n', 'q', '<Cmd>close<Cr>')
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

vim.api.nvim_create_autocmd('BufWritePre', {
   desc = 'Create missing directories before saving the buffer',
   group = '_session_opts',
   callback = function()
      vim.fn.mkdir(vim.fn.expand('%:p:h'), 'p')
   end,
})

-- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--    desc = 'LSP Diagnostics',
--    group = '_session_opts',
--    callback = function()
--       vim.diagnostic.open_float(nil, { focus = false })
--    end,
-- })

-- vim.api.nvim_create_autocmd('CmdLineLeave', {
--    desc = 'Hide last run command in the command line after N seconds',
--    group = '_session_opts',
--    pattern = ':',
--    callback = function()
--       vim.defer_fn(function()
--          vim.cmd('echo ""')
--       end, 1000)
--    end,
-- })

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
      vim.highlight.on_yank({ higroup = 'Visual' })
   end,
})

-- -- Skeletons
-- vim.api.nvim_create_augroup('_insert_skeleton', {})

-- vim.api.nvim_create_autocmd('BufNewFile', {
--    desc = 'Insert skeletons on empty files',
--    group = '_insert_skeleton',
--    command = [[execute '0r ~/.config/nvim/skeletons/skeleton.'.expand("<afile>:e")]],
-- })

-- vim.api.nvim_create_autocmd('BufNewFile', {
--    desc = 'Insert skeletons on empty files',
--    group = '_insert_skeleton',
--    command = [[execute 'norm Gdd']],
-- })

-- Switch to numbers when while on insert mode or cmd mode, and to relative numbers when in normal mode
vim.api.nvim_create_augroup('_switch_cursorcolumn', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
   desc = 'Switch the cursorline mode based on context',
   group = '_switch_cursorcolumn',
   command = "if &nu && mode() != 'i' | set rnu   | endif",
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
   desc = 'Switch the cursorline mode based on context',
   group = '_switch_cursorcolumn',
   command = 'if &nu | set nornu | endif',
})

vim.api.nvim_create_autocmd('CmdLineEnter', {
   desc = 'Switch the cursorline mode based on context',
   group = '_switch_cursorcolumn',
   command = 'set norelativenumber',
})

vim.api.nvim_create_autocmd('CmdLineLeave', {
   desc = 'Switch the cursorline mode based on context',
   group = '_switch_cursorcolumn',
   command = 'set norelativenumber',
})

-- vim.api.nvim_create_autocmd('BufWritePre', {
--    desc = 'Format on save',
--    group = '_session_opts',
--    callback = function()
--       vim.lsp.buf.formatting_sync(nil, 1000)
--    end,
-- })
