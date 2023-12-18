-- config file for indent-blankline
return function(theme)
    -- {{{ imports
    local colors = theme.colors
    local ibl = require('ibl')
    -- }}}

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        IblIndent = { fg = colors.gray2 },
        IblScope  = { fg = colors.gray5 },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}

    -- {{{ setup
    ibl.setup({
        debounce = 200,
        indent = {
            char = '│',
            highlight = 'IblIndent',
        },
        scope = {
            char = '│',
            show_start = false,
            show_end = false,
            highlight = 'IblScope',
        },
        exclude = {
            filetypes = {
                -- defaults
                'lspinfo',
                'packer',
                'checkhealth',
                'help',
                'man',
                'gitcommit',
                'TelescopePrompt',
                'TelescopeResults',
                '',

                -- venn.nvim files
                'venn',
            },
        },
    })
    -- }}}
end
