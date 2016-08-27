fun! s:DetectHaskellStack()
    if getline(1) =~ '^#!.*/bin/env *stack'
        set ft=haskell
    endif
endfun

autocmd BufNewFile,BufRead * call s:DetectHaskellStack()
