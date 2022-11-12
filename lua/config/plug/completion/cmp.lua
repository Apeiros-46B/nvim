-- configuration for cmp completion engine
-- {{{ imports
-- main
local cmp = require('cmp')
local keys = require('config.core.keys')

-- theme
local theme = require('theme')
local colors = theme.colors
-- }}}

-- {{{ setup
cmp.setup({
    -- {{{ disable completion depending on context
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
    -- }}}

    -- {{{ formatting and visual options
    view = {
        entries = { name = 'custom', selection_order = 'near_cursor' } -- select upwards if cursor is near the bottom
    },
    window = {
        completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:CmpCompletionBorder,CursorLine:PmenuSel,Search:None',
            col_offset = -4, -- why won't this work?
            side_padding = 0,
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
    -- }}}

    -- {{{ sources
	sources = cmp.config.sources({
            { name = 'nvim_lsp', priority = 1 },
            { name = 'ultisnips' },
        },
        {
            { name = 'buffer' },
            { name = 'path' },
        }
    ),
    -- }}}

    -- {{{ other options
	snippet = {
		expand = function(args)
			vim.fn['UltiSnips#Anon'](args.body)
		end,
	},
    experimental = {
        ghost_text = true,
    },
    completion = {
        keyword_length = 1,
    },
	mapping = keys.cmp_mappings,
    preselect = cmp.PreselectMode.None,
    -- }}}
})
-- }}}

-- {{{ custom highlight
local set_hl = vim.api.nvim_set_hl
local none = 'NONE'
local hl = {
    -- {{{ pmenu
    PmenuThumb               = { bg = colors.gray5,    fg = none              },
    PmenuSbar                = { bg = colors.gray4,    fg = none              },
    PmenuSel                 = { bg = colors.diff_add, fg = none, bold = true }, -- dark green selected item
    Pmenu                    = { bg = colors.gray3,    fg = none              },
    -- }}}

    -- {{{ cmp general
    CmpItemAbbrDeprecated    = { fg = colors.gray8,  bg = none, strikethrough = true }, -- strikethrough
    CmpItemAbbrMatch         = { fg = colors.green,  bg = none, bold          = true }, -- bold
    CmpItemAbbrMatchFuzzy    = { fg = colors.green,  bg = none, bold          = true }, -- bold
    CmpItemMenu              = { fg = colors.green,  bg = none, italic        = true }, -- italic
    -- }}}

    -- {{{ kinds
    CmpItemKindField         = { fg = colors.gray1,  bg = colors.red   , bold = true },
    CmpItemKindEvent         = { fg = colors.gray1,  bg = colors.red   , bold = true },
    CmpItemKindKeyword       = { fg = colors.gray1,  bg = colors.red   , bold = true },

    CmpItemKindConstant      = { fg = colors.gray1,  bg = colors.orange, bold = true },
    CmpItemKindOperator      = { fg = colors.gray1,  bg = colors.orange, bold = true },
    CmpItemKindSnippet       = { fg = colors.gray1,  bg = colors.orange, bold = true },
    CmpItemKindUnit          = { fg = colors.gray1,  bg = colors.orange, bold = true },

    CmpItemKindEnum          = { fg = colors.gray1,  bg = colors.yellow, bold = true },
    CmpItemKindEnumMember    = { fg = colors.gray1,  bg = colors.yellow, bold = true },
    CmpItemKindReference     = { fg = colors.gray1,  bg = colors.yellow, bold = true },

    CmpItemKindConstructor   = { fg = colors.gray1,  bg = colors.green , bold = true },
    CmpItemKindFunction      = { fg = colors.gray1,  bg = colors.green , bold = true },
    CmpItemKindMethod        = { fg = colors.gray1,  bg = colors.green , bold = true },
    CmpItemKindProperty      = { fg = colors.gray1,  bg = colors.green , bold = true },

    CmpItemKindColor         = { fg = colors.gray1,  bg = colors.teal  , bold = true },
    CmpItemKindInterface     = { fg = colors.gray1,  bg = colors.teal  , bold = true },
    CmpItemKindTypeParameter = { fg = colors.gray1,  bg = colors.teal  , bold = true },

    CmpItemKindVariable      = { fg = colors.gray1,  bg = colors.blue  , bold = true },

    CmpItemKindClass         = { fg = colors.gray1,  bg = colors.purple, bold = true },
    CmpItemKindStruct        = { fg = colors.gray1,  bg = colors.purple, bold = true },
    CmpItemKindValue         = { fg = colors.gray1,  bg = colors.purple, bold = true },

    CmpItemKindFile          = { fg = colors.gray1,  bg = colors.white , bold = true },
    CmpItemKindFolder        = { fg = colors.gray1,  bg = colors.white , bold = true },
    CmpItemKindModule        = { fg = colors.gray1,  bg = colors.white , bold = true },

    CmpItemKindText          = { fg = colors.gray1,  bg = colors.gray8 , bold = true },
    -- }}}
}

for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}
