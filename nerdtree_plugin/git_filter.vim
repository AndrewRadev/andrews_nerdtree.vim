if !(exists('g:andrews_nerdtree_all') && g:andrews_nerdtree_all)
  if !(exists('g:andrews_nerdtree_git_filter') && g:andrews_nerdtree_git_filter)
    finish
  endif
endif

call NERDTreeAddPathFilter('andrews_nerdtree#git_filter#Callback')
call g:NERDTreePathNotifier.AddListener("refresh", "andrews_nerdtree#git_filter#RefreshGitCache")

command! NERDTreeGitFilterToggle call s:NERDTreeGitFilterToggle()
function! s:NERDTreeGitFilterToggle()
  if exists('g:andrews_nerdtree_git_filter_on')
    unlet g:andrews_nerdtree_git_filter_on
  else
    let g:andrews_nerdtree_git_filter_on = 1
  endif

  let current_window = winnr()
  if andrews_nerdtree#util#SwitchToNERDTreeWindow()
    call NERDTreeRender()
    call andrews_nerdtree#util#SwitchToWindow(current_window)
  endif
endfunction
