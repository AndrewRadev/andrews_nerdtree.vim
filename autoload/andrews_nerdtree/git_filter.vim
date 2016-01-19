function! andrews_nerdtree#git_filter#Callback(params)
  if !exists('g:andrews_nerdtree_git_filter_on')
    return 0
  endif

  if !exists('b:cached_git_file_list')
    let b:cached_git_file_list = []
    for entry in split(system('git status -s'), "\n")
      let filename = fnamemodify(strpart(entry, 3), ':p')
      call add(b:cached_git_file_list, filename)
    endfor
  endif

  let filename = fnamemodify(a:params.path.str(), ':p')
  return !andrews_nerdtree#util#MatchesFilePrefix(b:cached_git_file_list, filename)
endfunction

function! andrews_nerdtree#git_filter#RefreshGitCache(event)
  if exists('b:cached_git_file_list')
    unlet b:cached_git_file_list
  endif
endfunction
