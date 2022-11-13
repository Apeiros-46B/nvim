-- configuration for trailspace module of mini.nvim
-- {{{ imports
-- main
local trailspace = require('mini.trailspace')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
trailspace.setup({
    only_in_normal_buffers = true,
})
-- }}}

-- {{{ custom highlights
local set_hl = vim.api.nvim_set_hl

set_hl(0, 'MiniTrailspace', { fg = colors.orange, strikethrough = true })
-- }}}
