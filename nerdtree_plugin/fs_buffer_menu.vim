" TODO move this documentation
"
" This NERDTree plugin adds a filesystem manipulation menu almost exactly like
" the default one. The difference is that operations that require entering a
" file path, namely "add", "move" and "copy", use a separate one-line buffer
" to receive the input, instead of the default vim dialog. This allows you to
" use vim keybindings to move around the file path.
"
" Most of the code here is taken directly from Marty Grenfell's original
" fs_menu plugin, which can be found here:
"
" https://github.com/scrooloose/nerdtree/blob/master/nerdtree_plugin/fs_menu.vim
"
" A few minor things have been reformatted, because I liked them better that
" way.
"
" The custom mappings for the special buffer holding the filename are as
" follows:
"
"   - "o" and "O" do nothing in normal mode, to avoid opening up a second line
"     by accident
"   - "Escape" (or "Ctrl+[") in normal mode closes the buffer, cancelling the
"     operation
"   - "Ctrl+c" closes the buffer in both normal and insert mode, cancelling
"     the operation
"   - "Return" in both normal and insert mode executes the operation and
"     closes the buffer
"
" Note that the "Return" key works even when the completion menu is opened --
" you can't use completion in this buffer (a bit of a problem). To that end,
" if you're using the Acp plugin, it's automatically disabled for the buffer.
"
" If you leave the buffer, it's automatically closed.

if !(exists('g:andrews_nerdtree_buffer_fs_menu') && g:andrews_nerdtree_buffer_fs_menu)
  finish
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
