-- configuration for nvim-navic plugin
return function(theme)
    -- {{{ imports
    local colors = theme.colors
    local navic  = require('nvim-navic')
    -- }}}

    -- {{{ setup
    navic.setup({
        icons = {
            File          = '󰈙 ',
            Module        = '󰏓 ',
            Namespace     = ' ',
            Package       = '󰅩 ',
            Class         = '󰠱 ',
            Method        = '󰆧 ',
            Property      = '󰜢 ',
            Field         = ' ',
            Constructor   = ' ',
            Enum          = ' ',
            Interface     = ' ',
            Function      = '󰊕 ',
            Variable      = '󰀫 ',
            Constant      = '󰏿 ',
            String        = '󰀬 ',
            Number        = '󰎠 ',
            Boolean       = ' ',
            Array         = '󰅪 ',
            Object        = ' ',
            Key           = '󰌋 ',
            Null          = '󰟢 ',
            EnumMember    = ' ',
            Struct        = '󰙅 ',
            Event         = ' ',
            Operator      = '󰆕 ',
            TypeParameter = '󰊄 ',
        },
        highlight = true,
        separator = '  ',
        depth_limit = 0,
        depth_limit_indicator = '... ',
    })
    -- }}}

    -- {{{ custom highlight
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        -- {{{ kind icons
        NavicIconsField         = { default = true, bg = colors.gray2, fg = colors.red    },
        NavicIconsEvent         = { default = true, bg = colors.gray2, fg = colors.red    },
        NavicIconsKey           = { default = true, bg = colors.gray2, fg = colors.red    },

        NavicIconsConstant      = { default = true, bg = colors.gray2, fg = colors.orange },
        NavicIconsOperator      = { default = true, bg = colors.gray2, fg = colors.orange },

        NavicIconsEnum          = { default = true, bg = colors.gray2, fg = colors.yellow },
        NavicIconsEnumMember    = { default = true, bg = colors.gray2, fg = colors.yellow },

        NavicIconsConstructor   = { default = true, bg = colors.gray2, fg = colors.green  },
        NavicIconsFunction      = { default = true, bg = colors.gray2, fg = colors.green  },
        NavicIconsMethod        = { default = true, bg = colors.gray2, fg = colors.green  },
        NavicIconsProperty      = { default = true, bg = colors.gray2, fg = colors.green  },

        NavicIconsInterface     = { default = true, bg = colors.gray2, fg = colors.teal   },
        NavicIconsTypeParameter = { default = true, bg = colors.gray2, fg = colors.teal   },

        NavicIconsVariable      = { default = true, bg = colors.gray2, fg = colors.blue   },
        NavicIconsObject        = { default = true, bg = colors.gray2, fg = colors.blue   },

        NavicIconsArray         = { default = true, bg = colors.gray2, fg = colors.purple },
        NavicIconsBoolean       = { default = true, bg = colors.gray2, fg = colors.purple },
        NavicIconsClass         = { default = true, bg = colors.gray2, fg = colors.purple },
        NavicIconsNumber        = { default = true, bg = colors.gray2, fg = colors.purple },
        NavicIconsString        = { default = true, bg = colors.gray2, fg = colors.purple },
        NavicIconsStruct        = { default = true, bg = colors.gray2, fg = colors.purple },

        NavicIconsFile          = { default = true, bg = colors.gray2, fg = colors.white  },
        NavicIconsModule        = { default = true, bg = colors.gray2, fg = colors.white  },
        NavicIconsNamespace     = { default = true, bg = colors.gray2, fg = colors.white  },
        NavicIconsPackage       = { default = true, bg = colors.gray2, fg = colors.white  },

        NavicIconsNull          = { default = true, bg = colors.gray2, fg = colors.gray8  },
        -- }}}

        NavicText               = { default = true, bg = colors.gray2, fg = colors.gray8  },
        NavicSeparator          = { default = true, bg = colors.gray2, fg = colors.gray7  },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}
end
