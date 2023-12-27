-- handle theme loading and custom highlights
-- {{{ module definition and imports
local M = {}
local set_hl = vim.api.nvim_set_hl
-- }}}

-- {{{ load colorscheme
vim.g.everforest_better_performance = 1
vim.g.everforest_background = 'hard'
vim.o.background = 'dark'
vim.cmd([[colorscheme everforest]])
-- }}}

-- {{{ colors
-- TODO: get colors from colorscheme or highlights instead of hardcoding values
M.colors = {
    -- gray
    gray0  = '#282c34',
    gray1  = '#2b3339',
    gray2  = '#323c41',
    gray3  = '#3a454a',
    gray4  = '#445055',
    gray5  = '#53605c',
    gray6  = '#7a8487',
    gray7  = '#859289',
    gray8  = '#9da9a0',

    -- foreground
    white  = '#d3c6aa',

    -- other colors
    red    = '#e67e80',
    orange = '#e69875',
    yellow = '#ddbc7f',
    green  = '#a7c080',
    teal   = '#83c092',
    blue   = '#7fbbb3',
    purple = '#d699b6',

    -- misc
    visual_bg = '#503946',
    diff_del  = '#4e3e43',
    diff_add  = '#404d44',
    diff_mod  = '#394f5a',
    bg_yellow = '#4a4940',

    none = 'none',
}
-- }}}

-- {{{ custom highlights & theme overrides
-- set diagnostic sign icons
for type, icon in pairs({ Error = '', Warn = '', Info = '', Hint = '' }) do
    local name = 'DiagnosticSign' .. type
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = name })
end

-- set highlights
M.hl = {
    -- non-TS highlighting
    String = { link = '@string' },

    NormalFloat = { bg = M.colors.gray2                      }, -- set background for floating windows
    FloatBorder = { bg = M.colors.gray2, fg = M.colors.gray2 }, -- remove border for floating windows
    EndOfBuffer = { bg = M.colors.gray1, fg = M.colors.gray1 }, -- remove tildes from gutter

    -- {{{ diagnostics
    DiagnosticSignError = { fg = M.colors.red    },
    DiagnosticSignWarn  = { fg = M.colors.yellow },
    DiagnosticSignInfo  = { fg = M.colors.green  },
    DiagnosticSignHint  = { fg = M.colors.teal   },

    DiagnosticError = { fg = M.colors.red    },
    DiagnosticWarn  = { fg = M.colors.yellow },
    DiagnosticInfo  = { fg = M.colors.green  },
    DiagnosticHint  = { fg = M.colors.teal   },

    ErrorFloat   = { bg = M.colors.gray2, fg = M.colors.red    },
    WarningFloat = { bg = M.colors.gray2, fg = M.colors.yellow },
    InfoFloat    = { bg = M.colors.gray2, fg = M.colors.green  },
    HintFloat    = { bg = M.colors.gray2, fg = M.colors.teal   },
    -- }}}

    -- search
    Search    = { bg = M.colors.diff_add, fg = M.colors.green, bold = true },
    IncSearch = { bg = M.colors.green   , fg = M.colors.gray1, bold = true },
    CurSearch = { bg = M.colors.green   , fg = M.colors.gray1, bold = true },

    -- window separator
    WinSeparator = { bg = M.colors.gray1, fg = M.colors.gray3 },
}

for k, v in pairs(M.hl) do set_hl(0, k, v) end
-- }}}

-- {{{ return
return M
-- }}}
