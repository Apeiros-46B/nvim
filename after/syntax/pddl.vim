if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "pddl"
syn iskeyword a-z,:

syn match pddlMark '?' contained
syn match pddlObj '?[a-zA-Z0-9_-]\+\|[A-Z]' contains=pddlMark
syn match pddlPred '[a-z0-9_-]\+'
syn match pddlType '[A-Z][a-zA-Z0-9_-]\+'
syn match pddlReq ':[a-z\-]\+'

syn keyword pddlKw define problem domain stream :requirements :domain :init :objects :goal :predicates :action :parameters :precondition :effect :derived :stream :inputs :outputs :fluents :certified
syn keyword pddlOp and or not
syn match pddlOp '[=]'

syn keyword pddlQuantif exists forall

syn match pddlComment ';.*$'

hi def link pddlMark Conceal
hi def link pddlObj @variable
hi def link pddlPred @function
hi def link pddlType @type
hi def link pddlReq @module
hi def link pddlKw @keyword
hi def link pddlOp @keyword.operator
hi def link pddlQuantif @constant.macro
hi def link pddlComment @comment
