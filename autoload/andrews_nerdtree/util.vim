" Remove extra whitespace from strings
"
function! andrews_nerdtree#util#Ltrim(s)
  return substitute(a:s, '^\_s\+', '', '')
endfunction
function! andrews_nerdtree#util#Rtrim(s)
  return substitute(a:s, '\_s\+$', '', '')
endfunction
function! andrews_nerdtree#util#Trim(s)
  return andrews_nerdtree#util#Rtrim(andrews_nerdtree#util#Ltrim(a:s))
endfunction

" Jump to the NERDTree window in the current tab, if possible. Returns 1 if it
" succeeded, 0 if it didn't.
"
function! andrews_nerdtree#util#SwitchToNERDTreeWindow()
  let nerdtree_buffer = ''
  for bufnr in tabpagebuflist()
    if bufname(bufnr) =~ '^NERD_tree_\d\+$'
      let nerdtree_buffer = bufnr
      break
    endif
  endfor

  if nerdtree_buffer == ''
    return 0
  endif

  exe bufwinnr(nerdtree_buffer).'wincmd w'
  return 1
endfunction

" Jump to the given winnr. Used in combination with the above
" SwitchToNERDTreeWindow function.
"
function! andrews_nerdtree#util#SwitchToWindow(winnr)
  exe a:winnr.'wincmd w'
endfunction
