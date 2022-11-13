-- configuration for nvim-navic plugin
-- {{{ imports
-- main
local navic = require('nvim-navic')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
navic.setup({
    icons = {
        File          = " ",
        Module        = " ",
        Namespace     = " ",
        Package       = " ",
        Class         = "ﴯ ",
        Method        = " ",
        Property      = "ﰠ ",
        Field         = " ",
        Constructor   = " ",
        Enum          = " ",
        Interface     = " ",
        Function      = " ",
        Variable      = " ",
        Constant      = " ",
        String        = " ",
        Number        = " ",
        Boolean       = " ",
        Array         = " ",
        Object        = " ",
        Key           = " ",
        Null          = "ﳠ ",
        EnumMember    = " ",
        Struct        = "פּ ",
        Event         = " ",
        Operator      = " ",
        TypeParameter = " ",
    },
    highlight = true,
    separator = "  ",
    depth_limit = 5,
    depth_limit_indicator = "...",
})
-- }}}

-- {{{ custom highlight
local set_hl = vim.api.nvim_set_hl
local hl = {
    NavicIconsField         = { default = true, bg = colors.gray3, fg = colors.red    },
    NavicIconsEvent         = { default = true, bg = colors.gray3, fg = colors.red    },
    NavicIconsKey           = { default = true, bg = colors.gray3, fg = colors.red    },

    NavicIconsConstant      = { default = true, bg = colors.gray3, fg = colors.orange },
    NavicIconsOperator      = { default = true, bg = colors.gray3, fg = colors.orange },

    NavicIconsEnum          = { default = true, bg = colors.gray3, fg = colors.yellow },
    NavicIconsEnumMember    = { default = true, bg = colors.gray3, fg = colors.yellow },

    NavicIconsConstructor   = { default = true, bg = colors.gray3, fg = colors.green  },
    NavicIconsFunction      = { default = true, bg = colors.gray3, fg = colors.green  },
    NavicIconsMethod        = { default = true, bg = colors.gray3, fg = colors.green  },
    NavicIconsProperty      = { default = true, bg = colors.gray3, fg = colors.green  },

    NavicIconsInterface     = { default = true, bg = colors.gray3, fg = colors.teal   },
    NavicIconsTypeParameter = { default = true, bg = colors.gray3, fg = colors.teal   },

    NavicIconsVariable      = { default = true, bg = colors.gray3, fg = colors.blue   },
    NavicIconsObject        = { default = true, bg = colors.gray3, fg = colors.blue   },

    NavicIconsArray         = { default = true, bg = colors.gray3, fg = colors.purple },
    NavicIconsBoolean       = { default = true, bg = colors.gray3, fg = colors.purple },
    NavicIconsClass         = { default = true, bg = colors.gray3, fg = colors.purple },
    NavicIconsNumber        = { default = true, bg = colors.gray3, fg = colors.purple },
    NavicIconsString        = { default = true, bg = colors.gray3, fg = colors.purple },
    NavicIconsStruct        = { default = true, bg = colors.gray3, fg = colors.purple },

    NavicIconsFile          = { default = true, bg = colors.gray3, fg = colors.white  },
    NavicIconsModule        = { default = true, bg = colors.gray3, fg = colors.white  },
    NavicIconsNamespace     = { default = true, bg = colors.gray3, fg = colors.white  },
    NavicIconsPackage       = { default = true, bg = colors.gray3, fg = colors.white  },

    NavicText               = { default = true, bg = colors.gray3, fg = colors.gray8  },
    NavicIconsNull          = { default = true, bg = colors.gray3, fg = colors.gray8  },

    NavicSeparator          = { default = true, bg = colors.gray3, fg = colors.gray5  },
}
for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}
