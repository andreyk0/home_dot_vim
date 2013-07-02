fun! s:DetectRunHaskell()
    if getline(1) =~ '^#!.*/bin/env *runhaskell'
        set ft=haskell
    endif
endfun

autocmd BufNewFile,BufRead * call s:DetectRunHaskell()
