" This plugin was originally created by the author of NERDTree, Marty
" Grenfell, himself.
"
" The original should be here: https://gist.github.com/scrooloose/203928
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
