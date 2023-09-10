function! andrews_nerdtree#buffer_fs_menu#MoveNode()
  let current_node = g:NERDTreeFileNode.GetSelected()
  let path         = current_node.path.str()

  call andrews_nerdtree#buffer_fs_menu#InputBufferSetup(current_node, path, 'basename', 'andrews_nerdtree#buffer_fs_menu#ExecuteMove')
  setlocal statusline=Move
endfunction

function! andrews_nerdtree#buffer_fs_menu#ExecuteMove(current_node, new_path)
  let current_node = a:current_node
  let current_path = current_node.path.str()
  let new_path     = a:new_path

  try
    let bufnum = bufnr(current_path)

    call current_node.rename(new_path)
    call NERDTreeRender()

    if bufnum != -1
      let buffer_windownum  = bufwinnr(bufnum)
      let current_windownum = winnr()

      if buffer_windownum > 0
        exe buffer_windownum.'wincmd w'
        exe 'edit '.fnameescape(fnamemodify(new_path, ':.'))
        exe current_windownum.'wincmd w'
      endif

      call s:delBuffer(bufnum)
    endif

    call current_node.putCursorHere(1, 0)
    redraw!

    if fnamemodify(current_path, ':t') ==# fnamemodify(new_path, ':t')
      " The basename is the same, so keep the directory move for a reapply later
      let b:last_buffer_action = ['move', fnamemodify(new_path, ':h')]
    else
      let b:last_buffer_action = []
    endif

    call s:echo('Node moved to '.new_path)
  catch /^NERDTree/
    call s:echoWarning("Node Not Renamed.")
  endtry
endfunction

function! andrews_nerdtree#buffer_fs_menu#AddNode()
  let current_node = g:NERDTreeDirNode.GetSelected()

  if exists('g:NERDTreePath') && has_key(g:NERDTreePath, 'Slash')
    " old NERDTree version (e126b87)
    let path = current_node.path.str({'format': 'Glob'}) . g:NERDTreePath.Slash()
  else
    let path = current_node.path.str() . nerdtree#slash()
  endif

  call andrews_nerdtree#buffer_fs_menu#InputBufferSetup(current_node, path, 'append', 'andrews_nerdtree#buffer_fs_menu#ExecuteAdd')
  setlocal statusline=Add
endfunction

function! andrews_nerdtree#buffer_fs_menu#ExecuteAdd(current_node, new_node_name)
  let current_node  = a:current_node
  let new_node_name = a:new_node_name

  if new_node_name ==# ''
    call s:echo("Node Creation Aborted.")
    return
  endif

  try
    call s:EnsureDirectoryExists(new_node_name)

    let new_path    = g:NERDTreePath.Create(new_node_name)
    let parent_node = b:NERDTreeRoot.findNode(new_path.getParent())

    call andrews_nerdtree#git_filter#RefreshCache()

    let new_tree_node = g:NERDTreeFileNode.New(new_path, b:NERDTree)

    " Emptying g:NERDTreeOldSortOrder forces the sort to
    " recalculate the cached sortKey so nodes sort correctly.
    let g:NERDTreeOldSortOrder = []

    if empty(parent_node)
      call b:NERDTree.root.refresh()
      call b:NERDTree.render()
    elseif parent_node.isOpen || !empty(parent_node.children)
      call parent_node.addChild(new_tree_node, 1)
      call NERDTreeRender()
      call new_tree_node.putCursorHere(1, 0)
    endif

    call s:echo('Node created as ' . new_node_name)
  catch /^NERDTree/
    call s:echoWarning("Node Not Created.")
  endtry
endfunction

function! andrews_nerdtree#buffer_fs_menu#CopyNode()
  let current_node = g:NERDTreeFileNode.GetSelected()
  let path         = current_node.path.str()

  call andrews_nerdtree#buffer_fs_menu#InputBufferSetup(current_node, path, 'basename', 'andrews_nerdtree#buffer_fs_menu#ExecuteCopy')
  setlocal statusline=Copy
endfunction

function! andrews_nerdtree#buffer_fs_menu#ExecuteCopy(current_node, new_path)
  let current_node = a:current_node
  let current_path = current_node.path.str()
  let new_path     = a:new_path

  if new_path != ""
    "strip trailing slash
    let new_path = substitute(new_path, '\/$', '', '')

    let confirmed = 1
    if current_node.path.copyingWillOverwrite(new_path)
      call s:echo("Warning: copying may overwrite files! Continue? (yN)")
      let choice = nr2char(getchar())
      let confirmed = choice ==# 'y'
    endif

    if confirmed
      try
        call s:EnsureDirectoryExists(new_path)

        call s:echo("Copying...")
        let new_node = current_node.copy(new_path)
        if !empty(new_node)
          call NERDTreeRender()
          call new_node.putCursorHere(0, 0)
        endif

        if fnamemodify(current_path, ':t') ==# fnamemodify(new_path, ':t')
          " The basename is the same, so keep the directory move for a reapply later
          let b:last_buffer_action = ['copy', fnamemodify(new_path, ':h')]
        else
          let b:last_buffer_action = []
        endif

        call s:echo("Copied to " . new_path)
      catch /^NERDTree/
        call s:echoWarning("Could not copy node")
      endtry
    endif
  else
    call s:echo("Copy aborted.")
  endif
  redraw
endfunction

function! andrews_nerdtree#buffer_fs_menu#DeleteNode()
  let currentNode = g:NERDTreeFileNode.GetSelected()
  let confirmed = 0

  if currentNode.path.isDirectory
    let choice =input("Delete the current node\n" .
          \ "==========================================================\n" .
          \ "STOP! To delete this entire directory, type 'yes'\n" .
          \ "" . currentNode.path.str() . ": ")
    let confirmed = choice ==# 'yes'
  else
    echo "Delete the current node\n" .
          \ "==========================================================\n".
          \ "Are you sure you wish to delete the node:\n" .
          \ "" . currentNode.path.str() . " (yN):"
    let choice = nr2char(getchar())
    let confirmed = choice ==# 'y'
  endif

  if confirmed
    try
      call currentNode.delete()
      call NERDTreeRender()

      let bufnum = bufnr(currentNode.path.str())
      if buflisted(bufnum)
        call s:delBuffer(bufnum)
      endif

      let b:last_buffer_action = ['delete', '']

      redraw
    catch /^NERDTree/
      call s:echoWarning("Could not remove node")
    endtry
  else
    call s:echo("delete aborted")
  endif
endfunction

function! andrews_nerdtree#buffer_fs_menu#Repeat()
  if !exists('b:last_buffer_action') || len(b:last_buffer_action) != 2
    echomsg "No repeatable previous action found"
    return
  endif

  let [action, subject] = b:last_buffer_action
  let current_node = g:NERDTreeFileNode.GetSelected()
  let current_path = current_node.path.str()
  let current_basename = fnamemodify(current_path, ':t')

  if action == 'move'
    if subject != current_path
      let new_path = subject..'/'..current_basename
      call andrews_nerdtree#buffer_fs_menu#ExecuteMove(current_node, new_path)
    endif
  elseif action == 'copy'
    if subject != current_path
      let new_path = subject..'/'..current_basename
      call andrews_nerdtree#buffer_fs_menu#ExecuteCopy(current_node, new_path)
    endif
  elseif action == 'delete'
    call andrews_nerdtree#buffer_fs_menu#DeleteNode()
  else
    echomsg "Unknown action: "..action
  endif
endfunction

function! s:echo(msg)
  redraw
  echomsg "NERDTree: " . a:msg
endfunction

function! s:echoWarning(msg)
  echohl warningmsg
  call s:echo(a:msg)
  echohl normal
endfunction

" Setup a one-line input buffer for a NERDTree action.
function! andrews_nerdtree#buffer_fs_menu#InputBufferSetup(node, content, cursor_position, callback_function_name)
  " one-line buffer below everything else
  botright 1new

  " disable autocompletion
  if exists(':AcpLock')
    AcpLock
    autocmd BufLeave <buffer> AcpUnlock
  endif

  " if we leave the buffer, cancel the operation
  autocmd BufLeave <buffer> q!

  " set the content, store the callback and the node in the buffer
  call setline(1, a:content)
  setlocal nomodified
  let b:node     = a:node
  let b:callback = function(a:callback_function_name)

  " disallow opening new lines
  nmap <buffer> o <nop>
  nmap <buffer> O <nop>

  " cancel the action
  nmap <buffer> <esc> :q!<cr>
  nmap <buffer> <c-[> :q!<cr>
  map  <buffer> <c-c> :q!<cr>
  imap <buffer> <c-c> :q!<cr>

  if a:cursor_position == 'basename'
    " cursor is on basename (last path segment)
    normal! $T/
  elseif a:cursor_position == 'append'
    " cursor is in insert mode at the end of the line
    call feedkeys('A')
  endif

  " mappings to invoke the callback
  nmap <buffer> <cr>      :call andrews_nerdtree#buffer_fs_menu#InputBufferExecute(b:callback, b:node, getline('.'))<cr>
  imap <buffer> <cr> <esc>:call andrews_nerdtree#buffer_fs_menu#InputBufferExecute(b:callback, b:node, getline('.'))<cr>
endfunction

function! andrews_nerdtree#buffer_fs_menu#InputBufferExecute(callback, node, result)
  " close the input buffer
  q!

  " invoke the callback
  call call(a:callback, [a:node, a:result])
endfunction

"Delete the buffer with the given bufnum.
"
"Args:
"bufnum: the buffer that may be deleted
function! s:delBuffer(bufnum)
  exec "silent bdelete! " . a:bufnum
endfunction

function! s:EnsureDirectoryExists(path)
  let path = a:path
  let directory = fnamemodify(path, ':h')

  if directory.'/' == path
    " we're trying to create a directory, let NERDTree handle it
    return
  endif

  if isdirectory(directory)
    " already exists, nothing to do
    return
  endif

  if confirm("Directory '".directory."'doesn't exist, create? ")
    call mkdir(directory, 'p')
    call g:NERDTreeKeyMap.Invoke("R")
  else
    throw "NERDTree"
  endif
endfunction
