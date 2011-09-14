set nocompatible

syntax on
filetype on
filetype indent on
filetype plugin on

set clipboard=unnamed

set dictionary=/usr/share/dict/words
set hlsearch
set ts=2
set sw=2
set expandtab
set tags=tags
"set tags=$HOME/work/scala/.tags,$HOME/work/norbert/.tags,.tags
"set so=15
"set grepprg=git\ grep
"
"
set makeprg=rake efm=%f:%l:%m
ca rake make

func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

func GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
nmap <C-x>G :call GitGrepWord()<CR>


" Find file in current directory and edit it.
function! Find(name)
  let l:list=system("find . -path '*".a:name."' -and -not -name '*.class' -and -not -name '*.swp' | perl -ne 'print \"$.\\t$_\"'")
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


imap <F1> <esc>
map <F1> <esc>
map <F2> <esc>:n **/*.scala<CR>:n **/*.java<CR><esc><esc>:silent! :bw \*\*\/\*\.java<CR><esc><esc>:silent! :bw \*\*\/\*\.scala<CR><esc>
map <F3> <esc>:'<,'>w !pbcopy<CR>
map <F4> <esc>:r!pbpaste<CR>
map <F7> :make<CR>
set pastetoggle=<f11>
vmap <F5> :!sort<CR>

set encoding=utf-8
setglobal fileencoding=utf-8

autocmd BufEnter Makefile set noexpandtab
autocmd BufEnter makefile set noexpandtab
autocmd BufEnter *.h,*.m set expandtab ts=4 sw=4
autocmd BufEnter *.xml set expandtab
autocmd BufEnter *.tag set expandtab syntax=xml
autocmd BufEnter *.json set expandtab syntax=json
autocmd BufEnter *.ftl,*.macro set filetype=ftl noexpandtab
autocmd BufEnter *.java set ts=4 sw=4 expandtab makeprg=ant efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
autocmd BufEnter *.jsp set ts=2 sw=2 expandtab
autocmd BufEnter *.scala set ts=2 sw=2 expandtab
autocmd BufEnter *.sql set ts=2 sw=2 expandtab
autocmd BufEnter *.rb set ts=2 sw=2 expandtab
autocmd BufEnter Capfile set ts=2 sw=2 expandtab syntax=ruby

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end



" for solaris
if $SOLARIS == 1
    if &term =~ "xterm"
      if has("terminfo")
        set t_Co=8
        set t_Sf=[3%p1%dm
        set t_Sb=[4%p1%dm
      else
        set t_Co=8
        set t_Sf=[3%dm
        set t_Sb=[4%dm
      endif
    endif


    set dictionary=/usr/share/lib/dict/words

endif
