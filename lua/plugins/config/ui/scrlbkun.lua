-- config file for nvim-scrlbkun
-- {{{ imports
-- main
local scrlbkun = require('scrlbkun')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
scrlbkun.setup({
    -- {{{ options
    single_window = true,

    zindex   = 10,
    winblend = 0,

    excluded_filetypes = { 'NvimTree', 'fugitive', 'gitcommit', 'terminal' },
    excluded_buftypes  = { 'prompt' },

    fadeout_time = 0,

    width = 2,
    -- }}}

    -- {{{ components
    -- {{{ bar component
    bar = {
        enable       = true,

        -- drawn in these columns (number between 1 and `width` inclusive)
        draw_columns = { 2 },

        -- drawn on these events
        draw_events     = { 'WinScrolled', 'BufEnter', 'FocusGained' },

        -- drawn on all windows in the current tabpage on these events (same as `draw_events` if `single_window` true)
        draw_events_tab = { 'VimResized', 'TabEnter' },

        -- priority for overlaps
        priority = 100,

        -- sign
        sign = ' ',
    },
    -- }}}

    -- {{{ cursor component
    cursor = {
        enable = true,
        draw_columns = { 2 },

        draw_events     = { 'BufEnter', 'FocusGained', 'CursorMoved' },
        draw_events_tab = { 'VimResized', 'TabEnter' },

        priority = 500,

        signs = {
            '▔',
            '━',
            '▁',
        },
        sign_arrangement = 'skip_first'
    },
    -- }}}

    -- {{{ search component
    search = {
        enable       = true,
        draw_columns = { 2 },

        draw_events     = {},
        draw_events_tab = {
            'TextChanged',
            'TextChangedI',
            'TextChangedP',
            'TabEnter',
            {
                'CmdlineLeave',
                { '/', '\\?', ':' }
            },
            {
                'CmdlineChanged',
                { '/', '\\?' }
            },
        },

        priority = 300,

        signs = {
            '.',
            ':',
        },
        -- true = `signs` field ignored and plugin uses more advanced drawing algorithm for detail
        use_built_in_signs = true,
    },
    -- }}}

    -- {{{ diagnostics component
    diagnostics = {
        enable       = true,
        draw_columns = { 2 },

        draw_events     = {},
        draw_events_tab = { 'BufEnter', 'DiagnosticChanged', 'TabEnter' },

        priority = 500,

        signs = {
            ERROR = { '1', '2', '3', '4' },
            WARN  = { '1', '2', '3', '4' },
            INFO  = { '1', '2', '3', '4' },
            HINT  = { '1', '2', '3', '4' },
        },
        use_built_in_signs = true,
    },
    -- }}}

    -- {{{ githunks component
    githunks = {
        enable       = true,
        draw_columns = { 1 },

        draw_events     = {},
        draw_events_tab = {
            {
                'User',
                'GitSignsUpdate'
            }
        },

        priority = 300,

        -- Signs for githunks.
        signs = {
            add    = { '┃' },
            delete = { '━' },
            change = { '┃' },
        },

        -- The same as that of the search component
        use_built_in_signs = false,
    },
    -- }}}
    -- }}}
})
-- }}}

-- {{{ custom highlights
local set_hl = vim.api.nvim_set_hl

local hl = {
    ScrlbkunBar              = { bg = colors.gray2                      },
    ScrlbkunCursor           = { bg = colors.diff_mod, fg = colors.blue },

    ScrlbkunSearch           = { fg = colors.green },

    ScrlbkunDiagnosticsError = { fg = colors.red    },
    ScrlbkunDiagnosticsWarn  = { fg = colors.yellow },
    ScrlbkunDiagnosticsInfo  = { fg = colors.green  },
    ScrlbkunDiagnosticsHint  = { fg = colors.teal   },

    ScrlbkunGithunksAdd      = { fg = colors.green },
    ScrlbkunGithunksDelete   = { fg = colors.red   },
    ScrlbkunGithunksChange   = { fg = colors.blue  },
}

for k, v in pairs(hl) do set_hl(0, k, v) end
-- }}}
