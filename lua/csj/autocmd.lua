-- Automatically reload file if contents changed
vim.cmd([[
    augroup _reload_on_change
        autocmd!
        autocmd FocusGained * :checktime
    augroup end
]])

-- Straight red underline instead of curly line
vim.cmd([[
    augroup _red_underline
        autocmd!
        autocmd BufRead * highlight SpellBad guibg=NONE guifg=NONE gui=underline guisp=red
    augroup end
]])

-- Highlight on yank
vim.cmd([[
    augroup _general_settings
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})
    augroup end

    augroup _git
        autocmd!
        autocmd FileType gitcommit setlocal wrap
        autocmd FileType gitcommit setlocal spell
    augroup end

    augroup _markdown
        autocmd!
        autocmd FileType markdown setlocal wrap
        autocmd FileType markdown setlocal spell
    augroup end

    augroup _auto_resize
        autocmd!
        autocmd VimResized * tabdo wincmd =
    augroup end
]])

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.cmd([[
    augroup _last_position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"zz" | endif
    augroup end
]])

-- Filetype set correctly
vim.cmd([[
    augroup _filetype_correctly
        autocmd!
        autocmd BufNewFile,BufRead *.conf set filetype=dosini
    augroup end
]])

-- Default syntax highlighting for files without extension
vim.cmd([[
    augroup _files_without_extension
        autocmd!
        autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=markdown | endif
    augroup end
]])

-- Trim whitespace on save
vim.cmd([[
    augroup _trim_whitespace
        autocmd!
        autocmd BufWritePre * :%s/\s\+$//e
    augroup end
]])

-- Indentation override for this type of files
vim.cmd([[
    augroup _indent_filetype
        autocmd!
        autocmd FileType css,html,scss,xhtml,xml setlocal shiftwidth=2 tabstop=2
        autocmd FileType go setlocal shiftwidth=8 tabstop=8
    augroup end
]])

-- Highlight words matching the word under cursor, other colors :so $VIMRUNTIME/syntax/hitest.vim
vim.cmd([[
    augroup _highlight_match
        autocmd!
        autocmd CursorMoved * exe printf('match RedrawDebugComposed /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    augroup end
]])

-- Show cursor only in active window
vim.cmd([[
    augroup _cursor_on_active_window
        autocmd InsertLeave,WinEnter * set cursorline cursorcolumn
        autocmd InsertEnter,WinLeave * set nocursorline nocursorcolumn
    augroup end
]])

-- Colors in visual mode
vim.cmd([[
    augroup _colored_visualmode
        autocmd!
        autocmd ColorScheme * highlight Visual cterm=reverse gui=reverse
    augroup end
]])

-- Disable delimiter line in certain type of files
vim.cmd([[
    augroup _disable_colorcolumn
        autocmd!
        autocmd FileType conf,dosini,help,html,markdown,text,zsh setlocal colorcolumn=0
    augroup end
]])

-- Make the selected option in completion menus in a solid color
vim.cmd([[
    augroup _solid_color_selection
        autocmd!
        autocmd ColorScheme * highlight PmenuSel blend=0
    augroup end
]])

-- Insert cursor in orange, doesn't work in Konsole
vim.cmd([[
    augroup _orange_cursor_insertmode
        autocmd!
        autocmd ColorScheme * highlight iCursor guifg=white guibg=orange
    augroup end
]])

-- Disable autocomment when pressing enter
vim.cmd([[
    augroup _disablecomment
        autocmd!
        autocmd BufWinEnter * :set formatoptions-=cro
    augroup end
]])

-- Hide last run command in the command line after 3 seconds
vim.cmd([[
    augroup _cmdline
        autocmd!
        autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 6000)
    augroup end
]])

-- Write to all buffers when exit
vim.cmd([[
    augroup ConfigGroup
        autocmd!
        autocmd FocusLost * silent! wa!
    augroup end
]])

-- Switch to numbers when in insert mode, and to relative numbers when in command mode
vim.cmd([[
    augroup _number_toggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup end
]])
