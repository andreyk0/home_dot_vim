" Vim syntax file
" Language:	SSP (Scala Server Pages)
"
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'ssp'
endif

" Source HTML syntax
if version < 600
  source <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
endif
unlet b:current_syntax

" Next syntax items are case-sensitive
syn case match

" Include Scala syntax
syn include @sspScala <sfile>:p:h/scala.vim

syn region sspScriptlet matchgroup=sspTag start=/<%/  keepend end=/%>/ contains=@sspScala
syn region sspComment			  start=/<%--/	      end=/--%>/
syn region sspDecl	matchgroup=sspTag start=/<%!/ keepend end=/%>/ contains=@sspScala
syn region sspExpr	matchgroup=sspTag start=/<%=/ keepend end=/%>/ contains=@sspScala
"""syn region sspDirective			  start=/<%@/	      end=/%>/ contains=htmlString,sspDirName,sspDirArg
syn region sspDirective			  start=/<%@/	      end=/%>/ contains=@sspScala

syn keyword sspDirName contained include page taglib
syn keyword sspDirArg contained file uri prefix language extends import session buffer autoFlush
syn keyword sspDirArg contained isThreadSafe info errorPage contentType isErrorPage
syn region sspCommand			  start=/<ssp:/ start=/<\/ssp:/ keepend end=/>/ end=/\/>/ contains=htmlString,sspCommandName,sspCommandArg
syn keyword sspCommandName contained include forward getProperty plugin setProperty useBean param params fallback
syn keyword sspCommandArg contained id scope class type beanName page flush name value property
syn keyword sspCommandArg contained code codebase name archive align height
syn keyword sspCommandArg contained width hspace vspace jreversion nspluginurl iepluginurl

" Redefine htmlTag so that it can contain sspExpr
syn region htmlTag start=+<[^/%]+ end=+>+ contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,sspExpr

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_ssp_syn_inits")
  if version < 508
    let did_ssp_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  " java.vim has redefined htmlComment highlighting
  HiLink htmlComment	 Comment
  HiLink htmlCommentPart Comment
  " Be consistent with html highlight settings
  HiLink sspComment	 htmlComment
  HiLink sspTag		 htmlTag
  HiLink sspDirective	 sspTag
  HiLink sspDirName	 htmlTagName
  HiLink sspDirArg	 htmlArg
  HiLink sspCommand	 sspTag
  HiLink sspCommandName  htmlTagName
  HiLink sspCommandArg	 htmlArg
  delcommand HiLink
endif

if main_syntax == 'ssp'
  unlet main_syntax
endif

let b:current_syntax = "ssp"

" vim: ts=8
