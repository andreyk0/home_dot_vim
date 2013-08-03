" Interactively find a set of files and open them
function! IFind(path, name)
  let tmpFile=tempname()
  execute ":! ifind -i '".a:path."' -s '".a:name."' -o ".tmpFile
  if filereadable(tmpFile)
    for i in readfile(tmpFile)
      execute ":e ".i
    endfor
    call delete(tmpFile)
  endif
endfunction

command! -nargs=1 -complete=file O :silent call IFind("<args>", "")

func IFindWord()
  normal! "zyiw
  call IFind(".", getreg('z'))
endf
