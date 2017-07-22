set nocompatible
set nowrap

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
set foldlevel=10
set foldnestmax=10

set autoread

set winheight=10
set winminheight=5

set winwidth=120
set winminwidth=60

"set tags=$HOME/work/scala/.tags,$HOME/work/norbert/.tags,.tags
"set so=15
"set grepprg=git\ grep

set colorcolumn=100

":he statusline
set laststatus=2
set statusline=
set statusline+=%#pmenu#
set statusline+=%f\ 
set statusline+=%#pmenusel#
set statusline+=\ %{&fenc!=''?&fenc:&enc}\ 
set statusline+=%Y\ 
set statusline+=%04l/%03c\ 
set statusline+=0x%04.4B\ 
set statusline+=%*
set statusline+=%-3m\ 

set fillchars+=stl:\_,stlnc:\  

set path=.,/usr/local/include,/usr/include,/usr/include/linux,/usr/include/x86_64-linux-gnu

ca rake make

if filereadable("project/Build.scala") || filereadable("build.sbt")
  set makeprg=cat\ /tmp/sbt.errs
  set efm=%E\ %#[error]\ %f:%l:\ %m,%C\ %#[error]\ %p^,%-C%.%#,%Z, "\%W\ %#[warn]\ %f:%l:\ %m,%C\ %#[warn]\ %p^,%-C%.%#,%Z,
         \%-G%.%#
"elseif filereadable("build.xml")
"  set makeprg=ant
"  "set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%A\ %#[scalac]\ %f:%l:\ %m,%-Z\ %#[scalac]\ %p^,%-C%.%#
"  set efm=%W\ %#[scalac]\ %f:%l:\ warning:\ %m,%W\ %#[javac]\ %f:%l:\ warning:\ %m,%E\ %#[javac]\ %f:%l:\ %m,%E\ %#[scalac]\ %f:%l:\ error:\ %m
elseif filereadable("Rakefile")
 set makeprg=rake
 set efm=%E%f:%l:\ error:\ %m,%W%f:%l:\ warning:\ %m
endif

imap <F1> <esc>
map <F1> <esc>
map <F2> <esc>:call IFind(".","") <CR><CR>
map <F3> <esc>:'<,'>w !pbcopy -<CR>
map <F4> <esc>:r!pbpaste<CR>
vmap <F5> :!sort<CR>
map <F6> <esc>:Shell git blame %<CR>
map <F7> <esc>:make<CR><CR>

nmap <C-x>O :call IFindWord()<CR><CR>

" disable 'ex' mode
map Q <ESC>

set encoding=utf-8
setglobal fileencoding=utf-8


let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='name'       " Sort by the buffer's name.

augroup filetype
  au! BufRead,BufNewFile,BufEnter *.avdl set filetype=avro-idl
  au! BufRead,BufNewFile,BufEnter Capfile set ts=2 sw=2 expandtab syntax=ruby
  au! BufRead,BufNewFile,BufEnter *.ftl,*.macro set filetype=ftl noexpandtab
  au! BufRead,BufNewFile,BufEnter *.go set filetype=go
  au! BufRead,BufNewFile,BufEnter *.h,*.m set expandtab
  au! BufRead,BufNewFile,BufEnter *.hs,*.hsc set ts=2 filetype=haskell expandtab comments+=:--
  au! BufRead,BufNewFile,BufEnter *.java set ts=4 sw=4 noendofline noexpandtab paste
  au! BufRead,BufNewFile,BufEnter *.json map <F7> <esc>:%!jq .<CR><CR>
  au! BufRead,BufNewFile,BufEnter *.json set expandtab syntax=json foldnestmax=16
  au! BufRead,BufNewFile,BufEnter *.jsp set ts=2 sw=2 expandtab
  au! BufRead,BufNewFile,BufEnter Makefile,makefile set noexpandtab
  au! BufRead,BufNewFile,BufEnter *.nft,nftables.conf set filetype=nftables expandtab
  au! BufRead,BufNewFile,BufEnter *.ngc setfiletype ngc
  au! BufRead,BufNewFile,BufEnter *.nxc set filetype=nxc ts=2 sw=2 expandtab
  au! BufRead,BufNewFile,BufEnter *.proto setfiletype proto
  au! BufRead,BufNewFile,BufEnter *.rb set ts=2 sw=2 expandtab
  au! BufRead,BufNewFile,BufEnter *.sbt setfiletype scala
  au! BufRead,BufNewFile,BufEnter *.scad set filetype=openscad
  au! BufRead,BufNewFile,BufEnter *.scala set ts=2 sw=2 expandtab
  au! BufRead,BufNewFile,BufEnter *.sql set ts=2 sw=2 expandtab
  au! BufRead,BufNewFile,BufEnter *.tag set expandtab syntax=xml
  au! BufRead,BufNewFile,BufEnter *.xml set expandtab
augroup end


" Remove trailing whitespace
autocmd  BufWritePre *.scala,*.rb,*efile,*.hs,*.hsc,*.md :%s/\s\+$//e


" Highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
