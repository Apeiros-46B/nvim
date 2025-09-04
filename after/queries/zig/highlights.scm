; TODO: fix the stuff here

; highlight namespaced types (e.g. vk.Extent2D) as types instead of as fields
((identifier) @type
							(#lua-match? @type "^[A-Z_][a-zA-Z0-9_]*")
							(#set! "priority" 110))

; highlight constants as constants instead of as types
((identifier) @constant
							(#lua-match? @constant "^[A-Z][A-Z_0-9]+$")
							(#set! "priority" 120))
