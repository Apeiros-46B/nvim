-- configuration for trailspace module of mini.nvim
-- {{{ imports
local trailspace = require('mini.trailspace')
-- }}}

-- {{{ setup
trailspace.setup({
    only_in_normal_buffers = true,
})
-- }}}

-- {{{ custom highlights
local theme = require('theme')
local colors = theme.colors

local set_hl = vim.api.nvim_set_hl

set_hl(0, 'MiniTrailspace', { fg = colors.orange, strikethrough = true })
-- }}}
