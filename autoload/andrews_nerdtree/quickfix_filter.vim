function! andrews_nerdtree#quickfix_filter#Callback(params)
  if !exists('g:andrews_nerdtree_quickfix_filter_on')
    return 0
  endif

  if !exists('s:andrews_nerdtree_cached_quickfix_files')
    let s:andrews_nerdtree_cached_quickfix_files = []
    for entry in getqflist()
      let filename = fnamemodify(bufname(entry.bufnr), ':p')
      call add(s:andrews_nerdtree_cached_quickfix_files, filename)
    endfor
    call uniq(s:andrews_nerdtree_cached_quickfix_files)
  endif

  let filename = fnamemodify(a:params.path.str(), ':p')

  return !andrews_nerdtree#util#MatchesFilePrefix(s:andrews_nerdtree_cached_quickfix_files, filename)
endfunction

function! andrews_nerdtree#quickfix_filter#RefreshCache(...)
  if exists('s:andrews_nerdtree_cached_quickfix_files')
    unlet s:andrews_nerdtree_cached_quickfix_files
  endif
endfunction
