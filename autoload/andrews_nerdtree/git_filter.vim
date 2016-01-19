function! andrews_nerdtree#git_filter#Callback(params)
  if !exists('g:andrews_nerdtree_git_filter_on')
    return 0
  endif

  if !exists('s:andrews_nerdtree_cached_git_file_list')
    let s:andrews_nerdtree_cached_git_file_list = []
    for entry in split(system('git status -s'), "\n")
      let filename = fnamemodify(strpart(entry, 3), ':p')
      call add(s:andrews_nerdtree_cached_git_file_list, filename)
    endfor
  endif

  let filename = fnamemodify(a:params.path.str(), ':p')
  return !andrews_nerdtree#util#MatchesFilePrefix(s:andrews_nerdtree_cached_git_file_list, filename)
endfunction

function! andrews_nerdtree#git_filter#RefreshCache(...)
  if exists('s:andrews_nerdtree_cached_git_file_list')
    unlet s:andrews_nerdtree_cached_git_file_list
  endif
endfunction
