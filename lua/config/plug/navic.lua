local navic = require('nvim-navic')
local scheme = require('lib.scheme')
local colors = scheme.colors
local set_hl = vim.api.nvim_set_hl

navic.setup {
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
}

local none = 'NONE'
local hl = {
    NavicIconsFile =          { default = true, bg = none, fg = colors.gray8  },
    NavicIconsModule =        { default = true, bg = none, fg = colors.gray7  },
    NavicIconsNamespace =     { default = true, bg = none, fg = colors.gray7  },
    NavicIconsPackage =       { default = true, bg = none, fg = colors.gray7  },
    NavicIconsClass =         { default = true, bg = none, fg = colors.purple },
    NavicIconsMethod =        { default = true, bg = none, fg = colors.green  },
    NavicIconsProperty =      { default = true, bg = none, fg = colors.green  },
    NavicIconsField =         { default = true, bg = none, fg = colors.orange },
    NavicIconsConstructor =   { default = true, bg = none, fg = colors.green  },
    NavicIconsEnum =          { default = true, bg = none, fg = colors.yellow },
    NavicIconsInterface =     { default = true, bg = none, fg = colors.purple },
    NavicIconsFunction =      { default = true, bg = none, fg = colors.green  },
    NavicIconsVariable =      { default = true, bg = none, fg = colors.blue   },
    NavicIconsConstant =      { default = true, bg = none, fg = colors.red    },
    NavicIconsString =        { default = true, bg = none, fg = colors.teal   },
    NavicIconsNumber =        { default = true, bg = none, fg = colors.yellow },
    NavicIconsBoolean =       { default = true, bg = none, fg = colors.yellow },
    NavicIconsArray =         { default = true, bg = none, fg = colors.gray8  },
    NavicIconsObject =        { default = true, bg = none, fg = colors.purple },
    NavicIconsKey =           { default = true, bg = none, fg = colors.red    },
    NavicIconsNull =          { default = true, bg = none, fg = colors.gray8  },
    NavicIconsEnumMember =    { default = true, bg = none, fg = colors.orange },
    NavicIconsStruct =        { default = true, bg = none, fg = colors.purple },
    NavicIconsEvent =         { default = true, bg = none, fg = colors.red    },
    NavicIconsOperator =      { default = true, bg = none, fg = colors.orange },
    NavicIconsTypeParameter = { default = true, bg = none, fg = colors.green  },
    NavicText =               { default = true, bg = none, fg = colors.gray8  },
    NavicSeparator =          { default = true, bg = none, fg = colors.gray5  },
}

for k,v in pairs(hl) do set_hl(0, k, v) end
