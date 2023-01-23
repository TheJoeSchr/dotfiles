  " ---------------- FUGITIVE --------------
  " nnoremap <leader>g :Git <CR>
  " nnoremap <leader>G :Git <CR>
  " nnoremap <leader>Gd :0Gclog <CR>
  " nnoremap <leader>Gl :Gclog <CR>
  command! GHistory call s:view_git_history

  " auto-clean fugitive bufffers (vimcasts #34) 
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " maps .. to the above command, but only for buffers containing a git blob or tree:
  autocmd User fugitive 
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

  function! s:view_git_history() abort
    Git difftool --name-only ! !^@
    call s:diff_current_quickfix_entry()
    " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
    " There's probably a better way to map this without changing the window
    copen
    nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
    wincmd p
  endfunction

  function s:diff_current_quickfix_entry() abort
    " Cleanup windows
    for window in getwininfo()
      if window.winnr !=? winnr() && bufname(window.bufnr) =~? '^fugitive:'
        exe 'bdelete' window.bufnr
      endif
    endfor
    cc
    call s:add_mappings()
    let qf = getqflist({'context': 0, 'idx': 0})
    if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
      let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
      echom string(reverse(range(len(diff))))
      for i in reverse(range(len(diff)))
        exe (i ? 'leftabove' : 'rightbelow') 'vert diffsplit' fnameescape(diff[i].filename)
        call s:add_mappings()
      endfor
    endif
  endfunction

  function! s:add_mappings() abort
    nnoremap <buffer>]q :cnext <BAR> :call <sid>diff_current_quickfix_entry()<CR>
    nnoremap <buffer>[q :cprevious <BAR> :call <sid>diff_current_quickfix_entry()<CR>
    " Reset quickfix height. Sometimes it messes up after selecting another item
    11copen
    wincmd p
  endfunction
  " ------------------ /FUGITIVE -------------"
