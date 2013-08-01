" Find file in current directory and edit it.
function! Find(name)
  let l:list=system("find . -path '*".a:name."*' -and -not -name '*.class' -and -not -name '*.swp' -and -not -path './target/*' -and -not -path './*/target/*' -and -not -path './test-output/*' | perl -ne 'print \"$.\\t$_\"'")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (CR=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 O :call Find("<args>")


func FindWord()
  normal! "zyiw
  call Find(getreg('z'))
endf
nmap <C-x>O :call FindWord()<CR>
