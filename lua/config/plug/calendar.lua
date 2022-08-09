-- {{{ imports
-- main
local g = vim.g

-- scheme
local scheme = require('lib.scheme')
local colors = scheme.colors
-- }}}

-- {{{ set values
g.calendar_first_day      = 'monday'
g.calendar_date_endian    = 'little'
g.calendar_date_separator = '/'

g.calendar_date_full_month_name = true
g.calendar_week_number          = true

g.calendar_frame = 'default'
-- }}}

-- {{{ custom highlights
local set_hl = vim.api.nvim_set_hl
local hl = {
    CalendarSelect           = {                    bg = colors.gray3                },
    CalendarDayTitle         = { fg = colors.white, bg = colors.gray3, bold   = true },
    CalendarNormalSpace      = { fg = colors.gray1, bg = colors.white                },

    CalendarToday            = { fg = colors.gray1, bg = colors.teal , bold   = true },
    CalendarTodaySaturday    = { fg = colors.gray1, bg = colors.blue , bold   = true },
    CalendarTodaySunday      = { fg = colors.gray1, bg = colors.green, bold   = true },

    CalendarSaturday         = { fg = colors.blue,  bg = colors.gray3                },
    CalendarSaturdayTitle    = { fg = colors.gray1, bg = colors.blue , bold   = true },

    CalendarSunday           = { fg = colors.green, bg = colors.gray3                },
    CalendarSundayTitle      = { fg = colors.gray1, bg = colors.green, bold   = true },

    CalendarComment          = { fg = colors.gray7,                    italic = true },
    CalendarCommentSelect    = { fg = colors.gray7, bg = colors.gray3, italic = true },

    CalendarOtherMonth       = { fg = colors.gray8                                   },
    CalendarOtherMonthSelect = { fg = colors.gray8, bg = colors.gray3                },
}
for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}
