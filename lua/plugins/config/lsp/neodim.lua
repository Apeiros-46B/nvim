-- configuration for neodim plugin
return function(theme)
    -- {{{ imports
    local neodim = require('neodim')
    local colors = theme.colors
    -- }}}

    -- {{{ setup
    neodim.setup({
        alpha = 1.0,
        blend_color = colors.gray2,
        update_in_insert = {
            enable = true,
            delay = 100,
        },
        hide = {
            virtual_text = true,
            signs = true,
            underline = false,
        }
    })
    -- }}}
end
