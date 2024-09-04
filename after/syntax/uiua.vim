" uiua 0.13.0
" experimental functions supported
" deprecated functions unsupported

if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "uiua"
syn iskeyword a-z,A-Z,₀,₁,₂,₃,₄,₅,₆,₇,₈,₉

syn keyword uiuaShadowConst e i NaN W MaxInt Os Family Arch ExeExt DllExt Sep ThisFile ThisFileName ThisFileDir WorkingDir NumProcs True False NULL HexDigits Days Months MonthDays LeapMonthDays Planets Zodiac Suits Cards Chess Moon Skin People Hair Logo Lena Music
syn match   uiuaIdentifier  '\(utf₈\)\@!\a\+\(__[0-9]\+\|[₀₁₂₃₄₅₆₇₈₉]\+\)\?[‼!]*'

" {{{ functions and modifiers
" constants
syn keyword uiuaConst eta pi tau inf[inity]
syn match   uiuaConst '[ηπτ∞]'

syn keyword uiuaNoadic rand[om] tag now
syn match   uiuaNoadic '[⚂]'

" monadic and dyadic pervasive functions
syn keyword uiuaPervasive not sig[n] abs[olute] sqr[t] sin[e] flo[or] cei[ling] rou[nd] add subtract multiply divide mod[ulus] pow[er] log[arithm] min[imum] max[imum] ata[ngent] com[plex]
syn match   uiuaPervasive '[¬±`¯⌵√∿⌊⌈⁅]\|!=\|<=\|>=\|[=≠<≤>≥+\-×*÷%◿ⁿₙ↧↥∠ℂ]'

" monadic non-pervasive functions
syn keyword uiuaMonadic len[gth] sha[pe] rang[e] fir[st] rev[erse] des[hape] fix bit[s] tran[spose] ris[e] fal[e] whe[re] cla[ssify] ded[uplicate] uni[que] box par[se] wait recv tryrecv gen utf₈ type repr csv json xlsx datetime fft
syn match   uiuaMonadic '[⧻△⇡⊢⇌♭¤⋯⍉⍏⍖⊚⊛◰◴□⋕↬]'

" dyadic non-pervasive functions
syn keyword uiuaDyadic joi[n] cou[ple] mat[ch] pic[k] sel[ect] res[hape] rer[ank] tak[e] dro[p] rot[ate] win[dows] chu[nks] kee[p] fin[d] mem[berof] ind[exof] ass[ert] mas[k] ori[ent] send regex map has get insert remove img gif choose permute
syn match   uiuaDyadic '[⊂⊟≍⊡⊏↯☇↙↘↻◫⑄▽⌕∊∈⊗⍤⦷⮌]'
" NOTE: legacy member symbol is kept --^ because it's stated in the changelog
" that the memberof symbol will be changed to the old member symbol once
" member is removed

" triadic (or above) functions
syn keyword uiuaTriadic audio

" monadic modifiers
" gap, dip, and identity single-letter spellings aren't accounted for
" 1. it's not very useful since adjacent ones won't be highlighted
" 2. it'll get formatted anyways
syn keyword uiuaMonadicMod gap dip on by but wit[h] eac[h] row[s] tab[le] inv[entory] rep[eat] fol[d] reduce scan gro[up] par[tition] un bot[h] con[tent] tri[angle] abo[ve] bel[ow] memo quote comptime stringify spawn pool case  struct
syn match   uiuaMonadicMod '[⋅⊙⟜⊸⤙⤚∵≡⊞⍚⍥∧/\\⊕⊜°∩◇◹◠◡]'

" non-monadic modifiers
syn keyword uiuaOtherMod sw[itch] do und[er] fil[l] bra[cket] for[k] try setinv setund astar
syn match   uiuaOtherMod '[⨬⍢⍜⬚⊓⊃⍣]'
" }}}

" {{{ system functions
" defined in inverse order so precedence for e.g.
" &clset and &cl, &s and &sc, etc. is correct

" modules
syn match   uiuaOtherSF    '\v\&(memcpy)'
syn match   uiuaDyadicSF   '\v\&(runs|rs|rb|ru|w|fwa|tcpsrt|tcpswt|ffi)'
syn match   uiuaMonadicSF  '\v\&(sl|s|pf|p|raw|var|runi|runc|clset|cd|cl|fo|fc|fde|ftr|fe|fld|fif|fras|frab|fwa|fmd|ims|gifs|ap|tlsc|tlsl|tcpl|tcpaddr|tcpa|tcpc|tcpsnb|invk|exit|memfree|camcap)'
syn match   uiuaNoadicSF   '\v\&(clget|sc|ts|args|asr)'
syn match   uiuaModifierSF '&ast'
" }}}

" {{{ literals
" numeric literal
syn match   uiuaNum 'NaN\|[¯`]\?\d\+\(\.\d\+\)\?\(e[¯`]\?\d\+\)\?'

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

" assignments, stranded arrays, and ' or '' line joining
syn match   uiuaFaded '[←↚_']\|=\~\|\~'

" modules
syn match   uiuaModPunct contained '---\|\~'
syn match   uiuaModName contained '\a\+[‼!]*'
syn match   uiuaModBind '^\a\+ \~' contains=uiuaModPunct,uiuaModName
syn match   uiuaModRef '\a\+\~\a\+[‼!]*' contains=uiuaModPunct,uiuaModName
syn match   uiuaModScope '^---\(\a\+\( \~\( \a\+[‼!]*\)\+\)\?\)\?$' contains=uiuaModPunct,uiuaModName
syn match   uiuaModImportMember '\~\( \a\+[‼!]*\)\+$' contains=uiuaModPunct,uiuaModName

" debug functions and labels
syn keyword uiuaDebug dump stack trac[e]
syn match   uiuaDebug '\([⸮?]\|\$\a\+\)'

" operand functions and array macro assignments
syn match   uiuaMacroSpecial '\(\^[!:.,]\|[←↚]^\)'

" comments
syn match   uiuaSemanticComment contained 'Track caller!\|Experimental!'
syn match   uiuaSignatureComment contained '\(\a\+ \)*?\( \a\+\)\+'
syn region  uiuaComment start='#' end='$' contains=uiuaSemanticComment,uiuaSignatureComment
" }}}

" {{{ highlight groups
hi def link uiuaShadowConst         Number
hi def link uiuaConst               Operator
hi def link uiuaNoadic              Keyword
hi def link uiuaNoadicSF            Keyword
hi def link uiuaPervasive           Operator
hi def link uiuaMonadic             Function
hi def link uiuaMonadicSF           Function
hi def link uiuaDyadic              Identifier
hi def link uiuaDyadicSF            Identifier
hi def link uiuaTriadic             Function " TODO: more unique highlight
hi def link uiuaMonadicMod          Type
hi def link uiuaOtherMod            Number
hi def link uiuaModifierSF          Type

hi def link uiuaNum                 Number
hi def link uiuaEsc                 SpecialChar
hi def link uiuaChar                String
hi def link uiuaFmt                 Operator
hi def link uiuaStr                 String

hi def link uiuaSignature           Type
hi def link uiuaFaded               Comment
hi def link uiuaModPunct            Comment
hi def link uiuaModName             Keyword
hi def link uiuaModBind             Keyword
hi def link uiuaModRef              Keyword
hi def link uiuaModScope            Keyword
hi def link uiuaModImportMember     Keyword
hi def link uiuaDebug               Operator
hi def link uiuaMacroSpecial        Keyword
hi def link uiuaSemanticComment     Keyword
hi def link uiuaSignatureComment    Number
hi def link uiuaComment             Comment
" }}}
