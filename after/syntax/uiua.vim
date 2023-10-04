if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "uiua"
syn iskeyword a-z,A-Z

syn keyword uiuaIdentifier tag e os family arch ExeExt DllExt sep
syn match   uiuaIdentifier '[a-zA-Z]\+'

" {{{ functions and modifiers
" constants
syn keyword uiuaNoadic eta pi tau inf[inity] rand[om]
syn match   uiuaNoadic '[ηπ∞τ⚂]'

" monadic and dyadic pervasive functions
syn keyword uiuaPervasive not sig[n] abs[olute] sqr[t] sin[e] flo[or] cei[ling] rou[nd] mod[ulus] pow[er] log[arithm] min[imum] max[imum] ata[ngent]
syn match   uiuaPervasive '[¬±`¯⌵√○⌊⌈⁅]\|!=\|<=\|>=\|[=≠<≤>≥+\-×*÷%◿ⁿₙ↧↥∠]'

" monadic array functions
syn keyword uiuaMonadic len[gth] shap[e] rang[e] fir[st] rev[erse] des[hape] bit[s] tra[nspose] gra[de] cla[ssify] ded[uplicate] con[stant] bre[ak] rec[ur] wai[t] pars[e] gen typ[e]
syn match   uiuaMonadic '[⧻△⇡⊢⇌♭⋯⍉⌂⊛⊝□!⎋↬↲]'

" dyadic array functions
syn keyword uiuaDyadic joi[n] cou[ple] mat[ch] pic[k] sel[ect] resh[ape] tak[e] dro[p] rot[ate] win[dows] kee[p] fin[d] mem[ber] ind[exof] ass[ert] dea[l]
syn match   uiuaDyadic '[⊂⊟≅⊡⊏↯↙↘↻◫▽⌕∊⊗⍤]'

" monadic modifiers
syn keyword uiuaMonadicMod dip eac[h] row[s] dis[tribute] tab[le] cro[ss] rep[eat] red[uce] fol[d] sca[n] gro[up] part[ition] inv[ert] bot[h] spa[wn]
syn match   uiuaMonadicMod '[→∵≡∺⊞⊠⍥/∧⊕⊜\\⍘∷↰]'

" dyadic and triadic modifiers
syn keyword uiuaOtherMod lev[el] und[er] fil[e] bin[d] for[k] tri[dent] shar[e] try
syn match   uiuaOtherMod /[⍚⍜⍛'⊃∋⇉⍣?]/
" }}}

" {{{ system functions
" defined in inverse order so precedence for e.g.
" &i and &ime, &s and &sc, etc. is correct

" modules
syn keyword uiuaModuleSF us[e]
syn match   uiuaModuleSF '&i'

syn match   uiuaDyadicSF  '\v\&(rs|rb|ru|w|fwa|ime|ae|tcpsrt|tcpswt)'
syn match   uiuaMonadicSF '\v\&(sl|s|pf|p|var|runi|runc|cd|cl|fo|fc|fe|fld|fif|fras|frab|fwa|imd|ims|ad|ap|ast|tcpl|tcpa|tcpc|tcpsnb|tcpaddr)'
syn match   uiuaNoadicSF  '\v\&(sc|ts|args|n|asr)'
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
hi def link uiuaIdentifier Normal

hi def link uiuaNoadic     Keyword
hi def link uiuaNoadicSF   Keyword
hi def link uiuaPervasive  Operator
hi def link uiuaMonadic    Function
hi def link uiuaMonadicSF  Function
hi def link uiuaDyadic     Identifier
hi def link uiuaDyadicSF   Identifier
hi def link uiuaMonadicMod Type
hi def link uiuaOtherMod   Number
hi def link uiuaModuleSF   Keyword

hi def link uiuaNum        Number
hi def link uiuaEsc        SpecialChar
hi def link uiuaChar       String
hi def link uiuaFmt        Operator
hi def link uiuaStr        String

hi def link uiuaSignature  Type
hi def link uiuaFaded      Comment
hi def link uiuaComment    Comment
" }}}
