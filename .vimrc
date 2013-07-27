"Global Value

"Setting
colorscheme desert
set langmenu=en_US.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages en_US.UTF-8
syntax on
filetype on
filetype plugin indent on
set go-=T
set go-=m
set smartindent
set autochdir
set autoindent
set smartindent
set backspace=2
set guifont=Courier\ New
set cindent
set columns=120
set foldmethod=syntax
set nohlsearch
set incsearch
set lines=40
set nocompatible
set noswapfile
set number
set shiftwidth=4
set tabstop=4
let g:netrw_liststyle=3

"autocmd
autocmd BufNewFile,BufRead *.* call TypeCheck()
autocmd BufNewFile,BufRead *.go set filetype=go
autocmd BufNewFile,BufRead *.i set filetype=c

"new runtimepath
set runtimepath+=$GOROOT/misc/vim

"Function
func TypeCheck()
  if &filetype == 'i' || &filetype == 'c' || &filetype == 'cpp'
	if &filetype != 'cpp'
		set filetype=c
	endif
    set tabstop=2
    set shiftwidth=2
    set expandtab
  else
    set tabstop=4
    set shiftwidth=4
    set noexpandtab
  endif
endfunc
func Compile()
	exec "w"
	exec "make"
endfunc
func DebugCompile()
	exec "w"
	exec "make make_debug"
endfunc
func Debug()
	exec "w"
	exec "make debug"
endfunc
func ErrorList()
	exec "clist"
endfunc
func Run()
	exec "w"
	exec "make run"
endfunc
func Clean()
	exec "w"
	exec "make clean"
endfunc
func Test()
	exec "15vs ."
endfunc
func Output()
	if &filetype == 'c' || &filetype =='cpp'
		exec "9sv output.out"
	endif
endfunc

"map
map <F2> :call Test()<CR>
map <F3> :call Output()<CR>
map <F4> :tabp<CR>
map <F5> :tabn<CR>
map <C-a> ggVG
map <C-p> "+p
map <F8> <ESC>:call ErrorList()<CR>
map <C-F8> <ESC>:call Debug()<CR>
map <F9> <ESC>:call Compile()<CR>
map <C-F9> <ESC>:call Run()<CR>
map <F10> <ESC>:call DebugCompile()<CR>
map <C-F10> <ESC>:call Clean()<CR>
map <silent><F6> :s#^#// #g<CR>
map <silent><F7> :s#^// ##g<CR>
cmap <C-j> <Left>
cmap <C-k> <Right>
vmap <C-y> "+y
inoremap <C-a> <ESC>ggVG
inoremap <F9> <ESC>:call Compile()<CR>
inoremap <C-F9> <ESC>:call Run()<CR>
inoremap <F8> <ESC>:call ErrorList()<CR>

"abbreviate
ab abOK /* OK */
