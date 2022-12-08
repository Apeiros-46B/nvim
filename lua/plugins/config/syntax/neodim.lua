-- configuration for neodim
-- {{{ imports
-- main
local neodim = require('neodim')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
neodim.setup({
    alpha = 0.8,
    blend_color = colors.gray3,
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
