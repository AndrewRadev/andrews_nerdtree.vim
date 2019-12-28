if !(exists('g:andrews_nerdtree_all') && g:andrews_nerdtree_all)
  if !(exists('g:andrews_nerdtree_interactive_edit') && g:andrews_nerdtree_interactive_edit)
    finish
  endif
endif

if exists("g:loaded_andrews_nerdtree_interactive_edit")
  finish
endif
let g:loaded_andrews_nerdtree_interactive_edit = 1

if !exists('g:andrews_nerdtree_interactive_edit_key')
  let g:andrews_nerdtree_interactive_edit_key = 'e'
endif

call NERDTreeAddMenuItem({
      \ 'text':     '(e)dit directory contents',
      \ 'shortcut': g:andrews_nerdtree_interactive_edit_key,
      \ 'callback': 'andrews_nerdtree#interactive_edit#Start'
      \ })
