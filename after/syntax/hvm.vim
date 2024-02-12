if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "hvm"

syn match   hvmIdFld  '\a\+' contained
syn match   hvmIdSub  '\.\a\+' contained contains=hvmPunct,hvmIdFld,hvmConsNil
syn match   hvmId     '\u\a*\(\.\a\+\)*' contains=hvmIdSub,hvmBuiltin

syn match   hvmNum     '\d\+\(\.\d*\(e\d\+\)\?\)\?'
syn region  hvmStr     start='"' end='"' contains=uiuaEsc
syn keyword hvmConsNil cons Cons nil Nil
syn keyword hvmBuiltin List String HVM contained
syn match   hvmLambda  '[@λ]\s*\a\+'

syn match   hvmOp      '[+\-*/%=<>]'
syn match   hvmPunct   '[.,]'
syn match   hvmComment '//.*$'
syn keyword hvmKeyword let

" {{{ highlight groups
hi def link hvmId      Function
hi def link hvmIdFld   Identifier

hi def link hvmNum     Number
hi def link hvmStr     String
hi def link hvmConsNil Define
hi def link hvmBuiltin Type

hi def link hvmOp      Operator
hi def link hvmLambda  Operator
hi def link hvmPunct   Ignore
hi def link hvmComment Comment
hi def link hvmKeyword Keyword
" }}}
