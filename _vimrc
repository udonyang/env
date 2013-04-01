"Dwylkz
"Global Value
"Setting
language message en_US.UTF-8
colorscheme desert
syntax on
set nobackup
set shell=cmd.exe
set shellcmdflag=/C
set autochdir
set ignorecase
set fdm=syntax
set lines=31
set co=90
set is
set ts=4
set gfn=Courier\ New:h13
set sw=4
set ai
set cindent
set syntax=&filetype
set nu
set hls
set scs
set sb
set noswapfile
set nobackup
set makeprg=%mysys%\bin\make.exe

"Function
func Compile()
	exec "w"
	exec "make"
endfunc
func ErrorList()
	exec "clist"
endfunc
func Run()
	exec "w"
	if &filetype == 'c' || &filetype =='cpp'
		exec "!%<.exe"
	elseif &filetype == 'java'
		exec "!java %<"
	elseif &filetype == 'plaintex'
		exec "!texworks %<.pdf"
	endif
endfunc
func Test()
	if &filetype == 'c' || &filetype =='cpp'
		exec "15vs input.in"
		exec "15sp"
		exec "e ."
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
map <F9> <ESC>:call Compile()<CR>
map <C-F9> <ESC>:call Run()<CR>
map <C-F8> <ESC>:call ErrorList()<CR>
cmap <C-j> <Left>
cmap <C-k> <Right>
inoremap <F9> <ESC>:call Compile()<CR>
inoremap <C-F9> <ESC>:call Run()<CR>
inoremap <F8> <ESC>:call ErrorList()<CR>
"Default
set nocompatible
let $LANG='en'
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
