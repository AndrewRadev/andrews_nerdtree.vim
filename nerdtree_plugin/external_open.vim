if !(exists('g:andrews_nerdtree_external_open') && g:andrews_nerdtree_external_open)
  finish
endif

if exists("g:loaded_andrews_nerdtree_external_open")
  finish
endif
let g:loaded_andrews_nerdtree_external_open = 1

" TODO document OpenURL

call NERDTreeAddKeyMap({
      \ 'key':           g:andrews_nerdtree_external_open_key,
      \ 'callback':      'andrews_nerdtree#external_open#Run',
      \ 'quickhelpText': "open with external \n\" association",
      \ })
