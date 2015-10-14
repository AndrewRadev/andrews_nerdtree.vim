if exists('g:loaded_andrews_nerdtree') || &cp
  finish
endif

let g:loaded_andrews_nerdtree = '0.0.1' " version number
let s:keepcpo = &cpo
set cpo&vim

if !exists('g:andrews_nerdtree_diff_key')
  let g:andrews_nerdtree_diff_key = 'D'
endif

if !exists('g:andrews_nerdtree_external_open_key')
  let g:andrews_nerdtree_external_open_key = 'gx'
endif

if !exists('g:andrews_nerdtree_interactive_edit_key')
  let g:andrews_nerdtree_interactive_edit_key = 'e'
endif

if !exists('g:andrews_nerdtree_start_shell_key')
  let g:andrews_nerdtree_start_shell_key = 'S'
endif

let &cpo = s:keepcpo
unlet s:keepcpo
