set cscopetag
autocmd BufReadPre,BufRead,BufNew * set tags+=~/.csdb/tags
autocmd BufReadPre,BufRead,BufNew * cscope reset
autocmd BufReadPre,BufRead,BufNew * cscope add ~/.csdb/cscope.out
