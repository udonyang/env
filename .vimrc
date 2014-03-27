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
set columns=120
set foldmethod=syntax
set incsearch
set lines=40
set nocompatible
set noswapfile
set number
set shiftwidth=2
set tabstop=2

"Global Values
""Browser
let g:netrw_liststyle=3
let mapleader=","

"Autocmd

"Function
func! ErrorList()
	exec "clist"
endfunc
func! Make(target)
  exec "w"
  exec "make!" a:target
endfunc
func! Browser()
	exec "15vs ."
endfunc

"Map
""Basic
imap jj <ESC>
map <C-a> ggVG
vmap <C-y> "+y
map <C-p> "+p
map <F3> <ESC>:tabe  
map <F4> <ESC>:tabp<CR>
map <F5> <ESC>:tabn<CR>
map <F2> <ESC>:call Browser()<CR>
map <F8> <ESC>:call ErrorList()<CR>
""Make
map <C-F8> <ESC>:call Make("debug")<CR>
map <F9> <ESC>:call Make("")<CR>
map <C-F9> <ESC>:call Make("run")<CR>
map <F10> <ESC>:call Make("test")<CR>
""Doxygen
nmap <leader>a :DoxAuthor<CR>
nmap <leader>d :Dox<CR>
nmap <leader>l :DoxLic<CR>

"Abbreviate
