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

  if s:FindFilePrefix(b:cached_git_file_list, filename)
    return 0
  else
    return 1
  endif
endfunction

function! andrews_nerdtree#git_filter#RefreshGitCache(event)
  if exists('b:cached_git_file_list')
    unlet b:cached_git_file_list
  endif
endfunction

function! s:FindFilePrefix(list, path)
  for entry in a:list
    if stridx(entry, a:path) == 0
      return 1
    endif
  endfor

  return 0
endfunction
