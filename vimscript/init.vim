" Insert line without leaving normal mode
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

" Trim white spaces
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup JIUMYLOVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

noremap <expr> <SID>(search-forward) 'Nn'[v:searchforward]
noremap <expr> <SID>(search-backward) 'nN'[v:searchforward]

nmap n <SID>(search-forward)zzzv
xmap n <SID>(search-forward)zzzv

nmap N <SID>(search-backward)zzzv
xmap N <SID>(search-backward)zzzv

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Automatic toggling between line number modes
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
