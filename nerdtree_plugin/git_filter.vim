if !(exists('g:andrews_nerdtree_all') && g:andrews_nerdtree_all)
  if !(exists('g:andrews_nerdtree_git_filter') && g:andrews_nerdtree_git_filter)
    finish
  endif
endif

call NERDTreeAddPathFilter('andrews_nerdtree#git_filter#Callback')
call g:NERDTreePathNotifier.AddListener("refresh", "andrews_nerdtree#git_filter#RefreshCache")

command! NERDTreeGitFilterToggle call s:NERDTreeGitFilterToggle()
function! s:NERDTreeGitFilterToggle()
  if exists('g:andrews_nerdtree_git_filter_on')
    NERDTreeGitFilterOff
  else
    NERDTreeGitFilter
  endif
endfunction

command! NERDTreeGitFilter call s:NERDTreeGitFilter()
function! s:NERDTreeGitFilter()
  let g:andrews_nerdtree_git_filter_on = 1
  call andrews_nerdtree#git_filter#RefreshCache()
  call andrews_nerdtree#util#Render()
endfunction

command! NERDTreeGitFilterOff call s:NERDTreeGitFilterOff()
function! s:NERDTreeGitFilterOff()
  if exists('g:andrews_nerdtree_git_filter_on')
    unlet g:andrews_nerdtree_git_filter_on
    call andrews_nerdtree#util#Render()
  endif
endfunction
