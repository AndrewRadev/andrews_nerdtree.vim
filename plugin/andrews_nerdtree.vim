if exists('g:loaded_andrews_nerdtree') || &cp
  finish
endif

let g:loaded_andrews_nerdtree = '0.0.1' " version number
let s:keepcpo = &cpo
set cpo&vim

if !exists('g:andrews_nerdtree_all')
  let g:andrews_nerdtree_all = 0
endif

if !exists('g:andrews_nerdtree_buffer_fs_menu')
  let g:andrews_nerdtree_buffer_fs_menu = 0
endif

if !exists('g:andrews_nerdtree_diff')
  let g:andrews_nerdtree_diff = 0
endif

if !exists('g:andrews_nerdtree_diff_key')
  let g:andrews_nerdtree_diff_key = 'D'
endif

if !exists('g:andrews_nerdtree_external_open')
  let g:andrews_nerdtree_external_open = 0
endif

if !exists('g:andrews_nerdtree_external_open_key')
  let g:andrews_nerdtree_external_open_key = 'gx'
endif

if !exists('g:andrews_nerdtree_interactive_edit')
  let g:andrews_nerdtree_interactive_edit = 0
endif

if !exists('g:andrews_nerdtree_interactive_edit_key')
  let g:andrews_nerdtree_interactive_edit_key = 'e'
endif

if !exists('g:andrews_nerdtree_startshell_mapping')
  let g:andrews_nerdtree_startshell_mapping = 0
endif

if !exists('g:andrews_nerdtree_startshell_mapping_key')
  let g:andrews_nerdtree_startshell_mapping_key = 'S'
endif

let &cpo = s:keepcpo
unlet s:keepcpo
