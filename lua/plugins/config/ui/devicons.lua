-- configuration for nvim-web-devicons plugin
-- {{{ imports
-- main
local devicons = require('nvim-web-devicons')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
devicons.setup({
    color_icons = true,
    default = true,
})
-- }}}

-- {{{ set icons
-- default
devicons.set_default_icon('', colors.white)

-- overrides
devicons.set_icon({
    md = {
        icon = '',
        color = colors.white,
        cterm_color = '7',
        name = 'Markdown',
    },
    norg = {
        icon = '',
        color = colors.red,
        cterm_color = '1',
        name = 'Norg',
    },
    xml = {
        icon = '',
        color = colors.orange,
        cterm_color = '208',
        name = 'XML',
    },
})
-- }}}
