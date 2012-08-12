" Language:latex, tex
" Maintainer:Johannes Zellner <johannes@zellner.org>
" URL:http://www.zellner.org/vim/fold/tex.vim
" Last Change:Son, 01 Apr 2001 06:16:53 +0200
" $Id: tex.vim,v 1.3 2001/04/03 03:57:33 joze Exp $ 
" finish 
" [-- local settings --]
setlocal foldexpr=TexFold(v:lnum) " [-- avoid multiple sourcing --]
if exists("*TexFold")
    setlocal foldmethod=expr
    finish
endif 

fun! TexFoldContextWithDepth(line)
"    if a:line =~ '\\part\>'
"return 0
    if a:line =~ '\\\(chapter\>\|begin{thebibliography}\)'
return 1
    elseif a:line =~ '\\section\>'
return 2
    elseif a:line =~ '\\subsection\>'
return 3
    elseif a:line =~ '\\subsubsection\>'
return 4
    else
return 0
    endif
endfun 

fun! TexFoldContextFlat(line)
    if a:line =~ '\\\(part\|chapter\|\(sub\)\=section\|subsubsection\)\>'
return 1
    else
return 0
    endif
endfun 

fun! TexFold(lnum)
    " remove comments
    let line = substitute(getline(a:lnum), '\(^%\|\s*[^\\]%\).*$', '', 'g')
    let level = TexFoldContextWithDepth(line)
    " let level = TexFoldContextFlat(line)
    if level
exe 'return ">'.level.'"'
"    elseif line =~ '.*\\begin\>.*'
"return 'a1'
"    elseif line =~ '.*\\end\>.*'
"return 's1'
    else
return '='
    endif
endfun " [-- trigger indention --]

setlocal foldmethod=expr
