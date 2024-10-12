" Handwritten Uiua syntax highlighting by Apeiros-46B
"
" VERSION: updated 2024.10.11 - for Uiua 0.13.0
" experimental functions are supported
" deprecated functions are unsupported
"
" NOTE: the highlight groups (line 119) are designed around the colorscheme I
" use. this makes it match the Uiua pad well for me, but I haven't tested it
" with other colorschemes. change the target highlights if you have an issue
" with the current ones

if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "uiua"
syn iskeyword a-z,A-Z

" I grouped e, i, NaN, W, MaxInt, True, and False with numeric literals
syn keyword uiuaShadowConst Os Family Arch ExeExt DllExt Sep ThisFile ThisFileName ThisFileDir WorkingDir NumProcs HexDigits Days Months MonthDays LeapMonthDays White Black Red Orange Yellow Green Cyan Blue Purple Magenta Planets Zodiac Suits Cards Chess Moon Skin People Hair Logo Lena Music Lorem Gay Lesbian Bi Trans Pan Ace Aro AroAce Enby Fluid Queer PrideFlags PrideFlagNames
syn match   uiuaIdentifier  '\a\+[‼!]*'

" {{{ functions and modifiers
" triadic (or above) functions
syn keyword uiuaOther audio
syn match   uiuaOther '□\(__[3-9]\|__[0-9]\{2,}\|[₃-₉]\|[₀-₉]\{2,}\)'

" noadic functions
" I grouped tau, eta, pi, and infinity with numeric literals
syn keyword uiuaNoadic rand[om] tag now timezone
syn match   uiuaNoadic '⚂\|□\(__0\+\|₀\+\)' " TODO: make the box one work

" monadic and dyadic pervasive functions
syn keyword uiuaPervasive not sig[n] abs[olute] sqr[t] sin[e] flo[or] cei[ling] rou[nd] add sub[tract] mul[tiply] div[ide] mod[ulus] pow[er] log[arithm] min[imum] max[imum] ata[ngent] com[plex]
syn match   uiuaPervasive '[¬±`¯⌵∿]\|\(!=\|<=\|>=\|[√⌊⌈⁅=≠<≤>≥+\-×*÷%◿ⁿₙ↧↥∠ℂ]\)\(__[0-9]\+\|[₀-₉]\+\)\?'

" monadic non-pervasive functions
syn keyword uiuaMonadic len[gth] sha[pe] ran[ge] fir[st] las[t] rev[erse] des[hape] fix bit[s] tran[spose] ris[e] fal[e] sor[t] whe[re] cla[ssify] ded[uplicate] uni[que] box par[se] wait recv tryrecv type repr csv json xlsx datetime fft graphemes
syn match   uiuaMonadic '[⧻△⇡⊢⊣⇌♭¤⋯⍏⍖⍆⊚⊛◰◴⋕↬]\|utf₈\|□\(__0*1\|₀*₁\)\?\|⍉\(__[0-9]\+\|[₀-₉]\+\)\?'

" dyadic non-pervasive functions
syn keyword uiuaDyadic joi[n] cou[ple] mat[ch] pic[k] sel[ect] res[hape] rer[ank] tak[e] dro[p] rot[ate] win[dows] kee[p] fin[d] mem[berof] ind[exof] ass[ert] mas[k] ori[ent] send regex map has get insert remove img layout gif gen base
syn match   uiuaDyadic '[≍↯▽⌕∊∈⊗⍤⦷]\|□\(__0*2\|₀*₂\)\|[⊏⊡↙↘⊂☇↻⤸◫⊟]\(__[0-9]\+\|[₀-₉]\+\)\?'
" NOTE: legacy member symbol -^ because it's stated in the changelog
" that the memberof symbol will be changed to the old member symbol once
" member is removed

" monadic modifiers
" gap, dip, and identity single-letter spellings aren't accounted for
" 1. it's not very useful since adjacent ones won't be highlighted
" 2. it'll get formatted anyways
syn keyword uiuaMonadicMod gap dip on by wit[h] off eac[h] row[s] tab[le] inv[entory] rep[eat] fol[d] reduce scan gro[up] par[tition] un ant[i] bot[h] con[tent] tup[les] abo[ve] bel[ow] memo quote comptime stringify spawn pool case struct obv[erse]
syn match   uiuaMonadicMod '[⋅⊙⟜⊸⤙⤚⊞⍚∧/\\⊕⊜°⌝◇◠◡⌅]\|[∩≡∵⍥⧅]\(__[0-9]\+\|[₀-₉]\+\)\?'

" non-monadic modifiers
syn keyword uiuaOtherMod sw[itch] do und[er] fil[l] bra[cket] for[k] try astar
syn match   uiuaOtherMod '[⨬⍢⍜⬚⊓⊃⍣]'
" }}}

" {{{ system functions
" defined in inverse order so precedence for e.g.
" &s and &sc, etc. is correct

" modules
syn match   uiuaOtherSF    '\v\&(memcpy)'
syn match   uiuaDyadicSF   '\v\&(runs|rs|rb|ru|w|fwa|tcpsrt|tcpswt|ffi)'
syn match   uiuaMonadicSF  '\v\&(sl|s|pf|p|raw|var|runi|runc|cd|cl|fo|fc|fde|ftr|fe|fld|fif|fras|frab|fwa|fmd|ims|gifs|ap|tlsc|tlsl|tcpl|tcpaddr|tcpa|tcpc|tcpsnb|invk|exit|memfree|camcap)'
syn match   uiuaNoadicSF   '\v\&(clip|sc|ts|args|asr)'
syn match   uiuaModifierSF '&ast'
" }}}

" {{{ literals
" numeric literal and numeric constants
syn keyword uiuaNum eta pi tau inf[inity] e i NaN W MaxInt True False NULL
syn match   uiuaNum '[ηπτ∞]\|[¯`]\?\d\+\(\.\d\+\)\?\(e[¯`]\?\d\+\)\?'

" escape sequence and format placeholder
syn match   uiuaEsc contained /\\\([\\'"_0nrt]\|\\x[0-9a-fA-F]\{2}\|\\u[0-9a-fA-F]\{2}\)/
syn match   uiuaFmt contained '_'

" character literal
syn match   uiuaCharSpace contained ' '
syn match   uiuaChar '@.' contains=uiuaEsc,uiuaCharSpace

" string literal (plain, format, and multiline)
syn region  uiuaStr start='"' end='"' skip='\\"' contains=uiuaEsc
syn region  uiuaStr start='\$"' end='"' skip='\\"' contains=uiuaEsc,uiuaFmt
syn region  uiuaStr start='\$ ' end='$' contains=uiuaEsc,uiuaFmt

" unicode literal
syn match   uiuaUnicodeLiteral '\\\\[0-9a-fA-F]\{,5}'
" }}}

" {{{ misc
" function signatures
syn match   uiuaSignature '|\d\+\(\.\d\+\)\?'

" assignments, stranded arrays, and ' or '' line joining
syn match   uiuaFaded '[←↚_;]\|=\~\|\~'

" modules
syn match   uiuaModPunct contained '---\|┌─╴\|└─╴\|\~'
syn match   uiuaModName contained '\a\+[‼!]*'
syn match   uiuaModBind '^\a\+ \~' contains=uiuaModPunct,uiuaModName
syn match   uiuaModRef '\a\+\~\a\+[‼!]*' contains=uiuaModPunct,uiuaModName
syn match   uiuaModScope '^\(---\|┌─╴\|└─╴\)\(\a\+\( \~\( \a\+[‼!]*\)\+\)\?\)\?$' contains=uiuaModPunct,uiuaModName
syn match   uiuaModImportMember '\~\( \a\+[‼!]*\)\+$' contains=uiuaModPunct,uiuaModName

" debug functions and labels
syn keyword uiuaDebug dump stack trac[e]
syn match   uiuaDebug '⸮\|\$\a\+\|?\(__[0-9]\+\|[₀-₉]\+\)\?'

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
hi def link uiuaTriadic             Operator
hi def link uiuaMonadicMod          Type
hi def link uiuaOtherMod            Number
hi def link uiuaModifierSF          Type

hi def link uiuaNum                 Number
hi def link uiuaEsc                 SpecialChar
hi def link uiuaCharSpace           IncSearch
hi def link uiuaChar                String
hi def link uiuaFmt                 Operator
hi def link uiuaStr                 String
hi def link uiuaUnicodeLiteral      SpecialChar

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
