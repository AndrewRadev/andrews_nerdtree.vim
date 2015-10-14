" TODO (2015-10-14) Credit
"
function! andrews_nerdtree#start_shell#Run()
  let node = g:NERDTreeDirNode.GetSelected()
  let original_cwd = getcwd()

  try
    exec 'lcd ' . node.path.str({'format': 'Cd'})
    redraw!
    shell
  finally
    exec 'lcd ' . original_cwd
  endtry
endfunction
