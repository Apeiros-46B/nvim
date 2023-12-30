-- define a fibonacci function

-- configuration for cmp completion engine
local lspkind_name_map = {
    Text          = 'text',
    Method        = 'method',
    Function      = 'func',
    Constructor   = 'ctor',
    Field         = 'field',
    Variable      = 'var',
    Class         = 'class',
    Interface     = 'trait',
    Module        = 'mod',
    Property      = 'prop',
    Unit          = 'unit',
    Value         = 'val',
    Enum          = 'enum',
    Keyword       = 'keyw',
    Snippet       = 'snip',
    Color         = 'color',
    File          = 'file',
    Reference     = 'ref',
    Folder        = 'dir',
    EnumMember    = 'enumMb',
    Constant      = 'const',
    Struct        = 'struct',
    Event         = 'event',
    Operator      = 'oper',
    TypeParameter = 'type',

    Codeium = 'ai'
}

return function(theme)
    -- {{{ imports
    local colors = theme.colors
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
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
            format = function(entry, item)
                if vim.tbl_contains({ 'path' }, entry.source.name) then
                    -- {{{ path
                    local label = entry:get_completion_item().label

                    local icon = (string.find(label, '/$') and '') or require('nvim-web-devicons').get_icon(entry:get_completion_item().label)

                    if icon then
                        item.kind = ' ' .. icon .. ' '
                        item.kind_hl_group = 'CmpItemKindFile'

                        return item
                    end

                    return lspkind.cmp_format({ with_text = false })(entry, item)
                    -- }}}
                else
                    -- {{{ normal kind
                    item = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, item)
                    local strings = vim.split(item.kind, '%s', { trimempty = true })

                    item.kind = ' ' .. strings[1] .. ' '
                    item.menu = '(' .. lspkind_name_map[strings[2]] .. ')'

                    return item
                    -- }}}
                end
            end,
        },
        -- }}}

        -- {{{ sources
        sources = cmp.config.sources(
            -- higher number = higher priority
            {
                { name = 'codeium', priority = 3 },
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

    -- {{{ autopairs hook
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
    )
    -- }}}
    -- }}}

    -- {{{ custom highlight
    local set_hl = vim.api.nvim_set_hl
    local none = 'NONE'

    local hl = {
        -- {{{ pmenu
        PmenuThumb               = { bg = colors.gray4,    fg = none              },
        PmenuSbar                = { bg = colors.gray3,    fg = none              },
        PmenuSel                 = { bg = colors.diff_add, fg = none, bold = true }, -- faint green bg on selected item
        Pmenu                    = { bg = colors.gray2,    fg = none              },
        -- }}}

        -- {{{ cmp general
        CmpItemAbbrDeprecated    = { fg = colors.gray7, bg = none, strikethrough = true }, -- strikethrough
        CmpItemAbbrMatch         = { fg = colors.green, bg = none, bold          = true }, -- bold
        CmpItemAbbrMatchFuzzy    = { fg = colors.green, bg = none, bold          = true }, -- bold
        CmpItemMenu              = { fg = colors.green, bg = none                       }, -- plain
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
        CmpItemKindCodeium       = { fg = colors.gray1,  bg = colors.purple, bold = true },
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
end
