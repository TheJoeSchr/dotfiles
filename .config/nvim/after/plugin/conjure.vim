" ------------------ CONJURE  ------------------
"
function! ClerkShow()
  exe "w"
  exe "ConjureEval (nextjournal.clerk/show! \"" . expand("%:p") . "\")"
endfunction

nmap <localleader>cs :execute ClerkShow()<CR>
