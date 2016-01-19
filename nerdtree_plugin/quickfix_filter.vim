" TODO Recursively open?
" TODO Documentation

if !(exists('g:andrews_nerdtree_all') && g:andrews_nerdtree_all)
  if !(exists('g:andrews_nerdtree_quickfix_filter') && g:andrews_nerdtree_quickfix_filter)
    finish
  endif
endif

call NERDTreeAddPathFilter('andrews_nerdtree#quickfix_filter#Callback')
call g:NERDTreePathNotifier.AddListener("refresh", "andrews_nerdtree#quickfix_filter#RefreshCache")

command! NERDTreeQuickfixFilterToggle call s:NERDTreeQuickfixFilterToggle()
function! s:NERDTreeQuickfixFilterToggle()
  if exists('g:andrews_nerdtree_quickfix_filter_on')
    NERDTreeQuickfixFilterOff
  else
    NERDTreeQuickfixFilter
  endif
endfunction

command! NERDTreeQuickfixFilter call s:NERDTreeQuickfixFilter()
function! s:NERDTreeQuickfixFilter()
  let g:andrews_nerdtree_quickfix_filter_on = 1
  call andrews_nerdtree#util#Render()
endfunction

command! NERDTreeQuickfixFilterOff call s:NERDTreeQuickfixFilterOff()
function! s:NERDTreeQuickfixFilterOff()
  if exists('g:andrews_nerdtree_quickfix_filter_on')
    unlet g:andrews_nerdtree_quickfix_filter_on
    call andrews_nerdtree#util#Render()
  endif
endfunction

if g:andrews_nerdtree_quickfix_filter_auto
  augroup andrews_nerdtree_quickfix_filter
    autocmd!

    autocmd QuickFixCmdPost * NERDTreeQuickfixFilter
  augroup END
endif
