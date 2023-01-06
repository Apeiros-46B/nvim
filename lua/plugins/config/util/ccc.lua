-- configuration for ccc.nvim plugin
return function(theme)
    -- {{{ imports
    local colors  = theme.colors
    local ccc     = require('ccc')
    local mapping = ccc.mapping
    -- }}}

    -- {{{ setup
    ccc.setup({
        default_color = colors.green,
        bar_char = '━',
        point_char = '🞙',
        point_color = '',
        bar_len = 32,
        win_opts = {
            relative = 'cursor',
            row = 1,
            col = 1,
            style = 'minimal',
            border = 'none',
        },
        auto_close = true,
        preserve = true,
        save_on_quit = false,
        alpha_show = 'auto',
        inputs = {
            ccc.input.rgb,
            ccc.input.hsl,
            ccc.input.cmyk,
        },
        outputs = {
            ccc.output.hex,
            ccc.output.css_rgb,
            ccc.output.css_hsl,
        },
        highlight_mode = 'bg',
        highlighter = {
            auto_enable = true,
        },
        recognize = {
            input = true,
            output = true,
        },
    })
    -- }}}
end
