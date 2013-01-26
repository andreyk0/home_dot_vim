
fun! ToSnake() range
  for linenum in range(a:firstline, a:lastline)
    let currentline = getline(linenum)
    let replacement = substitute(currentline, '\C\(\<\u\|\l\)\(\l\+\)\(\u\)', '\l\1\l\2_\l\3', 'g')
    call setline(linenum, replacement)
  endfor
endfu

command -nargs=0 -range ToSnake call ToSnake()

fun! ToCamel() range
  for linenum in range(a:firstline, a:lastline)
    let currentline = getline(linenum)
    let replacement = substitute(currentline, '\([^_]\+\)_\(.\)', '\1\u\2', 'g')
    call setline(linenum, replacement)
  endfor
endfu

command -nargs=0 -range ToCamel call ToCamel()
