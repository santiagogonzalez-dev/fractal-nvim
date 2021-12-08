-- Automatically reload file if contents changed
vim.cmd([[ autocmd FocusGained * :checktime ]])

-- Straight red underline instead of curly line
vim.cmd([[ autocmd BufRead * highlight SpellBad guibg=NONE guifg=NONE gui=underline guisp=red ]])

-- Highlight on yank
vim.cmd([[ autocmd TextYankPost * silent! lua vim.highlight.on_yank {} ]])

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.cmd([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"zz" | endif ]])

-- Filetype set correctly
vim.cmd([[ autocmd BufNewFile,BufRead *.conf set filetype=dosini ]])

-- Default syntax highlighting for files without extension
vim.cmd([[ autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=markdown | endif ]])

-- Trim whitespace on save
vim.cmd([[ autocmd BufWritePre * :%s/\s\+$//e ]])

-- Indentation override for this type of files
vim.cmd([[ autocmd FileType css,html,scss,xhtml,xml setlocal shiftwidth=2 tabstop=2 ]])
vim.cmd([[ autocmd FileType go setlocal shiftwidth=8 tabstop=8 ]])

-- Highlight words matching the word under cursor, other colors :so $VIMRUNTIME/syntax/hitest.vim
-- vim.cmd([[ autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')) ]])
vim.cmd([[ autocmd CursorMoved * exe printf('match RedrawDebugComposed /\V\<%s\>/', escape(expand('<cword>'), '/\')) ]])

-- Show cursor only in active window
vim.cmd([[ autocmd InsertLeave,WinEnter * set cursorline cursorcolumn ]])
vim.cmd([[ autocmd InsertEnter,WinLeave * set nocursorline nocursorcolumn ]])

-- Colors in visual mode
vim.cmd([[ autocmd ColorScheme * highlight Visual cterm=reverse gui=reverse ]])

-- Disable delimiter line in certain type of files
vim.cmd([[ autocmd FileType conf,dosini,help,html,markdown,text,zsh setlocal colorcolumn=0 ]])

-- Make the selected option in a solid color
vim.cmd([[ autocmd ColorScheme * highlight PmenuSel blend=0 ]])

-- Insert cursor in orange, doesn't work in Konsole
vim.cmd([[ autocmd ColorScheme * highlight iCursor guifg=white guibg=orange ]])

-- Disable autocomment when pressing enter
vim.cmd([[ autocmd BufWinEnter * :set formatoptions-=c formatoptions-=r formatoptions-=o ]])

-- Hide last run command in the command line after 3 seconds
vim.cmd([[
    augroup cmdline
        autocmd!
        autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 6000)
    augroup END
]])

-- Write to all buffers when exit
vim.cmd([[
    augroup ConfigGroup
        autocmd!
        autocmd FocusLost * silent! wa!
    augroup END
]])

-- Switch to numbers when in insert mode, and to relative numbers when in command mode
vim.cmd([[
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup END
]])
