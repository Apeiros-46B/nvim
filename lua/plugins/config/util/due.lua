-- configuration for due.nvim plugin
return function(theme)
    -- {{{ imports
    local colors = theme.colors
    -- }}}

    -- {{{ setup
    local date_pat         = '(%d%d)%.(%d%d)'
    local datetime_pat     = date_pat .. ' (%d+):(%d%d)'
    local fulldatetime_pat = '(%d%d%d%d)%.' .. datetime_pat

    require('due_nvim').setup({
        ft           = '*.norg',
        prescript    = '~ ',
        prescript_hi = 'DuePrescript',
        today_hi     = 'DueToday',
        overdue_hi   = 'Overdue',

        pattern_start = '%due ',
        pattern_end   = '',

        date_pattern           = date_pat         .. '%%$',
        datetime_pattern       = datetime_pat     .. '%%$',
        datetime12_pattern     = datetime_pat     .. ' (%a%a)%%$',
        fulldate_pattern       = '(%d%d%d%d)%.'   .. date_pat .. '%%$',
        fulldatetime_pattern   = '(%d%d%d%d)%.'   .. datetime_pat .. '%%$',
        fulldatetime12_pattern = fulldatetime_pat .. ' (%a%a)%%$',

        use_clock_time   = true,
        use_clock_today  = false,
        use_seconds      = false,
        update_rate      = 1000, -- 1 second
        default_due_time = 'midnight',
    })
    -- }}}

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        DuePrescript = { fg = colors.gray7,  bold = true },
        DueToday     = { fg = colors.purple, bold = true },
        Overdue      = { fg = colors.red,    bold = true },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}
end
