" Interactively find a set of files and open them
function! IFind()
  let tmpFile=tempname()
  execute ":! ifind -o ".tmpFile
  if filereadable(tmpFile)
    for i in readfile(tmpFile)
      execute ":e ".i
    endfor
    call delete(tmpFile)
  endif
endfunction
