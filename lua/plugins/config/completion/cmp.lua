-- configuration for cmp completion engine
-- {{{ imports
-- main
local cmp = require('cmp')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ keymaps
local next = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
local prev = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })

local keymaps = {
    ['<Tab>']     = next,
    ['<S-Tab>']   = prev,
    ['<C-n>']     = next,
    ['<C-p>']     = prev,

    ['<C-Space>'] = cmp.mapping.complete(),

    ['<C-k>']     = cmp.mapping.scroll_docs(-1),
    ['<C-j>']     = cmp.mapping.scroll_docs( 1),

    ['<C-e>']     = cmp.mapping.close(),

    ['<CR>']      = cmp.mapping.confirm({
        behavior  = cmp.ConfirmBehavior.Insert,
        select    = true,
    }),
}
-- }}}

-- {{{ setup
cmp.setup({
    -- {{{ disable completion depending on context
    enabled = function()
        -- ignored filetypes
        local ignored = {
            'TelescopePrompt'
        }

        for _, v in pairs(ignored) do
            return v ~= vim.bo.filetype
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
            col_offset = -3,
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
    sources = cmp.config.sources(
        -- higher number = higher priority
        {
            { name = 'neorg', priority = 3 },
            { name = 'ultisnips', priority = 2 },
            { name = 'nvim_lsp', priority = 1 },
        },
        {
            { name = 'path', priority = 2 },
            { name = 'buffer', priority = 1 },
            { name = 'git', priority = 0 },
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
    mapping = keymaps,
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
    CmpItemMenu              = { fg = colors.green,  bg = none                       }, -- plain
    -- }}}

    -- {{{ kinds
    CmpItemKindField         = { fg = colors.gray1,  bg = colors.red   , bold = true },
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
    CmpItemKindEvent         = { fg = colors.gray1,  bg = colors.purple, bold = true },
    CmpItemKindStruct        = { fg = colors.gray1,  bg = colors.purple, bold = true },
    CmpItemKindValue         = { fg = colors.gray1,  bg = colors.purple, bold = true },

    CmpItemKindFile          = { fg = colors.gray1,  bg = colors.white , bold = true },
    CmpItemKindFolder        = { fg = colors.gray1,  bg = colors.white , bold = true },
    CmpItemKindModule        = { fg = colors.gray1,  bg = colors.white , bold = true },

    CmpItemKindText          = { fg = colors.gray1,  bg = colors.gray8 , bold = true },
    -- }}}
}

for k, v in pairs(hl) do set_hl(0, k, v) end
-- }}}
