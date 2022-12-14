-- icon definitions for lspkind
require('lspkind').init({
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- options: 'default', 'codicons'
    preset = 'default',

    symbol_map = {
        Text          = '',
        Method        = '',
        Function      = '',
        Constructor   = '',
        Field         = '',
        Variable      = '',
        Class         = 'ﴯ',
        Interface     = '',
        Module        = '',
        Property      = 'ﰠ',
        Unit          = '',
        Value         = '',
        Enum          = '',
        Keyword       = '',
        Snippet       = '',
        Color         = '',
        File          = '',
        Reference     = '',
        Folder        = '',
        EnumMember    = '',
        Constant      = '',
        Struct        = 'פּ',
        Event         = '',
        Operator      = '',
        TypeParameter = ''
    },
})
