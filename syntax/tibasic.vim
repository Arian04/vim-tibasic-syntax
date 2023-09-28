" TI-BASIC syntax file using TI8X series tokens
"
" Source: https://github.com/Arian04/vim-tibasic-syntax

" quit if a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

" File numbers
syn match   tiFileNumber	"#\d+"

" Operators
syn match   tiOperator		"[<>+\*^/=-]"

" Numbers
syn match   tiNumber		"\<\d\+\>"
syn match   tiNumber		"\<\d\+\>\.\<\d\+\>"

" Variable Identifiers
syn match   tiVar		"\<[a-zA-Z_][a-zA-Z0-9_]*\>\$\?"

" Comments
syn region  tiComment		start="#\s*" end="$"

" Strings TODO: understand this
syn region  tiString		start=+"+ skip=+\\\\\|\\"+ end=+"+ 

" Statements
syn case match

syn keyword tiStatement		ACCEPT AND CALL CLOSE DATA DEF DIM DISPLAY END FOR TO STEP NEXT GOSUB GOTO 
syn keyword tiStatement		IF THEN ELSE IMAGE INPUT LET LINPUT NEXT OPEN OR PRINT RANDOMIZE READ RESTORE
syn keyword tiStatement		RETURN STOP SUB SUBEND SUBEXIT 
syn region  tiStatement		start="[Oo][Nn]\W" end="[Bb][Rr][Ee][Aa][Kk]"
syn region  tiStatement		start="[Oo][Nn]\W" end="[Ee][Rr][Rr][Oo][Rr]"
syn region  tiStatement		start="[Oo][Nn]\W" end="[Gg][Oo][Ss][Uu][Bb]"
syn region  tiStatement		start="[Oo][Nn]\W" end="[Gg][Oo][Tt][Oo]"
syn region  tiStatement		start="[Oo][Nn]\W" end="[Ww][Aa][Rr][Nn][Ii][Nn][Gg]"
syn region  tiStatement		start="[Oo][Pp][Tt][Ii][Oo][Nn]\W" end="[Bb][Aa][Ss][Ee]"
syn region  tiStatement		start="[Dd][Ii][Ss][Pp][Ll][Aa][Yy]\W" end="[Uu][Ss][Ii][Nn][Gg]"
syn region  tiStatement		start="[Pp][Rr][Ii][Nn][Tt]\W" end="[Uu][Ss][Ii][Nn][Gg]"
syn region  tiStatement		start="[Ii][Nn][Pp][Uu][Tt]\W" end="[Rr][Ee][Cc]"

" Subroutines
syn keyword tiSub		CHAR CHARPAT CHARSET CLEAR COINC COLOR DELSPRITE ERR GCHAR HCHAR INIT JOYST KEY
syn keyword tiSub		LINK LOAD LOCATE MAGNIFY MOTION PATTERN PEEK POSITION SAY SCREEN SOUND SPGET  
syn keyword tiSub		SPRITE VCHAR VERSION

" Functions
syn keyword tiFunction		ABS ASC COS EOF EXP INT LEN LOG MAX MIN PI POS REC RND SIN SQR TAB TAN VAL
syn region  tiFunction		start="\(chr\|rpt\|seg\|str\)" end="\$"

" Define default highlighting (if an item's highlighting hasn't been set yet)
hi def link tiStatement 	Statement
hi def link tiSub 			Type
hi def link tiFunction 		Special
hi def link tiFileNumber 	Identifier
hi def link tiString 		String
hi def link tiNumber 		Number
hi def link tiOperator 		Operator
hi def link tiComment 		Comment
hi def link tiVar 			Identifier

let b:current_syntax = "tibasic"
