if !(exists('g:andrews_nerdtree_all') && g:andrews_nerdtree_all)
  if !(exists('g:andrews_nerdtree_diff') && g:andrews_nerdtree_diff)
    finish
  endif
endif

if exists("g:loaded_andrews_nerdtree_diff")
  finish
endif
let g:loaded_andrews_nerdtree_diff = 1

if !exists('g:andrews_nerdtree_diff_key')
  let g:andrews_nerdtree_diff_key = 'D'
endif

call NERDTreeAddKeyMap({
      \ 'key':           g:andrews_nerdtree_diff_key,
      \ 'callback':      'andrews_nerdtree#diff#Run',
      \ 'quickhelpText': "open file and diff it \n\" against the current file",
      \ })
