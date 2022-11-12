-- custom highlights excl. plugins
-- {{{ imports
local set_hl = vim.api.nvim_set_hl
local theme = require('theme')
local colors = theme.colors
-- }}}

-- {{{ highlight
local hl = {
    NormalFloat = { bg = colors.gray3                    },
    FloatBorder = { bg = colors.gray3, fg = colors.gray3 },
}

for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}
