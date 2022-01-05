-- Automatically reload file if contents changed
vim.cmd([[
    augroup _reload_on_change
        autocmd!
        autocmd FocusGained * :checktime
    augroup end
]])

-- Highlight on yank
vim.cmd([[
    augroup _general_settings
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'iCursor', timeout = 333})
    augroup end
]])

-- Filetype set correctly
vim.cmd([[
    augroup _filetype_correctly
        autocmd!
        autocmd BufNewFile,BufRead *.conf set filetype=dosini
    augroup end
]])

vim.cmd([[
    augroup _git
        autocmd!
        autocmd FileType gitcommit setlocal wrap
        autocmd FileType gitcommit setlocal spell
    augroup end
]])

vim.cmd([[
    augroup _markdown
        autocmd!
        autocmd FileType markdown setlocal wrap
        autocmd FileType markdown setlocal spell
    augroup end
]])

vim.cmd([[
    augroup _auto_resize
        autocmd!
        autocmd VimResized * tabdo wincmd =
    augroup end
]])

-- Default settings for files without extension
vim.cmd([[
    augroup _files_without_extension
        autocmd!
        autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | setlocal filetype=markdown syntax=markdown | endif
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

-- Show cursor only in active window
vim.cmd([[
    augroup _cursor_on_active_window
        autocmd InsertLeave,WinEnter * setlocal cursorline cursorcolumn
        autocmd InsertEnter,WinLeave * setlocal nocursorline nocursorcolumn
    augroup end
]])

-- Disable delimiter line in certain type of files
vim.cmd([[
    augroup _disable_colorcolumn
        autocmd!
        autocmd FileType conf,dosini,help,html,markdown,text,zsh setlocal colorcolumn=0
    augroup end
]])

-- Disable autocomment when pressing enter
vim.cmd([[
    augroup _disable_comment
        autocmd!
        autocmd BufWinEnter * set formatoptions-=cro
    augroup end
]])

-- Switch to numbers when while on insert mode or cmd mode, and to relative numbers when in normal mode
vim.cmd([[
    augroup _number_toggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
        autocmd CmdLineEnter * set norelativenumber
        autocmd CmdLineLeave * set relativenumber
    augroup end
]])

-- Show lsp diagnostics in a floating window
vim.cmd([[
    augroup _show_lsp_diagnostics
        autocmd!
        autocmd CursorHold * lua vim.diagnostic.open_float()
    augroup end
]])

-- Hide last run command in the command line after N seconds
vim.cmd([[
    augroup _cmdline
        autocmd!
        autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 12000)
    augroup end
]])

-- Skeletons
vim.cmd([[
    augroup _insert_skeleton
        autocmd!
        autocmd BufNewFile *.* silent! execute '0r ~/.config/nvim/skeletons/skeleton.'.expand("<afile>:e")
    augroup END
]])

-- Save and load view of the file we are working on
vim.cmd([[
    augroup _save_and_load_view
        autocmd!
        autocmd BufWritePre * mkview
        autocmd BufWinEnter * silent! loadview
    augroup end
]])

-- Autocommands that I don't use anymore
-- -- Jump to the last position when reopening a file instead of typing '. to go to the last mark _save_and_load_view
-- -- fixes this already
-- vim.cmd([[
--     augroup _last_position
--         autocmd!
--         autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"zz" | endif
--     augroup end
-- ]])

-- -- Use null-ls to formate text before writing the buffer to the file
-- vim.cmd([[
--     augroup _format_on_exit
--         autocmd!
--         autocmd BufWritePre * lua vim.lsp.buf.formatting()
--     augroup end
-- ]])

-- -- Highlight words matching the word under cursor, other colors :so $VIMRUNTIME/syntax/hitest.vim
-- vim.cmd([[
--     augroup _highlight_match
--         autocmd!
--         autocmd CursorMoved * exe printf('match iCursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))
--     augroup end
-- ]])
