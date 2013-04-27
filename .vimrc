"Global Value
"Setting
colorscheme desert
set langmenu=en_US.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages en_US.UTF-8
syntax on
set go-=T
set go-=m
set smartindent
set autochdir
set autoindent
set backspace=2
set cindent
set columns=83
set foldmethod=syntax
set guifont=Monospace\ 12
set hlsearch
set incsearch
set lines=31
set nocompatible
set noswapfile
set number
set shiftwidth=4
set syntax=&filetype
set tabstop=4
let g:netrw_liststyle=3
"Function
func Compile()
	exec "w"
	exec "!ctags %"
	exec "make"
endfunc
func ErrorList()
	exec "clist"
endfunc
func Run()
	exec "w"
	if &filetype == 'c' || &filetype =='cpp'
		exec "!'./%<'"
		"exec "call Output()"
	elseif &filetype == 'html'
		exec "!gnome-open %"
	elseif &filetype == 'plaintex'
		exec "!gnome-open %<.pdf"
	elseif &filetype == 'java'
		exec "!java '%<'"
	elseif &filetype == 'sh'
		exec "!./'%'"
	endif
endfunc
func Test()
	if &filetype == 'c' || &filetype =='cpp'
		"exec "15vs input.in"
		exec "15vs ."
	endif
endfunc
func Output()
	if &filetype == 'c' || &filetype =='cpp'
		exec "9sv output.out"
	endif
endfunc
"map
map <F2> :call Test()<CR>
map <F3> :call Output()<CR>
map <C-a> ggVG
map <F9> <ESC>:call Compile()<CR><CR><CR>
map <C-F9> <ESC>:call Run()<CR>
map <F8> <ESC>:call ErrorList()<CR>
cmap <C-j> <Left>
cmap <C-k> <Right>
vmap <C-c> "+y''
inoremap <C-a> <ESC>ggVG''
inoremap <F9> <ESC>:call Compile()<CR>
inoremap <C-F9> <ESC>:call Run()<CR>
inoremap <F8> <ESC>:call ErrorList()<CR>
