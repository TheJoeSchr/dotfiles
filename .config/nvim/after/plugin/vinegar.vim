 " ------------------ Vinegar ------------------
 map <C-n> <Plug>VinegarUp
 nmap <leader>n <Plug>VinegarUp
 nmap - <Plug>VinegarUp
 " disable annoying netrw keeps open
 autocmd FileType netrw setl bufhidden=wipe
 let g:netrw_fastbrowse = 0
 " Remove 'set hidden'
 set nohidden
 augroup netrw_buf_hidden_fix
     autocmd!

     " Set all non-netrw buffers to bufhidden=hide
     autocmd BufWinEnter *
                 \  if &ft != 'netrw'
                 \|     set bufhidden=hide
                 \| endif

 augroup end
