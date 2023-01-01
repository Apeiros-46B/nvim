-- TODO: rice noice
return function(theme)
    -- imports
    local colors = theme.colors
    local noice = require('noice')

    noice.setup({
        cmdline = {
            enabled = true,
            view    = 'cmdline_popup',
            opts    = {},
            format = {
                cmdline     = {                  pattern = '^:',              icon = ' ﲵ ', lang = 'vim',   title = '' },
                search_down = { kind = 'search', pattern = '^/',              icon = '  ', lang = 'regex', title = '' },
                search_up   = { kind = 'search', pattern = '^%?',             icon = '  ', lang = 'regex', title = '' },
                filter      = {                  pattern = '^:%s*!',          icon = ' $ ', lang = 'bash',  title = '' },
                lua         = {                  pattern = '^:%s*lua%s+',     icon = '  ', lang = 'lua',   title = '' },
                help        = {                  pattern = '^:%s*he?l?p?%s+', icon = '  ',                 title = '' },
                input       = {                                                                                        },
            },
        },
        messages = {
            enabled      = true,
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
                        { event = 'notify' },
                        { error = true },
                        { warning = true },
                        { event = 'msg_show', kind = { '' } },
                        { event = 'lsp', kind = 'message' },
                    },
                },
            },
            last = {
                view = 'popup',
                opts = { enter = true, format = 'details' },
                filter = {
                    any = {
                        { event = 'notify' },
                        { error = true },
                        { warning = true },
                        { event = 'msg_show', kind = { '' } },
                        { event = 'lsp', kind = 'message' },
                    },
                },
                filter_opts = { count = 1 },
            },
            errors = {
                view = 'popup',
                opts = { enter = true, format = 'details' },
                filter = { error = true },
                filter_opts = { reverse = true },
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
                throttle    = 1000 / 30, -- frequency to update lsp progress message
                view        = 'mini',
            },
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
                ['vim.lsp.util.stylize_markdown']                = false,
                ['cmp.entry.get_documentation']                  = false,
            },
            hover = {
                enabled = true,
                view    = nil,
                opts    = {},
            },
            signature = {
                enabled = true,
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
                    lang = 'markdown',
                    replace = true,
                    render = 'plain',
                    format = { '{message}' },
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
        health = { checker = true },
        smart_move = {
            enabled = true,
            excluded_filetypes = { 'cmp_menu', 'cmp_docs', 'notify' },
        },
        presets = {
            bottom_search         = false,
            command_palette       = false,
            long_message_to_split = false,
            inc_rename            = false,
            lsp_doc_border        = false,
        },
        throttle = 1000 / 30,
        views  = {},
        routes = {},
        status = {},
        format = {},
    })

    local set_hl = vim.api.nvim_set_hl

    local hl = {
        NoiceCmdline                       = { bg = colors.gray2 , fg = colors.white  },
        NoiceCmdlinePopup                  = { bg = colors.gray2 , fg = colors.white  },
        NoiceCmdlinePrompt                 = { bg = colors.gray2 , fg = colors.green  },
        NoiceCmdlinePopupBorder            = { bg = colors.gray2 , fg = colors.gray2  },
        NoiceCmdlinePopupBorderCmdline     = { bg = colors.gray2 , fg = colors.gray2  },
        NoiceCmdlinePopupBorderFilter      = { bg = colors.gray2 , fg = colors.gray2  },
        NoiceCmdlinePopupBorderHelp        = { bg = colors.gray2 , fg = colors.gray2  },
        NoiceCmdlinePopupBorderIncRename   = { bg = colors.gray2 , fg = colors.gray2  },
        NoiceCmdlinePopupBorderInput       = { bg = colors.gray2 , fg = colors.gray2  },
        NoiceCmdlinePopupBorderLua         = { bg = colors.gray2 , fg = colors.gray2  },
        NoiceCmdlinePopupBorderSearch      = { bg = colors.gray2 , fg = colors.gray2  },

        NoiceCmdlineIcon                   = { bg = colors.teal  , fg = colors.gray1  },
        NoiceCmdlineIconCmdline            = { bg = colors.teal  , fg = colors.gray1  },
        NoiceCmdlineIconFilter             = { bg = colors.blue  , fg = colors.gray1  },
        NoiceCmdlineIconHelp               = { bg = colors.yellow, fg = colors.gray1  },
        NoiceCmdlineIconIncRename          = { bg = colors.red   , fg = colors.gray1  },
        NoiceCmdlineIconInput              = { bg = colors.green , fg = colors.gray1  },
        NoiceCmdlineIconLua                = { bg = colors.green , fg = colors.gray1  },
        NoiceCmdlineIconSearch             = { bg = colors.orange, fg = colors.gray1  },

        -- NoiceConfirm                       = { bg = colors.      , fg = colors.       },
        -- NoiceConfirmBorder                 = { bg = colors.      , fg = colors.       },
        -- NoiceCursor                        = { bg = colors.white , fg = colors.gray1  },
        -- NoiceFormatDate                    = { bg = colors.      , fg = colors.       },
        -- NoiceFormatEvent                   = { bg = colors.      , fg = colors.       },
        -- NoiceFormatKind                    = { bg = colors.      , fg = colors.       },
        -- NoiceFormatLevelDebug              = { bg = colors.      , fg = colors.       },
        -- NoiceFormatLevelError              = { bg = colors.      , fg = colors.       },
        -- NoiceFormatLevelInfo               = { bg = colors.      , fg = colors.       },
        -- NoiceFormatLevelOff                = { bg = colors.      , fg = colors.       },
        -- NoiceFormatLevelTrace              = { bg = colors.      , fg = colors.       },
        -- NoiceFormatLevelWarn               = { bg = colors.      , fg = colors.       },
        -- NoiceFormatProgressDone            = { bg = colors.      , fg = colors.       },
        -- NoiceFormatProgressTodo            = { bg = colors.      , fg = colors.       },
        -- NoiceFormatTitle                   = { bg = colors.      , fg = colors.       },
        -- NoiceLspProgressClient             = { bg = colors.      , fg = colors.       },
        -- NoiceLspProgressSpinner            = { bg = colors.      , fg = colors.       },
        -- NoiceLspProgressTitle              = { bg = colors.      , fg = colors.       },
        -- NoiceMini                          = { bg = colors.      , fg = colors.       },
        -- NoicePopup                         = { bg = colors.      , fg = colors.       },
        -- NoicePopupBorder                   = { bg = colors.      , fg = colors.       },
        -- NoicePopupmenu                     = { bg = colors.      , fg = colors.       },
        -- NoicePopupmenuBorder               = { bg = colors.      , fg = colors.       },
        -- NoicePopupmenuMatch                = { bg = colors.      , fg = colors.       },
        -- NoicePopupmenuSelected             = { bg = colors.      , fg = colors.       },
        NoiceScrollbar                     = { bg = colors.gray3 , fg = 'none'        },
        NoiceScrollbarThumb                = { bg = colors.gray4 , fg = 'none'        },
        -- NoiceSplit                         = { bg = colors.      , fg = colors.       },
        -- NoiceSplitBorder                   = { bg = colors.      , fg = colors.       },
        -- NoiceVirtualText                   = { bg = colors.      , fg = colors.       },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
end
