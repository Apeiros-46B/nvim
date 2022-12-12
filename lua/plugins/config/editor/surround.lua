-- configuration for nvim-surround plugin
require('nvim-surround').setup({
    keymaps = {
        insert          = '<C-s>s',
        insert_line     = '<C-s>S',
        normal          = 'ys',
        normal_cur      = 'yss',
        normal_line     = 'yS',
        normal_cur_line = 'ySS',
        visual          = 'S',
        visual_line     = 'gS',
        delete          = 'ds',
        change          = 'cs',
    },
    aliases = {
        -- {{{ parentheses/brackets
        ['a'] = '>', -- Angle brackets
        ['b'] = ')', -- parentheses
        ['c'] = '}', -- Curly brackets
        ['B'] = ']', -- square Brackets
        -- }}}

        -- {{{ quotes
        ['d'] = '"',               -- Double quotes
        ['s'] = "'",               -- Single quotes
        ['g'] = '`',               -- Grave
        ['q'] = { "'", "'", '`' }, -- Quotes
        -- }}}

        -- {{{ norg
        ['i'] = '/', -- Italic
        ['u'] = '_', -- Underline
        ['x'] = '-', -- Strikethrough
        ['!'] = '|', -- spoiler
        ['m'] = '$', -- Math
        ['C'] = '+', -- inline Comment

        ['M'] = { '*', '/', '_', '|', '`', '^', ',', '$', '=', '+' } -- all Markup
        -- }}}
    },
    highlight = {
        duration = 0,
    },
    move_cursor = 'begin',
})
