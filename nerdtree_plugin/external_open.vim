if !(exists('g:andrews_nerdtree_all') && g:andrews_nerdtree_all)
  if !(exists('g:andrews_nerdtree_external_open') && g:andrews_nerdtree_external_open)
    finish
  endif
endif

if exists("g:loaded_andrews_nerdtree_external_open")
  finish
endif
let g:loaded_andrews_nerdtree_external_open = 1

if !exists('g:andrews_nerdtree_external_open_key')
  let g:andrews_nerdtree_external_open_key = 'gx'
endif

call NERDTreeAddKeyMap({
      \ 'key':           g:andrews_nerdtree_external_open_key,
      \ 'callback':      'andrews_nerdtree#external_open#Run',
      \ 'quickhelpText': "open with external \n\" association",
      \ })
