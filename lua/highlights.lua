-- Custom highlights which do not belong to any plugin

local set_hl = vim.api.nvim_set_hl
local scheme = require('lib.scheme')
local colors = scheme.colors

local hl = {
    NormalFloat = { bg = colors.gray3                    },
    FloatBorder = { bg = colors.gray3, fg = colors.gray3 },
}

for k,v in pairs(hl) do set_hl(0, k, v) end
