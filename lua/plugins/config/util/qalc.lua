-- configuration for qalc.nvim plugin
require('qalc').setup({
    bufname = 'qalc',
    cmd_args = {},
    set_ft = 'qalc',
    attach_extension = '*.qalc',
    show_sign = true,
    sign = '=',
    right_align = false,

    -- highlight groups
    highlights = {
        number   = '@number',
        operator = '@operator',
        unit     = '@field',
        sign     = '@conceal',
        result   = '@string',
    },

    diagnostics = {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        severity_sort = true,
    }
})
