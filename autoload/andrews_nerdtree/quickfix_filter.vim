function! andrews_nerdtree#quickfix_filter#Callback(params)
  if !exists('g:andrews_nerdtree_quickfix_filter_on')
    return 0
  endif

  if !exists('b:cached_quickfix_files')
    let b:cached_quickfix_files = []
    for entry in getqflist()
      let filename = fnamemodify(bufname(entry.bufnr), ':p')
      call add(b:cached_quickfix_files, filename)
    endfor
    call uniq(b:cached_quickfix_files)
  endif

  let filename = fnamemodify(a:params.path.str(), ':p')

  return !andrews_nerdtree#util#MatchesFilePrefix(b:cached_quickfix_files, filename)
endfunction

function! andrews_nerdtree#quickfix_filter#RefreshCache(event)
  if exists('b:cached_quickfix_files')
    unlet b:cached_quickfix_files
  endif
endfunction
