-- configuration for illuminate plugin
return function(theme)
    -- {{{ imports
    local colors     = theme.colors
    local illuminate = require('illuminate')
    -- }}}

    -- {{{ setup
    illuminate.configure({
        providers = {
            'lsp',
            'treesitter',
            'regex',
        },

        delay = 100,

        filetype_overrides = {},

        -- overrides allowlist
        filetypes_denylist = {
            'fugitive',
            'fugitiveblame',
            'gitcommit',
            'markdown',
            'norg',
            'NvimTree',
            'TelescopePrompt'
        },
        filetypes_allowlist = {},

        -- overrides allowlist
        modes_denylist = {},
        modes_allowlist = {},

        -- only applies to regex provider, overrides allowlist
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},

        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
        min_count_to_highlight = 1,
    })
    -- }}}

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        IlluminatedWordText  = { bg = colors.gray3            },
        IlluminatedWordRead  = { link = 'IlluminatedWordText' },
        IlluminatedWordWrite = { link = 'IlluminatedWordText' },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}
end
