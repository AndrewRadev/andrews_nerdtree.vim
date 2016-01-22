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

  let file_list = extend(copy(s:andrews_nerdtree_cached_quickfix_files), s:OpenFiles())
  let filename = fnamemodify(a:params.path.str(), ':p')

  return !andrews_nerdtree#util#MatchesFilePrefix(file_list, filename)
endfunction

function! andrews_nerdtree#quickfix_filter#RefreshCache(...)
  if exists('s:andrews_nerdtree_cached_quickfix_files')
    unlet s:andrews_nerdtree_cached_quickfix_files
  endif
endfunction

function! s:OpenFiles()
  let buflist = []
  for i in range(tabpagenr('$'))
    call extend(buflist, tabpagebuflist(i + 1))
  endfor

  return map(buflist, 'fnamemodify(bufname(v:val), ":p")')
endfunction
