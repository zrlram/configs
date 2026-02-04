" more stuff in https://github.com/DAddYE/dotfiles/blob/master/.vim/vimrc

set nocompatible
" set iskeyword=@,48-57,_,192-255,#
" create a backup of files when editing in /tmp
set backupdir=~/tmp
" swap file directory
set dir=/tmp

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

" don't like folds in MD files
" autocmd FileType markdown setlocal foldmethod=manual
autocmd FileType markdown setlocal foldlevel=99

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
"
"   " Make sure you use single quotes
"
"   " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
"
"   " Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
"
"   " Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
"   " On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"   " Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
"   " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }
"
"   " Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
"   " Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
"   " Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" https://github.com/ghifarit53/tokyonight-vim
Plug 'ghifarit53/tokyonight-vim'

call plug#end()

" Color Scheme
" https://github.com/ghifarit53/tokyonight-vim
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

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
let Tlist_File_Fold_Auto_Close = 0

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

"map <F5> :.,+10s/^/  /g<CR>

" HTML/XML:
" :au Filetype html,xml,xsl source ~/.vim/closetag.vim
":au Filetype xml source ~/.vim/xml.vim
"au! BufRead,BufNewFile *.json setfiletype json 
":au Filetype json source ~/.vim/json.vim

" XML NEW: http://www.pinkjuice.com/howto/vimxml/setup.xml
let mapleader = ","
let $ADDED = '~/.vim'

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
filetype plugin on 

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

" from http://www.vim.org/tips/tip.php?tip_id=1030 use :Diff
"function! s:DiffWithSaved() 
"    diffthis 
"    new | r # | normal 1Gdd 
""    diffthis 
"    setlocal bt=nofile bh=wipe nobl noswf ro 
"endfunction 
"com! Diff call s:DiffWithSaved() 
