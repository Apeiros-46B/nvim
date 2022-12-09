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
        ['a'] = '>',
        ['b'] = ')',
        ['B'] = '}',
        ['r'] = ']',
        ['q'] = { "'", "'", '`' },
        ['s'] = { '}', ']', ')', '>', "'", "'", '`' },
    },
    highlight = {
        duration = 0,
    },
    move_cursor = 'begin',
})
