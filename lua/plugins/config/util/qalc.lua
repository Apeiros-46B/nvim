-- configuration for qalc.nvim plugin
require('qalc').setup({
    cmd_args = {},

    bufname = '',
    set_ft = 'config', -- config ft for nice highlighting
    attach_extension = nil, -- autocommand created during lazy loading

		yank_default_register = '+',

    sign = '=',
    show_sign = true,
    right_align = false,

    highlights = {
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
