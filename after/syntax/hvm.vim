if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "hvm"

syn match   hvmIdField  '\i\+' contained contains=hvmConsNil,hvmKeyword
syn match   hvmField    '\.\i\+' contained contains=hvmPunct,hvmIdField
syn match   hvmCtr      '\u\i*\(\.\i\+\)*' contains=hvmField,hvmBuiltin

syn match   hvmIdGlobal '\i\+' contained
syn match   hvmIdLambda '\i\+' contained
syn match   hvmGlobal   '\$\i\+' contains=hvmIdGlobal
syn match   hvmLambda   '[@λ]\s*\$\?\i\+' contains=hvmIdLambda,hvmGlobal

syn match   hvmNum      '\d\+\(\.\d*\(e\d\+\)\?\)\?'
syn region  hvmStr      start='"' end='"'
syn keyword hvmConsNil  cons Cons nil Nil
syn keyword hvmBuiltin  List String Both HVM U60 contained

syn match   hvmOp       '[+\-*/%=<>&|^]'
syn match   hvmPunct    '[.,]'
syn match   hvmComment  '//.*$'
syn keyword hvmKeyword  if let swap " technically only 'let' is a keyword

" {{{ highlight groups
hi def link hvmIdField  Identifier
hi def link hvmCtr      Function

hi def link hvmIdGlobal Constant
hi def link hvmIdLambda Define
hi def link hvmGlobal   Ignore
hi def link hvmLambda   Ignore

hi def link hvmNum      Number
hi def link hvmStr      String
hi def link hvmConsNil  Define
hi def link hvmBuiltin  Type

hi def link hvmOp       Operator
hi def link hvmPunct    Ignore
hi def link hvmComment  Comment
hi def link hvmKeyword  Keyword
" }}}
