"""""""""""""""
" vundle begin
"""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'git@github.com:VundleVim/Vundle.vim'

"Plugin 'git@github.com:Valloric/YouCompleteMe'
"Plugin 'git@github.com:ervandew/supertab'
Plugin 'git@github.com:kien/ctrlp.vim'
Plugin 'git@github.com:luochen1990/rainbow' "Rainbow Parentheses Improved
Plugin 'git@github.com:Yggdroot/indentLine'
"Plugin 'git@github.com:godlygeek/tabular'
Plugin 'git@github.com:junegunn/vim-easy-align'
"Plugin 'git@github.com:vhda/verilog_systemverilog.vim'
Plugin 'git@github.com:cazador481/vim-systemverilog'
Plugin 'git@github.com:scrooloose/nerdcommenter'
Plugin 'git@github.com:dracula/vim'

"Plugin 'git@github.com:majutsushi/tagbar'
Plugin 'git@github.com:vim-airline/vim-airline'
" Plugin 'git@github.com:bling/vim-bufferline'
Plugin 'git@github.com:mhinz/vim-startify'

" Plugin 'git@github.com:vim-scripts/increment.vim'
Plugin 'git@github.com:triglav/vim-visual-increment'

"Plugin 'git@github.com:tpope/vim-fugitive'
"Plugin 'git@github.com:vim-scripts/GrepCommands'

"Plugin 'git@github.com:amoffat/snake'


"" The following are examples of different formats supported."
"" Keep Plugin commands between vundle#begin/end."
"" plugin on GitHub repo"
"Plugin 'tpope/vim-fugitive'"
"" plugin from http://vim-scripts.org/vim/scripts.html"
"" Plugin 'L9'"
"" Git plugin not hosted on GitHub"
"Plugin 'git://git.wincent.com/command-t.git'"
"" git repos on your local machine (i.e. when working on your own plugin)"
"Plugin 'file:///home/gmarik/path/to/plugin'"
"" The sparkup vim script is in a subdirectory of this repo called vim."
"" Pass the path to set the runtimepath properly."
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}"
"" Install L9 and avoid a Naming conflict if you've already installed a"
"" different version somewhere else."
"" Plugin 'ascenator/L9', {'name': 'newL9'}"


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
let g:vundle_default_git_proto = 'git'

"""""""""""""
" vundle end
"""""""""""""

" This must be first, because it changes other options as a side effect.
set nocompatible

"" command
set history=50          " keep 50 lines of command line history
set showcmd             " display incomplete commands

"" display
set ruler               " show the cursor position all the time
set number            " show number lines in front of text
nmap ,n :set number<CR>
nmap ,,n :set nonumber<CR>
syntax on

"" tab style : using space to replace tabs
""   while using Make, set noexpandtab
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
autocmd FileType make setlocal noexpandtab
autocmd Filetype verilog_systemverilog setlocal shiftwidth=4 softtabstop=4 expandtab smarttab
autocmd Filetype c setlocal shiftwidth=4 softtabstop=4 expandtab smarttab
autocmd Filetype cpp setlocal shiftwidth=4 softtabstop=4 expandtab smarttab
autocmd Filetype javascript setlocal shiftwidth=4 softtabstop=4 expandtab smarttab

set textwidth=0
set wrapmargin=0
set formatoptions-=cro

set fileformat=unix
set encoding=utf-8
set fileencodings=utf-8

"" print
set printfont=YaHei_Consolas_Hybrid:h8
set printheader=%<File:\ %t%=Page:\ %N

" color scheme
" color dracula " has comment out if zsh already use dracula

if (has("gui_running"))
    "" GVim
    set guioptions=amc   "only menu, no toolbar
    colorscheme morning
    set guifont=Monaco:h14
    "set lines=58 columns=238
else
    "" Vim on Termial
    " colorscheme desert
    colorscheme dracula
    "colorscheme default
    set mouse=a
endif

"au BufNewFile,BufReadPre *.asm let b:asmsyntax='masm'
au BufRead,BufNewFile *.upf set filetype=tcl
au BufRead,BufNewFile *.cpf set filetype=tcl
au BufRead,BufNewFile *.sdc set filetype=tcl
au BufRead,BufNewFile *.lib set filetype=tcl
au BufRead,BufNewFile *.nt set filetype=tcl
au BufRead,BufNewFile *.conf set filetype=tcl
au BufRead,BufNewFile *.sv set filetype=verilog_systemverilog
au BufRead,BufNewFile *.svpp set filetype=verilog_systemverilog
au BufRead,BufNewFile *.svhpp set filetype=verilog_systemverilog
au BufRead,BufNewFile *.svh set filetype=verilog_systemverilog
au BufRead,BufNewFile *.svi set filetype=verilog_systemverilog
au BufRead,BufNewFile *.svp set filetype=verilog_systemverilog
au BufRead,BufNewFile *.tie set filetype=verilog_systemverilog
au BufRead,BufNewFile *.j2tie set filetype=verilog_systemverilog
au BufRead,BufNewFile *.bv set filetype=verilog_systemverilog
au BufRead,BufNewFile *.gv set filetype=verilog_systemverilog
au BufRead,BufNewFile *.vh set filetype=verilog_systemverilog
au BufRead,BufNewFile *.v set filetype=verilog_systemverilog
au BufRead,BufNewFile *.vin set filetype=verilog_systemverilog
au BufRead,BufNewFile *.j2sv set filetype=verilog_systemverilog
au BufRead,BufNewFile *.j2svh set filetype=verilog_systemverilog
au BufRead,BufNewFile *.svi set filetype=verilog_systemverilog
au BufRead,BufNewFile *.spi set filetype=spice
au BufRead,BufNewFile *.spm set filetype=spice
au BufRead,BufNewFile *.spm028 set filetype=spice
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile Makef* set filetype=make
au BufRead,BufNewFile make* set filetype=make
au BufRead,BufNewFile *.d set filetype=make
au BufRead,BufNewFile *.make set filetype=make
au BufRead,BufNewFile *.cj2 set filetype=c
au BufRead,BufNewFile *.cppj2 set filetype=cpp

au BufRead,BufNewFile *.cpp colorscheme default
au BufRead,BufNewFile *.c colorscheme default
au BufRead,BufNewFile *.h colorscheme default

filetype plugin on

"" search
set incsearch           " do incremental searching
set hlsearch
"set ignorecase

"" backup
set backup
set backupdir=~/bak/vim//,/tmp//
set backupskip='*.log'

"" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"" auto indent
set autoindent          " always set autoindenting on

"" auto write before switching between buffers
set noautowriteall

"" match {}[]()
set showmatch
set matchtime=5

""" fold
set foldmethod=marker
set foldmarker={{{,}}}
" autocmd FileType python setlocal foldmethod=syntax
autocmd FileType markdown setlocal conceallevel=0
autocmd FileType markdown setlocal foldmethod=marker
autocmd FileType verilog_systemverilog setlocal foldmethod=marker
autocmd FileType cpp setlocal commentstring=\ \/\/\ %s

let g:indentLine_concealcursor = "nv"

""" comment
" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDCustomDelimiters = { 'python': { 'left': '#' } }

""" comment verilog
"vmap ,/  :s/^/\/\/ /g<CR>:nohl<CR>
"vmap ,,/ :s/^\/\/ //g<CR>:nohl<CR>
"nmap ,/  V:s/^/\/\/ /g<CR>:nohl<CR>
"nmap ,,/ V:s/^\/\/ //g<CR>:nohl<CR>
""" comment tcl
"vmap ,3  :s/^/# /g<CR>:nohl<CR>
"vmap ,,3 :s/^# //g<CR>:nohl<CR>
"nmap ,3  V:s/^/# /g<CR>:nohl<CR>
"nmap ,,3 V:s/^# //g<CR>:nohl<CR>
"nmap ,j3 :s/^/# jun /g<CR>:nonhl<CR>
"vmap ,j3 V:s/^/# jun /g<CR>:nonhl<CR>
""" comment vim
"vmap ,;  :s/^/; /g<CR>:nohl<CR>
"vmap ,,; :s/^; //g<CR>:nohl<CR>
"nmap ,;  V:s/^/; /g<CR>:nohl<CR>
"nmap ,,; V:s/^; //g<CR>:nohl<CR>
""" comment hspice
"vmap ,8  :s/^/\* /g<CR>:nohl<CR>
"vmap ,,8 :s/^\* //g<CR>:nohl<CR>
"nmap ,8  V:s/^/\* /g<CR>:nohl<CR>
"nmap ,,8 V:s/^\* //g<CR>:nohl<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" add \ to lines
vmap ,\  :s/$/ \\/<CR>:nohl<CR>
vmap ,,\ :s/ \\$//<CR>

" add " to lines
vmap ,"  :s/^/"/<CR>:'<,'>s/$/"/<CR>:nohl<CR>
vmap ,," :s/^"//<CR>:'<,'>s/"$//<CR>:nohl<CR>

"" up and down arrow
nmap <Up> gkzz
nmap <Down> gjzz

"" find selected
vmap ,f y:let @0=substitute(@0, "\/", "\\\\\\\/", "g")<CR>:/<C-R>0<CR>
vmap ,ls y:!ls -l -h <C-R>0<CR>
": grep selectd
vmap ,gg y:grep "<C-R>0" %<CR>
vmap ,ga y:grep "<C-R>0" *.*<CR>
vmap ,gt y:grep "<C-R>0" *.tcl<CR>
vmap ,gv y:grep "<C-R>0" *.?v<CR>


"" copy register
" autocmd FocusGained * let @z=@+
" set clipboard=unnamedplus

"" cancel highlight
nmap ,h :nohl<CR>

nmap ,i :set ignorecase<CR>
nmap ,,i :set noignorecase<CR>

"" remove lines with selected keywords
vmap ,r y:set noignorecase<CR>:%s!^.*<C-R>0.*$\n!!<CR>

nmap ,p V:s!^!<C-R>0!<CR>
vmap ,p :s!^!<C-R>0!<CR>
nmap ,P V:s!$!<C-R>0!<CR>
vmap ,P :s!$!<C-R>0!<CR>

nmap ,w :set wrap<CR>
nmap ,,w :set nowrap<CR>

"" windows
"""" increase window
nmap <C-PageUp>     :resize +3<CR>
nmap <C-PageDown>   :resize -3<CR>
"""" maximize the window
nmap <C-HOME>       :resize 100<CR>
"""" minimize the windwo
nmap <C-END>        :resize 1<CR>
"""" move to the windows above/under
nmap <C-UP>         <C-W><C-K>
nmap <C-Down>       <C-W><C-J>
nmap <C-Left>       <C-W><C-H>
nmap <C-Right>      <C-W><C-L>
nmap ,v        :vsplit<CR><C-W><C-L>:vertical resize +30<CR><C-W><C-H>:set nonumber<CR>:set nowrap<CR><C-W><C-L>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbrev
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" for commenting
iabbrev //// ///////////////////////////////////////////////////////////////
iabbrev ///= //=========================================================
iabbrev ///- //-----------------------------------------------------

iabbrev #### ###############################################################
iabbrev #=== #==========================================================
iabbrev #--- #------------------------------------------------------

iabbrev """" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" for python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" quick input
"imap <C-D> def  ():<CR><Tab>"""<CR>"""<CR># {{{<CR># }}}<CR>return<ESC>kkkkkhhhi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for verilog
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoreabbr aa, always @ (posedge clk or negedge rstn) begin<CR>end<ESC>k$a
inoreabbr af, always_ff @ (posedge clk or negedge rstn) begin<CR>end<ESC>k$a
inoreabbr ac, always_comb begin<CR>end<ESC>k$a
inoreabbr if, if () begin<CR>end else begin<CR>end<ESC>2k$a
inoreabbr case, case ()<CR>endcase<ESC>Odefault:<ESC>k$a
inoreabbr as, assert property (@(posedge clk) disable iff (rstn === '0) ( ))<CR>    else $error("%m: ");<ESC>k$2hi

"" find current selected word
vmap ,ff y:grep <C-R>0 *<CR>
vmap ,fg y:Ggrep <C-R>0<CR>

"" find warning or error
nmap ,fe :e<CR>:set ignorecase<CR>/error<CR>
nmap ,fw :e<CR>:set ignorecase<CR>/warning<CR>

" quick input
imap <C-B> <ESC>$abegin<CR>end<ESC>O
imap <C-E> <ESC>$aelse begin<CR>end<ESC>O
imap <C-F> <ESC>$abegin<CR>end else begin<CR>end<ESC>kO
imap <C-C> case ()<CR>endcase<ESC>k$i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Tab> <C-W><C-W>

"" project
"let g:proj_flags="mst" "<F12> to toggle project window
"let g:proj_window_width=30
"nmap <silent> <Leader>tp <Plug>ToggleProject
"nmap <F12> <Leader>tp

"" nerd tree
nmap <C-F12> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 20
"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror

nmap <C-H> :bp<CR>
nmap <C-J> :bp<CR>
nmap <C-K> :bn<CR>
nmap <C-L> :bn<CR>

"" increment
" vmap <C-I> :Inc<CR>

" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlPBuffer'

"" python syntax
let python_highlight_all = 1

if &diff
    set nonu
    set diffopt+=iwhite
endif

let g:rainbow_active = 1
runtime macros/matchit.vim
runtime! macros/matchit.vim
if exists('loaded_matchit')
  let b:match_ignorecase=0
  let b:match_words=
    \ '\<begin\>:\<end\>,' .
    \ '\<if\>:\<else\>,' .
    \ '\<module\>:\<endmodule\>,' .
    \ '\<class\>:\<endclass\>,' .
    \ '\<program\>:\<endprogram\>,' .
    \ '\<clocking\>:\<endclocking\>,' .
    \ '\<property\>:\<endproperty\>,' .
    \ '\<sequence\>:\<endsequence\>,' .
    \ '\<package\>:\<endpackage\>,' .
    \ '\<covergroup\>:\<endgroup\>,' .
    \ '\<primitive\>:\<endprimitive\>,' .
    \ '\<specify\>:\<endspecify\>,' .
    \ '\<generate\>:\<endgenerate\>,' .
    \ '\<interface\>:\<endinterface\>,' .
    \ '\<function\>:\<endfunction\>,' .
    \ '\<task\>:\<endtask\>,' .
    \ '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,' .
    \ '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>,' .
    \ '`ifdef\>:`else\>:`endif\>,'
endif

"let g:indentLine_setConceal = 0

highlight Pmenu ctermfg=black ctermbg=grey gui=bold
highlight PmenuSel cterm=bold ctermfg=blue ctermbg=white gui=bold
set completeopt=menu,menuone,longest    " Use the popup menu by default; only insert the longest common text of the completion matches; don't automatically show extra information in the preview window.

let g:SuperTabDefaultCompletionType = 'context'

set tags=./tags,../tags,../../tags

"" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ':t'
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" git: fugitive
nmap ,gcf :Git add %<CR>:Gcommit -m "tmp save file %"<CR>
nmap ,gca :Git add .<CR>:Gcommit -m "tmp save files in dir %:p:h"<CR>

" verilog
let g:verilog_disable_indent_lst = "module,conditional,eos"

"" snake
"if filereadable(expand("~/.vim/bundle/snake/plugin/snake.vim"))
"    source ~/.vim/bundle/snake/plugin/snake.vim
"endif
"pyfile ~/script/myvim.py
