" more stuff in https://github.com/DAddYE/dotfiles/blob/master/.vim/vimrc

set nocompatible
" set iskeyword=@,48-57,_,192-255,#
" create a backup of files when editing in /tmp
set backupdir=~/tmp
" swap file directory
set dir=/tmp
"color desert
set background=dark
colorscheme solarized

set backspace=indent,eol,start

" get rid of toolbar
"set guioptions-=T
" no menu bar
set guioptions=-m
set autoindent
set ignorecase
set ruler
set showmatch
set showmode
set tabstop=4
set softtabstop=4
set number
set shiftwidth=4
set hlsearch
set incsearch
set expandtab
set paste
syntax on 

set wmnu

" Completion: http://www.vim.org/scripts/script.php?script_id=2620
let g:neocomplcache_enable_at_startup = 1 

" Python
autocmd FileType python set complete+=k~/.vim/syntax/python.vim 
" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
" pydiction
let g:pydiction_location = '~/.vim/pydiction/complete-dict' 
"

" set GUI font
command F set guifont=Monaco:h13
command G set guifont=Monaco:h16

" do some spell checking by default
autocmd BufEnter *.txt 	set spell
autocmd BufEnter *.txt 	set linebreak

" Taglist variables
" Install ctags from:
" http://code.google.com/p/rudix/downloads/detail?name=ctags-5.8-1.dmg&can=2&q=label%3ARudix-2011
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
nnoremap TT :TlistToggle<CR>
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1

" WDIFF:
"augroup wdiff
"  autocmd BufRead *.wdiff :source $VIMRUNTIME/syntax/wdiff.vim
"  autocmd BufRead *.wdiff map <F3> df]x
"  autocmd BufRead *.wdiff map <F4> xxf+xx
"augroup END

"Mail:
autocmd BufRead,BufNewFile *.mail setfiletype mail 

" Shell Scripts:
" automatically insert "#!/bin/bash" line for *.sh files 
"au BufEnter *.sh if getline(1) == "" | :call setline(1, "#!/bin/bash") | endif 
" " automatically give executable permissions if file begins with #!/bin/sh 
"au BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | silent !chmod a+x <afile> | endif

" JAVA Macros:
"autocmd BufEnter *.java map! <F3> /* DEBUG:  */hhhi 
"autocmd BufEnter *.java map <F3> I/* DEBUG: A */ 
""autocmd BufEnter *.java map! <F4> /**  */hhi
"autocmd BufEnter *.java map! <F2> /**<CR> *<CR>*/kA 
" autocmd FileType java source cvs.vim

"ab {sys} System.out.println("");
"ab {catch} } catch (Exception ex) {}
"ab {imp} import com.ibm.zurich.loganalyzer.*; */<ESC>kAi/** 

"map <F5> :.,+10s/^/  /g<CR>

" HTML/XML:
" :au Filetype html,xml,xsl source ~/.vim/closetag.vim
":au Filetype xml source ~/.vim/xml.vim
"au! BufRead,BufNewFile *.json setfiletype json 
":au Filetype json source ~/.vim/json.vim

" XML NEW: http://www.pinkjuice.com/howto/vimxml/setup.xml
let mapleader = ","
let $ADDED = '~/.vim'

"map <Leader>x :set filetype=xml<CR>
"  \:source $VIMRUNTIME/syntax/xml.vim<CR>
"  \:set foldmethod=syntax<CR>
"  \:source $VIMRUNTIME/syntax/syntax.vim<CR>
"  \:colors peachpuff<CR>
"  \:iunmap <buffer> <Leader>.<CR>
"  \:iunmap <buffer> <Leader>><CR>
"  \:inoremap \> ><CR>
"  \:echo "XML mode is on"<CR>
  " no imaps for <Leader>
  "   "\:inoremap \. ><CR>
  "
  "   " catalog should be set up
"  nmap <Leader>l <Leader>cd:%w !xmllint --valid --noout -<CR>
"  nmap <Leader>r <Leader>cd:%w !rxp -V -N -s -x<CR>
"  nmap <Leader>d4 :%w !xmllint --dtdvalid 
"      \ "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
"      \ --noout -<CR>
  
"  vmap <Leader>px !xmllint --format -<CR>
"  nmap <Leader>px !!xmllint --format -<CR>
"  nmap <Leader>pxa :%!xmllint --format -<CR>
  
"  nmap <Leader>i :%!xsltlint<CR>

" LaTex Macros: http://www.vim.org/howto/latex.html
"autocmd BufEnter *.tex 	set spell

"   ,rl = run latex (on current file)
"autocmd BufEnter *.tex map ,rl :!latex %<CR>
"   ,cps = create ps file (from dvi file of current file)
"autocmd BufEnter *.tex map ,cps :!dvips %<.dvi -o %<.ps<CR>:!ghostview %<.ps<CR>
"   ,cp = create ps file (from dvi file of current file) but don't invoke gv
"autocmd BufEnter *.tex map ,cp :!dvips %<.dvi -o %<.ps<CR>
"   ,vdvi = view dvi file 
"autocmd BufEnter *.tex map ,vdvi :!xdvi %<.dvi &<CR>

"autocmd BufEnter *.tex ab ... \ldots
"autocmd BufEnter *.tex imap  \emph{}<ESC>i
"autocmd BufEnter *.tex imap  \textbf{}<ESC>i

"autocmd BufEnter *.tex map! ]s1 \chapter{}<ESC>i
"autocmd BufEnter *.tex map! ]s2 \section{}<ESC>i
"autocmd BufEnter *.tex map! ]s3 \subsection{}<ESC>i
"autocmd BufEnter *.tex map! ]s4 \subsubsection{}<ESC>i

"autocmd BufEnter *.tex map! ]bi \begin{itemize}<CR>\item <CR>\end{itemize}<ESC>kA
"autocmd BufEnter *.tex map! ]be \begin{enumerate}<CR>\item <CR>\end{enumerate}<ESC>kA

"autocmd BufEnter *.tex map K :call <SID>RunLatex()<CR><Esc>
"autocmd BufEnter *.tex map <C-Tab> :call <SID>RunLatex()<CR><Esc>
"autocmd BufEnter *.tex map <C-Tab> <Esc>:call <SID>RunLatex()<CR><Esc>

"function! s:RunLatex()
"    write
"    split %<.log
"    q!
""    ! xterm -bg ivory -fn 7x14 -e latex % &
"    ! latex %
"endfunction

" more tex...

"set makeprg=texwrapper\ -lw
"set errorformat=%f:%l:%c:%m
"command LaTeX silent make %

" cleaning .tex up
"autocmd BufLeave *.tex unmap ,rl
"autocmd BufLeave *.tex unmap ,cps
"autocmd BufLeave *.tex unmap ,vdvi
"autocmd BufLeave *.tex iunmap 
"autocmd BufLeave *.tex iunmap 
"autocmd BufLeave *.tex unmap ]s1
"autocmd BufLeave *.tex unmap ]s2
"autocmd BufLeave *.tex unmap ]s3
"autocmd BufLeave *.tex unmap ]s4
"autocmd BufLeave *.tex unmap ]bi
"autocmd BufLeave *.tex unmap ]be

" LATEX:
" REQUIRED. This makes vim invoke latex-suite when you open a tex file.
"filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name.
"set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
filetype plugin on 

"augroup TeX
  "autocmd FileType tex source ~/.vim/tex.vim
  "autocmd FileType tex :set nonumber 
"augroup END

" C-S saves the file.
" If C-S is not assigned to anything, some terminals will hang
" when pressing those keys.
"noremap <C-S> :w<CR>
"inoremap <C-S> <C-O>:w<CR>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"autocmd BufReadPost *
"  \ if line("'\"") > 0 && line("'\"") <= line("$") |
"  \   exe "normal g`\"" |
"  \ endif

"noremap <buffer> W :call <SID>WhereAmI()<CR><Esc>

"function! s:WhereAmI()
"	" set mark
"	let s:where=""
"	if search("subsection", 'Wb') != 0 
"		let s:where=substitute(getline("."), "\subsection{","","") 
""		let s:where=substitute(s:where, "}","","") 
"	endif
"	if search("section", 'Wb') != 0 
"		let s:where=s:where . substitute(getline("."), "\section{","","") 
"		let s:where=substitute(s:where, "}","","") 
"	endif
""	if search("chapter", 'Wb') != 0 
"		let s:where=s:where . substitute(getline("."), "\chapter{","","") 
"		let s:where=substitute(s:where, "}","","") 
"	endif
"	echo s:where
"	"return to mark
"endfunction	


" NOT THE NICEST TO DO, but works... Annoying other window...
" Find Latex Errors
" To find the tex error, first run Latex (see the 2 previous maps).
" If there is an error, press "x" or "r" to stop the Tex processing.
" Then press Shift-Tab to go to the position of the error.
"noremap <buffer> <S-Tab> :call <SID>NextTexError()<CR><Space>
"inoremap <buffer> <S-Tab> <Esc>:call <SID>NextTexError()<CR><Space> 

"function! s:NextTexError()
"    only
"    edit %<.log
"    edit %
"    exe "normal G/\l\\.\\d\<CR>f zz"
"    let s:numberlength = col(".") - 3
"    normal $
"    let s:errorposition = col(".") - s:numberlength - 4
"    let s:linenumber = strpart(getline(line(".")), 2, s:numberlength)
"    "Put a space in the .log file so that you can see where you were,
"    "and move on to the next latex error.
"    exe "normal I \<Esc>"
"    write
"    split #
"    exe "normal" s:linenumber . "G" . s:errorposition . "lzz"
"endfunction

" Errorformat for jikes when invoked with +E
":set efm=%f:%l:%v:%*\\d:%*\\d:%*\\s%m

"noremap <F8> :so `~/thor/thesis/vimspell.sh %`<CR><CR>
"noremap <F7> :syntax clear SpellErrors<CR>

"map ,f   :update<CR>:silent !start c:\progra~1\intern~1\iexplore.exe file://%:p<CR>
"map ,i   :update<CR>: !start c:\progra~1\intern~1\iexplore.exe <cWORD><CR>

" from http://www.vim.org/tips/tip.php?tip_id=1030 use :Diff
"function! s:DiffWithSaved() 
"    diffthis 
"    new | r # | normal 1Gdd 
""    diffthis 
"    setlocal bt=nofile bh=wipe nobl noswf ro 
"endfunction 
"com! Diff call s:DiffWithSaved() 
