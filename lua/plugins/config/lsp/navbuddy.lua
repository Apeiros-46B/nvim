-- configuration for nvim-navbuddy plugin
return function(theme)
    -- {{{ imports
    local colors   = theme.colors
    local navbuddy = require('nvim-navbuddy')
    -- }}}

    -- {{{ setup
    navbuddy.setup({
        window = {
            border = 'none',
            scrolloff = 2,
        },
        node_markers = {
            enabled = true,
            icons = {
                leaf = " @ ",
                leaf_selected = " @ ",
                branch = "  ",
            },
        },
        icons = {
            File          = '󰈙 ',
            Module        = '󰏓 ',
            Namespace     = ' ',
            Package       = '󰏓 ',
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
            Object        = '󰅩 ',
            Key           = '󰌋 ',
            Null          = '󰟢 ',
            EnumMember    = ' ',
            Struct        = '󰙅 ',
            Event         = ' ',
            Operator      = '󰆕 ',
            TypeParameter = '󰊄 ',
        },
    })
    -- }}}

    -- {{{ custom highlight
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        -- {{{ kinds
        NavbuddyField         = { fg = colors.red    },
        NavbuddyKeyword       = { fg = colors.red    },

        NavbuddyConstant      = { fg = colors.orange },
        NavbuddyOperator      = { fg = colors.orange },
        NavbuddySnippet       = { fg = colors.orange },
        NavbuddyUnit          = { fg = colors.orange },

        NavbuddyEnum          = { fg = colors.yellow },
        NavbuddyEnumMember    = { fg = colors.yellow },
        NavbuddyReference     = { fg = colors.yellow },

        NavbuddyConstructor   = { fg = colors.green  },
        NavbuddyFunction      = { fg = colors.green  },
        NavbuddyMethod        = { fg = colors.green  },
        NavbuddyProperty      = { fg = colors.green  },

        NavbuddyColor         = { fg = colors.teal   },
        NavbuddyInterface     = { fg = colors.teal   },
        NavbuddyTypeParameter = { fg = colors.teal   },

        NavbuddyKey           = { fg = colors.blue   },
        NavbuddyName          = { fg = colors.blue   },
        NavbuddyVariable      = { fg = colors.blue   },

        NavbuddyArray         = { fg = colors.purple },
        NavbuddyBoolean       = { fg = colors.purple },
        NavbuddyClass         = { fg = colors.purple },
        NavbuddyEvent         = { fg = colors.purple },
        NavbuddyNull          = { fg = colors.purple },
        NavbuddyNumber        = { fg = colors.purple },
        NavbuddyObject        = { fg = colors.purple },
        NavbuddyString        = { fg = colors.purple },
        NavbuddyStruct        = { fg = colors.purple },
        NavbuddyValue         = { fg = colors.purple },

        NavbuddyFile          = { fg = colors.white  },
        NavbuddyFolder        = { fg = colors.white  },
        NavbuddyModule        = { fg = colors.white  },
        NavbuddyPackage       = { fg = colors.white  },
        NavbuddyNamespace     = { fg = colors.white  },

        NavbuddyText          = { fg = colors.gray7  },
        -- }}}
    }

    for k, v in pairs(hl) do
        -- normal highlight
        set_hl(0, k, v)

        -- selected highlight
        v.bg = v.fg
        v.fg = colors.gray1
        v.bold = true

        set_hl(0, k:gsub('Navbuddy', 'NavbuddyCursorLine'), v)
    end
    -- }}}
end
