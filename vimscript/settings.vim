" Pretty selfexplanatory, it trims down white spaces at :w
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup JIUMYLOVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Show if there's a tab/space or not
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

highlight visual cterm=reverse gui=reverse
highlight comment cterm=italic gui=italic
