function! andrews_nerdtree#diff#Run()
  let current_node = g:NERDTreeFileNode.GetSelected()

  if current_node == {}
    return
  else
    wincmd w
    diffthis
    exe "vsplit ".fnameescape(current_node.path.str())
    diffthis
  endif
endfunction
