" TI-BASIC syntax file using TI8X series tokens
"
" Source: https://github.com/Arian04/vim-tibasic-syntax

" quit if a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

" Numbers
syn match   tiNumber		"\<\d\+\>"
syn match   tiNumber		"\<\d\+\>\.\<\d\+\>"

" Comments
syn match  tiComment		"#.*$"

" Strings TODO: understand this syntax
syn region  tiString		start=+"+ skip=+\\\\\|\\"+ end=+"+ 

" case sensitive matches
syn case match
