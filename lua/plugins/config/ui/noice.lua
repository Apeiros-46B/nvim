return function(theme)
    -- imports
    local colors = theme.colors
    local noice = require('noice')

    noice.setup({
        -- {{{ config
        cmdline = {
            enabled = true,
            view    = 'cmdline_popup',
            opts    = {},
            format  = {
                calculator  = {                  pattern = '^=',                        icon = ' % ', lang = 'vim',   title = '' },
                cmdline     = {                  pattern = '^:',                        icon = ' ﲵ ', lang = 'vim',   title = '' },
                filter      = {                  pattern = '^:%s*!',                    icon = ' $ ', lang = 'bash',  title = '' },
                help        = {                  pattern = '^:%s*he?l?p?%s+',           icon = '  ',                 title = '' },
                highlight   = {                  pattern = '^:%s*hig?h?l?i?g?h?t?%s+',  icon = '  ',                 title = '' }, -- custom
                lua         = {                  pattern = '^:%s*lua%s+',               icon = '  ', lang = 'lua',   title = '' },
                luaInspect  = {                  pattern = '^:%s*lua%s*=%s*',           icon = '  ', lang = 'lua',   title = '' }, -- custom
                search_down = { kind = 'search', pattern = '^/',                        icon = '  ', lang = 'regex', title = '' },
                search_up   = { kind = 'search', pattern = '^%?',                       icon = '  ', lang = 'regex', title = '' },
                set         = {                  pattern = '^:%s*set?%s+',              icon = '  ', lang = 'vim',   title = '' }, -- custom

                -- hide ultisnips function triggers
                ultisnips = { view = false, pattern = '^=UltiSnips#.*' },

                -- inc rename
                IncRename = {
                    pattern = '^:%s*IncRename%s+',
                    icon    = '  ',
                    title   = '',
                    opts    = {
                        relative = 'cursor',
                        size     = { min_width = 20 },
                        position = { row = 2, col = 2 },
                    }
                },

                -- input
                input = {},
            },
        },
        messages = {
            enabled      = false,
            view         = 'mini',
            view_error   = 'mini',
            view_warn    = 'mini',
            view_history = 'messages',
            view_search  = false,
        },
        popupmenu = {
            enabled    = true,
            backend    = 'nui',
            kind_icons = {},
        },
        redirect = {
            view   = 'popup',
            filter = { event = 'msg_show' },
        },
        commands = {
            history = {
                view = 'split',
                opts = { enter = true, format = 'details' },
                filter = {
                    any = {
                        { event   = 'notify'                     },
                        { error   = true                         },
                        { warning = true                         },
                        { event   = 'msg_show', kind = { '' }    },
                        { event   = 'lsp',      kind = 'message' },
                    },
                },
            },
            last = {
                view = 'mini',
                opts = { enter = false, format = 'details' },
                filter = {
                    any = {
                        { event   = 'notify'                     },
                        { error   = true                         },
                        { warning = true                         },
                        { event   = 'msg_show', kind = { '' }    },
                        { event   = 'lsp',      kind = 'message' },
                    },
                },
                filter_opts = { count = 1 },
            },
            errors = {
                view        = 'popup',
                opts        = { enter   = true, format = 'details' },
                filter      = { error   = true                     },
                filter_opts = { reverse = true                     },
            },
        },
        notify = {
            enabled = true,
            view    = 'mini',
        },
        lsp = {
            progress = {
                enabled     = true,
                format      = 'lsp_progress',
                format_done = 'lsp_progress_done',
                throttle    = 1000 / 30,
                view        = 'mini_transient',
            },
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown']                = true,
                ['cmp.entry.get_documentation']                  = true,
            },
            hover = {
                enabled = true,
                view    = nil,
                opts    = {},
            },
            signature = {
                enabled   = true,
                auto_open = {
                    enabled  = true,
                    trigger  = true,
                    luasnip  = true,
                    throttle = 50,
                },
                view = nil,
                opts = {},
            },
            message = {
                enabled = true,
                view    = 'mini',
                opts    = {},
            },
            documentation = {
                view = 'hover',
                opts = {
                    lang        = 'markdown',
                    replace     = true,
                    render      = 'plain',
                    format      = { '{message}' },
                    win_options = { concealcursor = 'n', conceallevel = 3 },
                },
            },
        },
        markdown = {
            hover = {
                ['|(%S-)|'         ] = vim.cmd.help,
                ['%[.-%]%((%S-)%)' ] = require('noice.util').open,
            },
            highlights = {
                ['|%S-|'           ] = '@text.reference',
                ['@%S+'            ] = '@parameter',
                ['^%s(Parameters:)'] = '@text.title',
                ['^%s(Return:)'    ] = '@text.title',
                ['^%s(See also:)'  ] = '@text.title',
                ['{%S-}'           ] = '@parameter',
            },
        },
        health     = { checker = true },
        smart_move = {
            enabled            = true,
            excluded_filetypes = { 'cmp_menu', 'cmp_docs', 'notify' },
        },
        presets = {
            bottom_search         = false,
            command_palette       = false,
            long_message_to_split = true,
            inc_rename            = false,
            lsp_doc_border        = false,
        },
        throttle = 1000 / 30,
        routes   = {},
        status   = {},
        -- }}}

        -- {{{ views
        views = {
            -- {{{ mini
            mini = {
                backend   = 'mini',
                relative  = 'editor',
                align     = 'message-right',

                timeout   = 3000,
                reverse   = false,
                focusable = false,

                position  = {
                    row   =   1,
                    col   =   '100%',
                },

                size      = 'auto',
                border    = {
                    style = 'none',
                },

                zindex            = 60,
                win_options       = {
                    winblend      = 0,
                    winhighlight  = {
                        Normal    = 'NoiceMini',
                        IncSearch = 'NoiceMini',
                        Search    = 'NoiceMini',
                    },
                },
            },
            -- }}}

            -- {{{ mini (transient)
            -- in the bottom right instead of top, timeout much shorter
            mini_transient = {
                backend   = 'mini',
                relative  = 'editor',
                align     = 'message-right',

                timeout   = 400,
                reverse   = true,
                focusable = false,

                position  = {
                    row   =   -1,
                    col   =   '100%',
                },

                size      = 'auto',
                border    = {
                    style = 'none',
                },

                zindex            = 20,
                win_options       = {
                    winblend      = 0,
                    winhighlight  = {
                        Normal    = 'NoiceMiniTransient',
                        IncSearch = 'NoiceMiniTransient',
                        Search    = 'NoiceMiniTransient',
                    },
                },
            },
            -- }}}

            -- {{{ command palette
            cmdline_popup = {
                position = {
                    row = 6,
                    col = '50%',
                },
                size = {
                    min_width = 60,
                    width = 'auto',
                    height = 'auto',
                },
            },
            popupmenu = {
                relative = 'editor',
                position = {
                    row = 8,
                    col = '50%',
                },
                size = {
                    width      = 60,
                    height     = 'auto',
                    max_height = 30,
                },
                border = {
                    style   = 'single',
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = 'NoiceCmdlinePopup', FloatBorder = 'NoiceCmdlinePopupBorder' },
                },
            },
            -- }}}
        },
        -- }}}

        -- {{{ formats
        format = {
            debug = { enabled = true },
            cmdline = {},
            level = {
                hl_group = {
                    trace = 'NoiceFormatLevelTrace',
                    debug = 'NoiceFormatLevelDebug',
                    info  = 'NoiceFormatLevelInfo',
                    warn  = 'NoiceFormatLevelWarn',
                    error = 'NoiceFormatLevelError',
                    off   = 'NoiceFormatLevelOff',
                },
                icons = { error = '', warn = '', info = '' },
            },
            progress = {
                contents = {},
                width    = 20,
                align    = 'right',
                key      = 'progress',

                hl_group      = 'NoiceFormatProgressTodo',
                hl_group_done = 'NoiceFormatProgressDone',
            },
            text = {
                text     = nil,
                hl_group = nil,
            },
            spinner = {
                name     = 'dots',
                hl_group = nil,
            },
            data = {
                key      = nil,
                hl_group = nil,
            },
            title = {
                hl_group = 'NoiceFormatTitle',
            },
            event = {
                hl_group = 'NoiceFormatEvent',
            },
            kind = {
                hl_group = 'NoiceFormatKind',
            },
            date = {
                format   = '%X',
                hl_group = 'NoiceFormatDate',
            },
            message = {
                hl_group = nil,
            },
            confirm = {
                hl_group = {
                    choice         = 'NoiceFormatConfirm',
                    default_choice = 'NoiceFormatConfirmDefault',
                },
            },
        }
        -- }}}
    })

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        NoiceCmdline                       = { bg = colors.gray2    , fg = colors.white ,                },
        NoiceCmdlinePopup                  = { bg = colors.gray2    , fg = colors.white ,                },
        NoiceCmdlinePopupBorder            = { bg = colors.gray2    , fg = colors.gray2 ,                },
        NoiceCmdlinePopupBorderSearch      = { bg = colors.gray2    , fg = colors.gray2 ,                },
        NoiceCmdlinePrompt                 = { bg = colors.gray2    , fg = colors.green ,                },

        NoiceCmdlineIcon                   = { bg = colors.teal     , fg = colors.gray1 ,                },
        NoiceCmdlineIconCalculator         = { bg = colors.green    , fg = colors.gray1 ,                },
        NoiceCmdlineIconCmdline            = { bg = colors.teal     , fg = colors.gray1 ,                },
        NoiceCmdlineIconFilter             = { bg = colors.blue     , fg = colors.gray1 ,                },
        NoiceCmdlineIconHelp               = { bg = colors.yellow   , fg = colors.gray1 ,                },
        NoiceCmdlineIconHighlight          = { bg = colors.red      , fg = colors.gray1 ,                }, -- custom
        NoiceCmdlineIconIncRename          = { bg = colors.red      , fg = colors.gray1 ,                },
        NoiceCmdlineIconInput              = { bg = colors.purple   , fg = colors.gray1 ,                },
        NoiceCmdlineIconLua                = { bg = colors.blue     , fg = colors.gray1 ,                },
        NoiceCmdlineIconLuaInspect         = { bg = colors.orange   , fg = colors.gray1 ,                }, -- custom
        NoiceCmdlineIconSearch             = { bg = colors.purple   , fg = colors.gray1 ,                },
        NoiceCmdlineIconSet                = { bg = colors.teal     , fg = colors.gray1 ,                }, -- custom

        NoiceConfirm                       = { bg = colors.gray2    , fg = colors.white ,                },
        NoiceConfirmBorder                 = { bg = colors.gray2    , fg = colors.gray2 ,                },
        NoiceCursor                        = {                                            reverse = true },

        NoiceFormatConfirm                 = { bg = colors.gray2    , fg = colors.white ,                },
        NoiceFormatConfirmDefault          = { bg = colors.diff_del , fg = colors.red   , italic  = true },
        NoiceFormatDate                    = { bg = colors.none     , fg = colors.blue  ,                },
        NoiceFormatEvent                   = { bg = colors.none     , fg = colors.gray7 ,                },
        NoiceFormatKind                    = { bg = colors.gray2    , fg = colors.gray7 ,                },
        NoiceFormatLevelDebug              = { bg = colors.gray2    , fg = colors.teal  ,                },
        NoiceFormatLevelError              = { bg = colors.gray2    , fg = colors.red   ,                },
        NoiceFormatLevelInfo               = { bg = colors.gray2    , fg = colors.green ,                },
        NoiceFormatLevelOff                = { bg = colors.gray2    , fg = colors.gray7 ,                },
        NoiceFormatLevelTrace              = { bg = colors.gray2    , fg = colors.gray7 ,                },
        NoiceFormatLevelWarn               = { bg = colors.gray2    , fg = colors.yellow,                },
        NoiceFormatProgressDone            = { bg = colors.diff_add , fg = colors.white , bold    = true },
        NoiceFormatProgressTodo            = { bg = colors.gray3    , fg = colors.gray7 , bold    = true },
        NoiceFormatTitle                   = { bg = colors.gray2    , fg = colors.green , bold    = true },

        NoiceLspProgressClient             = { bg = colors.gray2    , fg = colors.green ,                },
        NoiceLspProgressSpinner            = { bg = colors.gray2    , fg = colors.blue  ,                },
        NoiceLspProgressTitle              = { bg = colors.gray2    , fg = colors.gray7 ,                },

        NoiceMini                          = { bg = colors.gray2    , fg = colors.white ,                },
        NoiceMiniTransient                 = { bg = colors.gray2    , fg = colors.gray7 ,                },
        NoicePopup                         = { bg = colors.gray2    , fg = colors.white ,                }, -- custom
        NoicePopupBorder                   = { bg = colors.gray2    , fg = colors.gray2 ,                },
        NoicePopupmenu                     = { bg = colors.gray2    , fg = colors.white ,                },
        NoicePopupmenuBorder               = { bg = colors.gray2    , fg = colors.gray2 ,                },
        NoicePopupmenuMatch                = { bg = colors.gray2    , fg = colors.green , bold    = true },
        NoicePopupmenuSelected             = { bg = colors.diff_add , fg = colors.white , bold    = true },
        NoiceScrollbar                     = { bg = colors.gray3    , fg = colors.none  ,                },
        NoiceScrollbarThumb                = { bg = colors.gray4    , fg = colors.none  ,                },

        NoiceSplit                         = { bg = colors.gray1    , fg = colors.white ,                },
        NoiceSplitBorder                   = { bg = colors.gray1    , fg = colors.gray3 ,                },
        NoiceVirtualText                   = { bg = colors.gray1    , fg = colors.gray7 ,                },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}
end
