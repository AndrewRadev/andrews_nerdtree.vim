if !(exists('g:andrews_nerdtree_all') && g:andrews_nerdtree_all)
  if !(exists('g:andrews_nerdtree_start_shell') && g:andrews_nerdtree_start_shell)
    finish
  endif
endif

if exists("g:loaded_andrews_nerdtree_start_shell")
  finish
endif
let g:loaded_andrews_nerdtree_start_shell = 1

if !exists('g:andrews_nerdtree_startshell_mapping_key')
  let g:andrews_nerdtree_startshell_mapping_key = 'S'
endif

call NERDTreeAddKeyMap({
            \ 'key':           g:andrews_nerdtree_startshell_mapping_key,
            \ 'callback':      'andrews_nerdtree#start_shell#Run',
            \ 'quickhelpText': 'start a :shell in this dir' })
