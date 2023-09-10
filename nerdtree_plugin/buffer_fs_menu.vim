if !(exists('g:andrews_nerdtree_all') && g:andrews_nerdtree_all)
  if !(exists('g:andrews_nerdtree_buffer_fs_menu') && g:andrews_nerdtree_buffer_fs_menu)
    finish
  endif
endif

if exists("g:loaded_andrews_nerdtree_buffer_fs_menu")
  finish
endif
let g:loaded_andrews_nerdtree_nerdree_buffer_fs_menu = 1

" Don't load default menu
let g:loaded_nerdtree_fs_menu = 1

call NERDTreeAddMenuItem({
      \ 'text':     '(a)dd a childnode',
      \ 'shortcut': 'a',
      \ 'callback': 'andrews_nerdtree#buffer_fs_menu#AddNode'
      \ })
call NERDTreeAddMenuItem({
      \ 'text':     '(m)ove the current node',
      \ 'shortcut': 'm',
      \ 'callback': 'andrews_nerdtree#buffer_fs_menu#MoveNode'
      \ })
call NERDTreeAddMenuItem({
      \ 'text':     '(d)elete the curent node',
      \ 'shortcut': 'd',
      \ 'callback': 'andrews_nerdtree#buffer_fs_menu#DeleteNode'
      \ })
if g:NERDTreePath.CopyingSupported()
  call NERDTreeAddMenuItem({
        \ 'text':     '(c)opy the current node',
        \ 'shortcut': 'c',
        \ 'callback': 'andrews_nerdtree#buffer_fs_menu#CopyNode'
        \ })
endif

call NERDTreeAddKeyMap({
      \ 'key':           '.',
      \ 'callback':      'andrews_nerdtree#buffer_fs_menu#Repeat',
      \ 'quickhelpText': "repeat the last file operation, if possible (move, copy, delete)",
      \ })
