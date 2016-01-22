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

" Rerender the nerdtree, regardless of where we are in the tab
"
function! andrews_nerdtree#util#Render()
  let current_window = winnr()
  if s:SwitchToNERDTreeWindow()
    call NERDTreeRender()
    exe current_window.'wincmd w'
  endif
endfunction

" Returns true if any of the file paths in a:list contain a:path as a prefix.
"
function! andrews_nerdtree#util#MatchesFilePrefix(list, path)
  for entry in a:list
    if stridx(entry, a:path) == 0
      return 1
    endif
  endfor

  return 0
endfunction

function! s:SwitchToNERDTreeWindow()
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
