-- {{{ imports
-- main
local notify = require('notify')

-- scheme
local scheme = require('lib.scheme')
local colors = scheme.colors
-- }}}

-- {{{ setup
notify.setup({
    timeout = 1600,
    stages = 'fade',
    background_color = colors.gray1,
    icons = {
        ERROR = '',
        WARN  = '',
        INFO  = '',
        DEBUG = '',
        TRACE = '✎',
    },
    max_height = 5,
    max_width = 80,
    minimum_width = 16,
    render = 'minimal',
    fps = 75,
})

vim.notify = notify
-- }}}

-- {{{ custom highlight
local set_hl = vim.api.nvim_set_hl

local border = { fg = colors.gray1, bg = 'none' }

local accent = {
    ERROR = { fg = colors.red,    bg = colors.gray2 },
    WARN  = { fg = colors.yellow, bg = colors.gray2 },
    INFO  = { fg = colors.teal,   bg = colors.gray2 },
    DEBUG = { fg = colors.blue,   bg = colors.gray2 },
    TRACE = { fg = colors.purple, bg = colors.gray2 },
}

local normal = {
    ERROR = { fg = colors.orange, bg = colors.gray2 },
    WARN  = { fg = colors.white,  bg = colors.gray2 },
    INFO  = { fg = colors.gray8,  bg = colors.gray2 },
    DEBUG = { fg = colors.gray8,  bg = colors.gray2 },
    TRACE = { fg = colors.gray5,  bg = colors.gray2 },
}

local hl = {
    NotifyERRORBorder = border,
    NotifyERRORIcon   = accent.ERROR,
    NotifyERRORTitle  = accent.ERROR,
    NotifyERRORBody   = normal.ERROR,

    NotifyWARNBorder  = border,
    NotifyWARNIcon    = accent.WARN,
    NotifyWARNTitle   = accent.WARN,
    NotifyWARNBody    = normal.WARN,

    NotifyINFOBorder  = border,
    NotifyINFOIcon    = accent.INFO,
    NotifyINFOTitle   = accent.INFO,
    NotifyINFOBody    = normal.INFO,

    NotifyDEBUGBorder = border,
    NotifyDEBUGIcon   = accent.DEBUG,
    NotifyDEBUGTitle  = accent.DEBUG,
    NotifyDEBUGBody   = normal.DEBUG,

    NotifyTRACEBorder = border,
    NotifyTRACEIcon   = accent.TRACE,
    NotifyTRACETitle  = accent.TRACE,
    NotifyTRACEBody   = normal.TRACE,
}
for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}
