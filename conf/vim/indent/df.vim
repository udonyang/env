" Author: Dwylkz
" Description: FALSE programming language indent file

if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

func! DfalseIndent()
	let lineno = line('.')
	let prev_lineno = prevnonblank(lineno-1)
	if prev_lineno == 0 
		return 0
	endif

	let shift = indent(prev_lineno)

	let prev_line = getline(prev_lineno)
	if prev_line =~ '[{([]'
		let shift += &shiftwidth
	endif

	let line = getline(lineno)
	if line =~ '^\s*[]})]'
		let shift -= &shiftwidth
	endif

	return shift
endfunc

setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal indentexpr=DfalseIndent()
