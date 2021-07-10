" Insert line without leaving normal mode
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

" Show if there's a tab/space or not
"
"" Trim white spaces
"fun! TrimWhitespace()
"    let l:save = winsaveview()
"    keeppatterns %s/\s\+$//e
"    call winrestview(l:save)
"endfun
"augroup JIUMYLOVE
"    autocmd!
"    autocmd BufWritePre * :call TrimWhitespace()
"augroup END
