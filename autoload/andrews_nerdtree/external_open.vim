function! andrews_nerdtree#external_open#Run()
  " Get the path of the item under the cursor if possible:
  let current_file = g:NERDTreeFileNode.GetSelected()
  if current_file == {}
    return
  else
    if exists('*OpenURL')
      call OpenURL(current_file.path.str())
    else
      call netrw#BrowseX(current_file.path.str(), 0)
    endif
  endif

  redraw!
endfunction
