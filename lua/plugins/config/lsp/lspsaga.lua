-- configuration for lspsaga plugin
return function(theme)
    -- {{{ imports
    local colors = theme.colors
    local saga   = require('lspsaga')
    -- }}}

    -- {{{ setup
    saga.setup({
        code_action_lightbulb  = { enable = false, },
        ui = {
            theme = 'round',
            -- border type can be single,double,rounded,solid,shadow.
            border = 'solid',
            winblend = 0,
            expand = '',
            collapse = '',
            preview = ' ',
            code_action = '💡',
            diagnostic = '🐞',
            incoming = ' ',
            outgoing = ' ',
            colors = {
                --float window normal background color
                normal_bg = colors.gray2,
                --title background color
                title_bg = colors.gray3,
                red = colors.red,
                magenta = colors.purple,
                orange = colors.orange,
                yellow = colors.yellow,
                green = colors.green,
                cyan = colors.teal,
                blue = colors.blue,
                purple = colors.purple,
                white = colors.white,
                black = colors.gray1,
            },
            kind = {},
        },
        symbol_in_winbar = { enable = false },
    })

    -- for some reason `diagnostic_header_icon` option won't work, so i have to do this:
    local signs = { Error = ' ', Warn = ' ', Info = ' ', Hint = ' ' }
    for type,icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    -- }}}

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        -- code action
        LspSagaCodeActionTitle        = { fg = colors.blue , bold = true   },
        LspSagaCodeActionBorder       = { fg = colors.gray5                },
        LspSagaCodeActionTrunCateLine = { link = 'LspSagaCodeActionBorder' },
        LspSagaCodeActionContent      = { fg = colors.gray7,               },

        -- finder
        LspSagaLspFinderBorder = { fg = colors.gray5                                     },
        LspSagaAutoPreview     = { fg = colors.gray5                                     },
        LspSagaFinderSelection = { fg = colors.blue  ,                       bold = true },
        TargetFileName         = { fg = colors.gray7                                     },
        FinderParam            = { fg = colors.purple, bg = colors.gray2,    bold = true },
        FinderVirtText         = { fg = colors.orange                                    },
        DefinitionsIcon        = { fg = colors.blue  ,                                   },
        Definitions            = { fg = colors.purple,                       bold = true },
        ReferencesIcon         = { fg = colors.blue  ,                                   },
        References             = { fg = colors.purple,                       bold = true },
        DefinitionCount        = { fg = colors.red   ,                       bold = true },
        ReferencesCount        = { fg = colors.red   ,                       bold = true },
        FinderSpinnerBorder    = { fg = colors.blue  ,                                   },
        FinderSpinnerTitle     = { fg = colors.red   ,                       bold = true },
        FinderSpinner          = { fg = colors.red   ,                       bold = true },

        -- definition
        LspSagaDefPreviewBorder = { fg = '#b3deef' },
        DefinitionPreviewTitle = { link = 'Title' },

        -- hover
        LspSagaHoverBorder = { fg = '#f7bb3b' },
        LspSagaHoverTrunCateLine = { link = 'LspSagaHoverBorder' },

        -- rename
        LspSagaRenameBorder = { fg = '#3bb6c4' },
        LspSagaRenameMatch = { link = 'Search' },

        -- diagnostic
        LspSagaDiagnosticSource = { fg = '#FF8700' },
        LspSagaDiagnosticError = { link = 'DiagnosticError' },
        LspSagaDiagnosticWarn = { link = 'DiagnosticWarn' },
        LspSagaDiagnosticInfo = { link = 'DiagnosticInfo' },
        LspSagaDiagnosticHint = { link = 'DiagnosticHint' },
        LspSagaErrorTrunCateLine = { link = 'DiagnosticError' },
        LspSagaWarnTrunCateLine = { link = 'DiagnosticWarn' },
        LspSagaInfoTrunCateLine = { link = 'DiagnosticInfo' },
        LspSagaHintTrunCateLine = { link = 'DiagnosticHint' },
        LspSagaDiagnosticBorder = { fg = colors.purple },
        LspSagaDiagnosticHeader = { fg = '#afd700' },
        LspSagaDiagnosticTruncateLine = { link = 'LspSagaDiagnosticBorder' },

        -- signature help
        LspSagaSignatureHelpBorder = { fg = '#98be65' },
        LspSagaShTrunCateLine = { link = 'LspSagaSignatureHelpBorder' },

        -- lightbulb
        LspSagaLightBulb = { link = 'DiagnosticSignHint' },

        -- shadow
        SagaShadow = { fg = 'black' },

        -- float
        LspSagaBorderTitle = { link = 'String' },

        -- Outline
        LSOutlinePreviewBorder = { fg = '#52ad70' },
        OutlineIndentEvn = { fg = '#c955ae' },
        OutlineIndentOdd = { fg = '#b8733e' },
        OutlineFoldPrefix = { fg = '#bf4537' },
        OutlineDetail = { fg = '#73797e' },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}
end
