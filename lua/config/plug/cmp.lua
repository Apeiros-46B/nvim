-- Setup nvim-cmp.
local cmp = require('cmp')
local keymap = require('keymap')

local scheme = require('lib.scheme')
local colors = scheme.colors
local set_hl = vim.api.nvim_set_hl

cmp.setup({
    enabled = function()
        -- disable completion in telescope
        if vim.bo.filetype == "TelescopePrompt" then return false end

        -- disable completion in comments
        local context = require('cmp.config.context')
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture('comment')
               and not context.in_syntax_group('Comment')
        end
    end,
    view = { -- select upwards if cursor is near the bottom
        entries = {name = 'custom', selection_order = 'near_cursor' }
    },
    window = {
        completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            col_offset = -7,
            side_padding = -1,
        },
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            local kind = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, '%s', { trimempty = true })

            kind.kind = ' ' .. strings[1] .. ' '
            kind.menu = '      [' .. strings[2] .. ']'

            return kind
        end,
    },
	snippet = {
		expand = function(args)
			vim.fn['UltiSnips#Anon'](args.body)
		end,
	},
	mapping = keymap.cmp_mappings,
	sources = cmp.config.sources({
            { name = 'nvim_lsp', priority = 1 },
            { name = 'ultisnips' },
        },
        {
            { name = 'buffer' },
            { name = 'path' },
        }
    ),
})

local none = 'NONE'
local hl = {
    -- pmenu
    PmenuThumb               = { bg = colors.gray5,  fg = none          },
    PmenuSbar                = { bg = colors.gray4,  fg = none          },
    PmenuSel                 = { fg = colors.gray1,  bg = colors.green  },
    Pmenu                    = { fg = colors.white,  bg = colors.gray3  },

    -- cmp general
    -- TODO: text formatting, idk why it won't work
    CmpItemAbbrDeprecated    = { fg = colors.gray8,  bg = none          }, -- strikethrough
    CmpItemAbbrMatch         = { fg = colors.green,  bg = none          }, -- bold
    CmpItemAbbrMatchFuzzy    = { fg = colors.green,  bg = none          }, -- bold
    CmpItemMenu              = { fg = colors.green,  bg = none          }, -- italic

    -- kinds
    CmpItemKindField         = { fg = colors.gray1,  bg = colors.red    },
    CmpItemKindEvent         = { fg = colors.gray1,  bg = colors.red    },
    CmpItemKindKeyword       = { fg = colors.gray1,  bg = colors.red    },

    CmpItemKindConstant      = { fg = colors.gray1,  bg = colors.orange },
    CmpItemKindFolder        = { fg = colors.gray1,  bg = colors.orange },
    CmpItemKindOperator      = { fg = colors.gray1,  bg = colors.orange },
    CmpItemKindSnippet       = { fg = colors.gray1,  bg = colors.orange },
    CmpItemKindUnit          = { fg = colors.gray1,  bg = colors.orange },

    CmpItemKindEnum          = { fg = colors.gray1,  bg = colors.yellow },
    CmpItemKindEnumMember    = { fg = colors.gray1,  bg = colors.yellow },
    CmpItemKindReference     = { fg = colors.gray1,  bg = colors.yellow },

    CmpItemKindConstructor   = { fg = colors.gray1,  bg = colors.green  },
    CmpItemKindFunction      = { fg = colors.gray1,  bg = colors.green  },
    CmpItemKindMethod        = { fg = colors.gray1,  bg = colors.green  },
    CmpItemKindProperty      = { fg = colors.gray1,  bg = colors.green  },

    CmpItemKindColor         = { fg = colors.gray1,  bg = colors.teal   },
    CmpItemKindInterface     = { fg = colors.gray1,  bg = colors.teal   },
    CmpItemKindTypeParameter = { fg = colors.gray1,  bg = colors.teal   },

    CmpItemKindVariable      = { fg = colors.gray1,  bg = colors.blue   },

    CmpItemKindClass         = { fg = colors.gray1,  bg = colors.purple },
    CmpItemKindStruct        = { fg = colors.gray1,  bg = colors.purple },
    CmpItemKindValue         = { fg = colors.gray1,  bg = colors.purple },

    CmpItemKindFile          = { fg = colors.gray1,  bg = colors.white  },
    CmpItemKindModule        = { fg = colors.gray1,  bg = colors.white  },

    CmpItemKindText          = { fg = colors.gray1,  bg = colors.gray8  },
}

for k,v in pairs(hl) do set_hl(0, k, v) end
