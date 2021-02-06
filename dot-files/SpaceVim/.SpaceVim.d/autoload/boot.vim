function! boot#before() abort
  " Appearance
  let &colorcolumn = join(range(81,999), ',')
  
  " Behaviour
  let g:deoplete#enable_at_startup = 1
 
  call deoplete#custom#option('sources', {
        \ '_': ['ale']})

  " Remove trailing space on save.
  " Remap for destroying trailing whitespace cleanly
  ":nnoremap <Leader>w :let _save_pos=getpos(".") <Bar>
  "    \ :let _s=@/ <Bar>
  "    \ :%s/\s\+$//e <Bar>
  "    \ :let @/=_s <Bar>
  "    \ :nohl <Bar>
  "    \ :unlet _s<Bar>
  "    \ :call setpos('.', _save_pos)<Bar>
  "    \ :unlet _save_pos<CR><CR>     
  function! <SID>StripTrailingWhitespaces()
    if !&binary && &filetype != 'diff'
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
    endif
  endfun

  autocmd FileType c,cpp,clojure autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

endfunction

function! boot#after() abort
endfunction
