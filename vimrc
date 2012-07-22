set nocompatible

syntax enable
if has('gui_running')
  set background=light
else
  set background=light
endif
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized

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
set foldmethod=indent
set foldlevel=1
set autoread

set winheight=10
set winminheight=5

"set tags=$HOME/work/scala/.tags,$HOME/work/norbert/.tags,.tags
"set so=15
"set grepprg=git\ grep


ca rake make

if filereadable("build.sbt")
  set makeprg=cat\ /tmp/sbt.errs
  set efm=%E\ %#[error]\ %f:%l:\ %m,%C\ %#[error]\ %p^,%-C%.%#,%Z, "\%W\ %#[warn]\ %f:%l:\ %m,%C\ %#[warn]\ %p^,%-C%.%#,%Z,
         \%-G%.%#
elseif filereadable("build.xml")
  set makeprg=ant
  "set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%A\ %#[scalac]\ %f:%l:\ %m,%-Z\ %#[scalac]\ %p^,%-C%.%#
  set efm=%W\ %#[scalac]\ %f:%l:\ warning:\ %m,%W\ %#[javac]\ %f:%l:\ warning:\ %m,%E\ %#[javac]\ %f:%l:\ %m,%E\ %#[scalac]\ %f:%l:\ error:\ %m
elseif filereadable("Rakefile")
 set makeprg=rake
 set efm=%E%f:%l:\ error:\ %m,%W%f:%l:\ warning:\ %m
endif

imap <F1> <esc>
map <F1> <esc>
map <F2> <esc>:n **/*.scala<CR>:n **/*.java<CR><esc><esc>:silent! :bw \*\*\/\*\.java<CR><esc><esc>:silent! :bw \*\*\/\*\.scala<CR><esc>
map <F3> <esc>:'<,'>w !tmux loadb -<CR>
map <F4> <esc>:r!tmux showb<CR>
vmap <F5> :!sort<CR>
map <F6> <esc>:Shell git blame %<CR>
map <F7> <esc>:make<CR><CR>

" disable 'ex' mode
map Q <ESC>

set encoding=utf-8
setglobal fileencoding=utf-8

autocmd BufEnter Capfile set ts=2 sw=2 expandtab syntax=ruby
autocmd BufEnter *.ftl,*.macro set filetype=ftl noexpandtab
autocmd BufEnter *.h,*.m set expandtab
autocmd BufEnter *.hs set ts=8 expandtab
autocmd BufEnter *.java set ts=2 sw=2 expandtab
autocmd BufEnter *.json set expandtab syntax=json
autocmd BufEnter *.jsp set ts=2 sw=2 expandtab
autocmd BufEnter makefile set noexpandtab
autocmd BufEnter Makefile set noexpandtab
autocmd BufEnter *.nxc set filetype=nxc ts=2 sw=2 expandtab
autocmd BufEnter *.rb set ts=2 sw=2 expandtab
autocmd BufEnter *.scala set ts=2 sw=2 expandtab
autocmd BufEnter *.sql set ts=2 sw=2 expandtab
autocmd BufEnter *.tag set expandtab syntax=xml
autocmd BufEnter *.xml set expandtab

autocmd BufWritePre *.scala,*java,*.rb,*efile,*.hs :%s/\s\+$//e

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
