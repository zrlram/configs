" Vim syntax file
" Language:	JSON
" Maintainer:	Jeroen Ruigrok van der Werven <asmodai@in-nomine.org>
" Last Change:	2007-07-11
" Version:      0.3
" {{{1

" Syntax setup {{{2
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded

syn clear

" Syntax: Strings {{{2
syn region  jsonString    start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=jsonEscape
" Syntax: JSON does not allow strings with single quotes, unlike JavaScript.
syn region  jsonStringSQ  start=+'+  skip=+\\\\\|\\"+  end=+'+

" Syntax: Escape sequences {{{3
syn match   jsonEscape    "\\["\\/bfnrt]" contained
syn match   jsonEscape    "\\u\x\{4}" contained

" Syntax: Numbers {{{2
syn match   jsonInteger   "-\=\<[1-9]\d*\>"
syn match   jsonFraction  "-\=\<\([1-9]\d*\|0\)\.\d\+\>"
syn match   jsonExponent  "-\=\<[1-9]\d*[eE][+-]\=\d\+\>"
syn match   jsonFracExp   "-\=\<\([1-9]\d*\|0\)\.\d\+[eE][+-]\=\d\+\>"

" Syntax: An integer part of 0 followed by other digits is not allowed.
syn match   jsonNumError  "-\=\<0\d.*\>"

" Syntax: Boolean {{{2
syn keyword jsonBoolean   true false

" Syntax: Null {{{2
syn keyword jsonNull      null

" Syntax: Braces and Parentheses {{{2
syn match   jsonBraces	   "[{}\[\]]"
syn match   jsonParens	   "[()]"

command -nargs=+ HiLink hi def link <args>
HiLink jsonString             String
HiLink jsonEscape             Special
HiLink jsonInteger		Number
HiLink jsonFraction		Number
HiLink jsonExponent		Number
HiLink jsonFracExp            Number
HiLink jsonBraces		Operator
HiLink jsonNull		Function
HiLink jsonBoolean		Boolean

HiLink jsonNumError           Error
HiLink jsonStringSQ           Error
delcommand HiLink

let b:current_syntax = "json"

" Vim settings {{{2
" vim: ts=8 fdm=marker
