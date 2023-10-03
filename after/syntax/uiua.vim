if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "uiua"
syn iskeyword a-z,A-Z

" {{{ functions and modifiers
" constants
syn keyword uiuaNoadic et[a] pi tau inf[inity] rand[om] tag e os family arch ExeExt DllExt sep
syn match   uiuaNoadic '\v[ηπ∞τ⚂]|\&(sc|ts|args|n|asr|)'

" monadic and dyadic pervasive functions
syn keyword uiuaPervasive not sig[n] ab[solute] sq[rt] sin[e] flo[or] ce[iling] rou[nd] mo[dulus] pow[er] lo[garithm] mi[nimum] max[imum] at[angent]
syn match   uiuaPervasive '[¬±`¯⌵√○⌊⌈⁅]\|!=\|<=\|>=\|[=≠<≤>≥+\-×*÷%◿ⁿₙ↧↥∠]'

" monadic array functions
syn keyword uiuaMonadic len[gth] sh[ape] rang[e] fir[st] rev[erse] des[hape] bit[s] tra[nspose] gra[de] cl[assify] ded[uplicate] con[stant] br[eak] rec[ur] wa[it] pars[e] ge[n] ty[pe]
syn match   uiuaMonadic '\v[⧻△⇡⊢⇌♭⋯⍉⌂⊛⊝□!⎋↬↲]|\&(s|pf|p|var|runi|runc|cd|sl|cl|fo|fc|fe|fld|fif|fras|frab|fwa|imd|ims|ad|ap|ast|tcpl|tcpa|tcpc|tcpsnb|tcpaddr)'

" dyadic array functions
syn keyword uiuaDyadic j[oin] cou[ple] mat[ch] pic[k] se[lect] resh[ape] tak[e] dr[op] rot[ate] wi[ndows] k[eep] fin[d] me[mber] ind[exof] as[sert] dea[l]
syn match   uiuaDyadic '\v[⊂⊟≅⊡⊏↯↙↘↻◫▽⌕∊⊗⍤]|\&(rs|rb|ru|w|fwa|ime|ae|tcpsrt|tcpswt)'

" monadic modifiers
syn keyword uiuaMonadicMod dip ea[ch] row[s] dis[tribute] tab[le] cr[oss] rep[eat] red[uce] fol[d] sc[an] gro[up] part[ition] inv[ert] bo[th] sp[awn]
syn match   uiuaMonadicMod '[→∵≡∺⊞⊠⍥/∧⊕⊜\\⍘∷↰]'

" dyadic and triadic modifiers
" TODO: fork and trident will be deprecated soon, update
syn keyword uiuaDyadicMod lev[el] und[er] fil[e] bin[d] for[k] tri[dent] try
syn match   uiuaDyadicMod /[⍚⍜⍛'⊃∋⍣]/

" modules
syn keyword uiuaModuleFunc us[e]
syn match   uiuaModuleFunc '\&i'
" }}}

" {{{ literals
" numeric literal
syn match   uiuaNum '[¯`]\?\d\+\(\.\d\+\)\?\(e[¯`]\?\d\+\)\?'

" escape sequence and format placeholder
syn match   uiuaEsc contained /\\[\\'"_0nrt]/
syn match   uiuaFmt contained '_'

" character literal
syn match   uiuaChar '@.' contains=uiuaEsc

" string literal (plain, format, and multiline)
syn region  uiuaStr start='"' end='"' skip='\\"' contains=uiuaEsc
syn region  uiuaStr start='\$"' end='"' skip='\\"' contains=uiuaEsc,uiuaFmt
syn region  uiuaStr start='\$ ' end='$' contains=uiuaEsc,uiuaFmt
" }}}

" {{{ misc
" function signatures
syn match   uiuaSignature '|\d\+\(\.\d\+\)\?'

" scopes, debug, <- assignments, and stranded arrays
syn keyword uiuaFaded dum[p]
syn match   uiuaFaded '^---$\|[←~_]'

" comments
syn match   uiuaComment '#.*$'
" }}}

" {{{ highlight groups
hi def link uiuaNoadic     Keyword
hi def link uiuaPervasive  Operator
hi def link uiuaMonadic    Function
hi def link uiuaDyadic     Identifier
hi def link uiuaMonadicMod Type
hi def link uiuaDyadicMod  Number
hi def link uiuaModuleFunc Keyword

hi def link uiuaNum        Number
hi def link uiuaEsc        SpecialChar
hi def link uiuaChar       String
hi def link uiuaFmt        Operator
hi def link uiuaStr        String

hi def link uiuaSignature  Type
hi def link uiuaFaded      Comment
hi def link uiuaComment    Comment
" }}}
