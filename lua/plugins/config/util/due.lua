-- configuration for due.nvim plugin
-- {{{ imports
-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
local config = {
    ft           = '*.norg',
    today_hi     = 'DueToday',
    overdue_hi   = 'Overdue',

    pattern_start = '#time.due ',
    pattern_end = '',

    regex_hi = "\\d*-*\\d\\+-\\d\\+\\( \\d*:\\d*\\( \\a\\a\\)\\?\\)\\?"
}

config.date_pattern = '(%d%d)%-(%d%d)'
config.datetime_pattern = config.date_pattern .. ' (%d+):(%d%d)'
config.datetime12_pattern = config.datetime_pattern .. ' (%a%a)'
config.fulldate_pattern = '(%d%d%d%d)%-' .. config.date_pattern
config.fulldatetime_pattern = '(%d%d%d%d)%-' .. config.datetime_pattern
config.fulldatetime12_pattern = config.fulldatetime_pattern .. ' (%a%a)'

config.use_clock_time = false
config.use_clock_today = false
config.use_seconds = false
config.update_rate = config.use_clock_time and (config.use_seconds and 1000 or 60000) or 0
config.default_due_time = "midnight"

require('due_nvim').setup(config)
-- }}}

-- {{{ custom highlights
local set_hl = vim.api.nvim_set_hl
local hl = {
    DueToday = { fg = colors.purple, bold = true },
    Overdue  = { fg = colors.red,    bold = true },
}
for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}
