                              --  AUTOCOMMANDS --

-- Automatically reload file if contents changed
vim.api.nvim_exec([[autocmd FocusGained * :checktime]], true)

-- Show cursor crosshair only in active window
vim.api.nvim_exec([[
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline
autocmd InsertLeave,WinEnter * set cursorcolumn
autocmd InsertEnter,WinLeave * set nocursorcolumn
]], true)

-- Set spellchecking in files
vim.api.nvim_exec([[autocmd Filetype gitcommit,md,tex,txt setlocal spell]], true)

-- Write to all buffers when exit
vim.api.nvim_exec([[
augroup ConfigGroup
    autocmd!
    autocmd FocusLost * silent! wa!
augroup END
]], true)

-- Highlight on yank
vim.api.nvim_exec([[ autocmd TextYankPost * silent! lua vim.highlight.on_yank {} ]], true)

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.api.nvim_exec([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif ]], true)

-- Filetype set correctly
vim.api.nvim_exec([[ autocmd BufNewFile,BufRead *.conf set filetype=conf ]], true)

-- Default filetype for files without extension
vim.api.nvim_exec([[ autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=markdown | endif ]], true)

-- Spaces used for indentation and tabs depending on the file extension
vim.api.nvim_exec([[ autocmd FileType html,css,scss,xml,xhtml setlocal shiftwidth=2 tabstop=2 ]], true)
vim.api.nvim_exec([[ autocmd FileType javascript,lua,dart,python,c,cpp,md,sh,java setlocal shiftwidth=4 tabstop=4 ]], true)
vim.api.nvim_exec([[ autocmd FileType go setlocal shiftwidth=8 tabstop=8 ]], true)

-- Trim white spaces
vim.api.nvim_exec([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup JIUMYLOVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
]], true)

-- Automatic toggling between line number modes
vim.api.nvim_exec([[
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]], true)
