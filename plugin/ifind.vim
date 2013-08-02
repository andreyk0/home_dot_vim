" Interactively find a set of files and open them
function! IFind(name)
  let tmpFile=tempname()
  execute ":! ifind -s '".a:name."' -o ".tmpFile
  if filereadable(tmpFile)
    for i in readfile(tmpFile)
      execute ":e ".i
    endfor
    call delete(tmpFile)
  endif
endfunction

func IFindWord()
  normal! "zyiw
  call IFind(getreg('z'))
endf
