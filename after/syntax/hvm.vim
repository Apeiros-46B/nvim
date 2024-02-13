if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "hvm"

syn match   hvmIdRaw   '\i\+' contained contains=hvmConsNil,hvmKeyword
syn match   hvmIdFld   '\.\i\+' contained contains=hvmPunct,hvmIdRaw
syn match   hvmId      '\u\i*\(\.\i\+\)*' contains=hvmIdFld,hvmBuiltin
syn match   hvmLambda  '[@λ]\s*\i\+' contains=hvmIdRaw

syn match   hvmNum     '\d\+\(\.\d*\(e\d\+\)\?\)\?'
syn region  hvmStr     start='"' end='"'
syn keyword hvmConsNil cons Cons nil Nil contained
syn keyword hvmBuiltin List String Both HVM U60 contained

syn match   hvmOp      '[+\-*/%=<>&|^]'
syn match   hvmPunct   '[.,]'
syn match   hvmComment '//.*$'
syn keyword hvmKeyword if let swap

" {{{ highlight groups
hi def link hvmIdRaw   Define
hi def link hvmIdFld   Identifier
hi def link hvmId      Function
hi def link hvmLambda  Ignore

hi def link hvmNum     Number
hi def link hvmStr     String
hi def link hvmConsNil Define
hi def link hvmBuiltin Type

hi def link hvmOp      Operator
hi def link hvmPunct   Ignore
hi def link hvmComment Comment
hi def link hvmKeyword Keyword
" }}}
