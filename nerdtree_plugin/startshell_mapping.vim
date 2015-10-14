if !(exists('g:andrews_nerdtree_start_shell') && g:andrews_nerdtree_start_shell)
  finish
endif

if exists("g:loaded_andrews_nerdtree_start_shell")
  finish
endif
let g:loaded_andrews_nerdtree_start_shell = 1

call NERDTreeAddKeyMap({
            \ 'key':           g:andrews_nerdtree_start_shell_key,
            \ 'callback':      'andrews_nerdtree#start_shell#Run',
            \ 'quickhelpText': 'start a :shell in this dir' })
