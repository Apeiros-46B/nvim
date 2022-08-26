-- {{{ imports
-- main
local neorg = require('neorg')

-- scheme
local scheme = require('lib.scheme')
local colors = scheme.colors
-- }}}

-- {{{ setup
neorg.setup({
    load = {
        -- {{{ essentials
        ['core.defaults'] = {},
        ['core.integrations.treesitter'] = {},
        -- }}}

        -- {{{ completion
        ['core.norg.completion'] = {
            config = {
                engine = 'nvim-cmp',
            },
        },
        -- }}}

        -- {{{ concealer
        ['core.norg.concealer'] = {
            config = {
                -- {{{ icons
                icons = {
                    -- {{{ todo
                    todo = {
                        enabled = true,

                        done = {
                            enabled = true,
                            icon = '',
                            highlight = 'NeorgTodoItemDoneMark',
                        },

                        pending = {
                            enabled = true,
                            icon = '-',
                            highlight = 'NeorgTodoItemPendingMark',
                        },

                        undone = {
                            -- change back to true for x mark on undone
                            enabled = false,
                            icon = '×',
                            highlight = 'NeorgTodoItemUndoneMark',
                        },

                        uncertain = {
                            enabled = true,
                            icon = '?',
                            highlight = 'NeorgTodoItemUncertainMark',
                        },

                        on_hold = {
                            enabled = true,
                            icon = '',
                            highlight = 'NeorgTodoItemOnHoldMark',
                        },

                        cancelled = {
                            enabled = true,
                            icon = '',
                            highlight = 'NeorgTodoItemCancelledMark',
                        },

                        recurring = {
                            enabled = true,
                            icon = '',
                            highlight = 'NeorgTodoItemRecurringMark',
                        },

                        urgent = {
                            enabled = true,
                            icon = '',
                            highlight = 'NeorgTodoItemUrgentMark',
                        },
                    },
                    -- }}}

                    -- {{{ quote
                    quote = {
                        enabled = true,

                        level_1 = {
                            enabled = true,
                            icon = '┃',
                            highlight = 'NeorgQuote1',
                        },

                        level_2 = {
                            enabled = true,
                            icon = '┃',
                            highlight = 'NeorgQuote2',
                        },

                        level_3 = {
                            enabled = true,
                            icon = '┃',
                            highlight = 'NeorgQuote3',
                        },

                        level_4 = {
                            enabled = true,
                            icon = '┃',
                            highlight = 'NeorgQuote4',
                        },

                        level_5 = {
                            enabled = true,
                            icon = '┃',
                            highlight = 'NeorgQuote5',
                        },

                        level_6 = {
                            enabled = true,
                            icon = '┃',
                            highlight = 'NeorgQuote6',
                        },
                    },
                    -- }}}

                    -- {{{ headings
                    heading = {
                        enabled = true,

                        level_1 = {
                            enabled = true,
                            icon = '◉ ',
                            highlight = 'NeorgHeading1',
                        },

                        level_2 = {
                            enabled = true,
                            icon = ' ◈ ',
                            highlight = 'NeorgHeading2',
                        },

                        level_3 = {
                            enabled = true,
                            icon = '  ▣ ',
                            highlight = 'NeorgHeading3',
                        },

                        level_4 = {
                            enabled = true,
                            icon = '   🞅 ',
                            highlight = 'NeorgHeading4',
                        },

                        level_5 = {
                            enabled = true,
                            icon = '    🮮 ',
                            highlight = 'NeorgHeading5',
                        },

                        level_6 = {
                            enabled = true,
                            icon = '     🞏 ',
                            highlight = 'NeorgHeading6',
                        },
                    },
                    -- }}}

                    -- {{{ others
                    marker = {
                        enabled = true,
                        icon = '',
                        highlight = 'NeorgMarker',
                    },

                    definition = {
                        enabled = true,

                        single = {
                            enabled = true,
                            icon = '≡',
                            highlight = 'NeorgDefinition',
                        },
                        multi_prefix = {
                            enabled = true,
                            icon = '⋙ ',
                            highlight = 'NeorgDefinition',
                        },
                        multi_suffix = {
                            enabled = true,
                            icon = '⋘ ',
                            highlight = 'NeorgDefinitionEnd',
                        },
                    },

                    footnote = {
                        enabled = true,

                        single = {
                            enabled = true,
                            icon = '⁎',
                            highlight = 'NeorgFootnote',
                        },
                        multi_prefix = {
                            enabled = true,
                            icon = '⁑ ',
                            highlight = 'NeorgFootnote',
                        },
                        multi_suffix = {
                            enabled = true,
                            icon = '⁑ ',
                            highlight = 'NeorgFootnoteEnd',
                        },
                    },

                    delimiter = {
                        enabled = true,

                        weak = {
                            enabled = true,
                            icon = '⟨',
                            highlight = 'NeorgWeakParagraphDelimiter',
                        },

                        strong = {
                            enabled = true,
                            icon = '⟪',
                            highlight = 'NeorgStrongParagraphDelimiter',
                        },

                        horizontal_line = {
                            enabled = true,
                            icon = '━',
                            highlight = 'NeorgHorizontalLine',
                        },
                    },

                    markup = {
                        enabled = true,

                        spoiler = {
                            enabled = true,
                            icon = '█',
                            highlight = 'NeorgMarkupSpoiler',
                        },
                    },
                    -- }}}
                },
                -- }}}

                -- {{{ other options
                dim_code_blocks = { enabled = false },
                folds = true,
                -- }}}
            },
        },
        -- }}}

        -- {{{ directory manager
        -- ['core.norg.dirman'] = {
        --     config = {
        --         workspaces = {
        --             school = '~/notes/school',
        --             home   = '~/notes/home',
        --         },
        --     },
        -- },
        -- }}}

        -- {{{ highlights
        ['core.highlights'] = {},
        -- }}}

        -- {{{ indentation
        -- ['core.norg.esupports.indent'] = {
        --     config = {
        --         -- Configuration here
        --     }
        -- },
        -- }}}

        -- {{{ exports
        ['core.export']          = {},
        ['core.export.markdown'] = {
            config = {
                -- extensions = { 'todo-items-basic', 'todo-items-extended', 'definition-lists', 'mathematics' },
                extensions = 'all',
            }
        },
        -- }}}

        -- ['core.presenter'] = {},

        -- {{{ telescope integration
        ['core.integrations.telescope'] = {},
        -- }}}
    }
})
-- }}}

-- {{{ custom highlights
-- i'm not using core.highlights module because
-- 1. it uses vim.cmd which is slower than this approach afaik
-- 2. i want to maintain consistency with my other configs
-- 3. i have no idea how it works, so i'm just gonna stick with this

local set_hl = vim.api.nvim_set_hl

local hl = {
    -- {{{ selection window
    NeorgSelectionWindowHeading       = { fg = colors.purple },
    NeorgSelectionWindowArrow         = { fg = colors.white  },
    NeorgSelectionWindowKey           = { fg = colors.yellow },
    NeorgSelectionWindowKeyname       = { fg = colors.blue   },
    NeorgSelectionWindowNestedkeyname = { fg = colors.teal   },
    -- }}}

    -- {{{ tags
    NeorgTagBegin     = { fg = colors.red    },
    NeorgTagEnd       = { fg = colors.red    },
    NeorgTagName      = { fg = colors.white  },
    NeorgTagNameWord  = { fg = colors.red    },
    NeorgTagParameter = { fg = colors.yellow },

    NeorgCarryoverTagBegin     = { fg = colors.orange },
    NeorgCarryoverTagName      = { fg = colors.white  },
    NeorgCarryoverTagNameWord  = { fg = colors.orange },
    NeorgCarryoverTagParameter = { fg = colors.teal   },
    -- }}}

    -- {{{ headings
    NeorgHeading1Title  = { fg = colors.red   , bold = true },
    NeorgHeading1Prefix = { fg = colors.red   , bold = true },
    NeorgHeading2Title  = { fg = colors.orange, bold = true },
    NeorgHeading2Prefix = { fg = colors.orange, bold = true },
    NeorgHeading3Title  = { fg = colors.yellow, bold = true },
    NeorgHeading3Prefix = { fg = colors.yellow, bold = true },
    NeorgHeading4Title  = { fg = colors.green , bold = true },
    NeorgHeading4Prefix = { fg = colors.green , bold = true },
    NeorgHeading5Title  = { fg = colors.blue  , bold = true },
    NeorgHeading5Prefix = { fg = colors.blue  , bold = true },
    NeorgHeading6Title  = { fg = colors.purple, bold = true },
    NeorgHeading6Prefix = { fg = colors.purple, bold = true },
    -- }}}

    -- {{{ quotes
    NeorgQuote1        = { fg = colors.gray7                 },
    NeorgQuote1Content = { fg = colors.gray7 , italic = true },
    NeorgQuote2        = { fg = colors.gray8                 },
    NeorgQuote2Content = { fg = colors.gray8 , italic = true },
    NeorgQuote3        = { fg = colors.green                 },
    NeorgQuote3Content = { fg = colors.green , italic = true },
    NeorgQuote4        = { fg = colors.teal                  },
    NeorgQuote4Content = { fg = colors.teal  , italic = true },
    NeorgQuote5        = { fg = colors.blue                  },
    NeorgQuote5Content = { fg = colors.blue  , italic = true },
    NeorgQuote6        = { fg = colors.purple                },
    NeorgQuote6Content = { fg = colors.purple, italic = true },
    -- }}}

    -- {{{ links
    NeorgLinkText          = { fg = colors.blue, underline = true },
    NeorgLinkTextDelimiter = { fg = colors.gray7                  },

    NeorgLinkFile          = { fg = colors.purple, underline = true },
    NeorgLinkFileDelimiter = { fg = colors.gray7                    },

    -- {{{ location
    NeorgLinkLocationDelimiter           = { fg = colors.gray7 ,                  },

    NeorgLinkLocationURL                 = { fg = colors.blue  , underline = true },

    NeorgLinkLocationGeneric             = { fg = colors.yellow,                  },
    NeorgLinkLocationGenericPrefix       = { fg = colors.yellow,                  },

    NeorgLinkLocationExternalFile        = { fg = colors.orange,                  },
    NeorgLinkLocationExternalFilePrefix  = { fg = colors.orange,                  },

    NeorgLinkLocationMarker              = { fg = colors.white ,                  },
    NeorgLinkLocationMarkerPrefix        = { fg = colors.orange,                  },

    NeorgLinkLocationDefinition          = { fg = colors.white , bold      = true },
    NeorgLinkLocationDefinitionPrefix    = { fg = colors.gray7 ,                  },

    NeorgLinkLocationFootnote            = { fg = colors.white , bold      = true },
    NeorgLinkLocationFootnotePrefix      = { fg = colors.gray7 ,                  },

    NeorgLinkLocationHeading1            = { fg = colors.red   ,                  },
    NeorgLinkLocationHeading1Prefix      = { fg = colors.red   ,                  },
    NeorgLinkLocationHeading2            = { fg = colors.orange,                  },
    NeorgLinkLocationHeading2Prefix      = { fg = colors.orange,                  },
    NeorgLinkLocationHeading3            = { fg = colors.yellow,                  },
    NeorgLinkLocationHeading3Prefix      = { fg = colors.yellow,                  },
    NeorgLinkLocationHeading4            = { fg = colors.green ,                  },
    NeorgLinkLocationHeading4Prefix      = { fg = colors.green ,                  },
    NeorgLinkLocationHeading5            = { fg = colors.blue  ,                  },
    NeorgLinkLocationHeading5Prefix      = { fg = colors.blue  ,                  },
    NeorgLinkLocationHeading6            = { fg = colors.purple,                  },
    NeorgLinkLocationHeading6Prefix      = { fg = colors.purple,                  },
    -- }}}
    -- }}}

    -- {{{ markup & delimiters
    NeorgMarkupBold                   = { fg = colors.white ,                    bold          = true  },
    NeorgMarkupBoldDelimiter          = { fg = colors.gray7 ,                    bold          = true  },
    NeorgMarkupItalic                 = { fg = colors.white ,                    italic        = true  },
    NeorgMarkupItalicDelimiter        = { fg = colors.gray7 ,                    italic        = true  },
    NeorgMarkupUnderline              = { fg = colors.white ,                    underline     = true  },
    NeorgMarkupUnderlineDelimiter     = { fg = colors.gray7 ,                    underline     = true  },
    NeorgMarkupStrikethrough          = { fg = colors.white ,                    strikethrough = true  },
    NeorgMarkupStrikethroughDelimiter = { fg = colors.gray7 ,                    strikethrough = true  },
    NeorgMarkupSpoiler                = { fg = colors.white , bg = colors.gray2, bold          = false },
    NeorgMarkupSpoilerDelimiter       = { fg = colors.white , bg = colors.white, bold          = true  },
    NeorgMarkupSubscript              = { fg = colors.orange,                    bold          = false },
    NeorgMarkupSubscriptDelimiter     = { fg = colors.gray7 ,                    bold          = true  },
    NeorgMarkupSuperscript            = { fg = colors.purple,                    bold          = false },
    NeorgMarkupSuperscriptDelimiter   = { fg = colors.gray7 ,                    bold          = true  },
    NeorgMarkupMath                   = { fg = colors.blue  , bg = colors.gray2, bold          = false },
    NeorgMarkupMathDelimiter          = { fg = colors.gray7 , bg = colors.gray2, bold          = true  },
    NeorgMarkupVariable               = { fg = colors.teal  , bg = colors.gray2, bold          = false },
    NeorgMarkupVariableDelimiter      = { fg = colors.gray7 , bg = colors.gray2, bold          = true  },
    NeorgMarkupVerbatim               = { fg = colors.green , bg = colors.gray2, bold          = false },
    NeorgMarkupVerbatimDelimiter      = { fg = colors.green , bg = colors.gray2, bold          = true  },
    NeorgMarkupInlineComment          = { fg = colors.gray7 ,                    italic        = true  },
    NeorgMarkupInlineCommentDelimiter = { fg = colors.gray7 ,                    italic        = true  },

    NeorgStrongParagraphDelimiter     = { fg = colors.gray7                                            },
    NeorgWeakParagraphDelimiter       = { fg = colors.gray7                                            },
    NeorgHorizontalLine               = { fg = colors.gray7                                            },
    -- }}}

    -- {{{ misc
    NeorgCodeBlock                  = { bg = colors.gray2 }, -- no idea why this won't work

    NeorgError                      = { fg = colors.red  },
    NeorgEscapeSequence             = { fg = colors.teal },

    NeorgMarker                     = { fg = colors.orange },
    NeorgMarkerTitle                = { fg = colors.white  },

    NeorgDefinition                 = { fg = colors.gray7                },
    NeorgDefinitionEnd              = { fg = colors.gray7                },
    NeorgDefinitionTitle            = { fg = colors.white, bold   = true },
    NeorgDefinitionContent          = { fg = colors.white, italic = true },

    NeorgFootnote                   = { fg = colors.gray7                },
    NeorgFootnoteEnd                = { fg = colors.gray7                },
    NeorgFootnoteTitle              = { fg = colors.white, bold   = true },
    NeorgFootnoteContent            = { fg = colors.white, italic = true },

    NeorgAnchorDeclarationText      = { fg = colors.teal  },
    NeorgAnchorDeclarationDelimiter = { fg = colors.gray7 },
    NeorgAnchorDefinitionDelimiter  = { fg = colors.gray7 },

    NeorgInsertion                  = { fg = colors.white, bold   = true },
    NeorgInsertionPrefix            = { fg = colors.gray7                },
    NeorgInsertionVariable          = { fg = colors.teal                 },
    NeorgInsertionVariableValue     = { fg = colors.gray7                },
    NeorgInsertionItem              = { fg = colors.yellow               },
    NeorgInsertionParameters        = { fg = colors.gray7, italic = true },

    NeorgTrailingModifier           = { fg = colors.gray7 },
    NeorgLinkModifier               = { fg = colors.gray7 },

    NeorgDocumentMetaKey            = { fg = colors.green,  bold = true },
    NeorgDocumentMetaValue          = { fg = colors.white               },
    NeorgDocumentMetaCarryover      = { fg = colors.red                 },
    NeorgDocumentMetaTitle          = { fg = colors.orange, bold = true },
    NeorgDocumentMetaDescription    = { fg = colors.yellow              },
    NeorgDocumentMetaAuthors        = { fg = colors.purple              },
    NeorgDocumentMetaCategories     = { fg = colors.blue                },
    NeorgDocumentMetaCreated        = { fg = colors.blue                },
    NeorgDocumentMetaVersion        = { fg = colors.teal                },
    NeorgDocumentMetaObjectBracket  = { fg = colors.white               },
    NeorgDocumentMetaArrayBracket   = { fg = colors.white               },
    NeorgDocumentMetaArrayValue     = { fg = colors.white               },
    -- }}}
}

-- {{{ repetition is annoying
for i=1,6 do --
    -- {{{ ordered lists
    set_hl(0, 'NeorgOrderedList' .. i, { fg = colors.red,   bold      = true })
    set_hl(0, 'NeorgOrderedLink' .. i, { fg = colors.blue,  underline = true })
    -- }}}

    -- {{{ unordered lists
    set_hl(0, 'NeorgOrderedList' .. i, { fg = colors.gray7, bold      = true })
    set_hl(0, 'NeorgOrderedLink' .. i, { fg = colors.blue,  underline = true })
    -- }}}

    -- {{{ todos
    --                                item                  fg                  strikethrough         italic         bold
    set_hl(0, 'NeorgTodoItem' .. i                      , { fg = colors.gray7 ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'Undone'          , { fg = colors.gray7 ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'UndoneContent'   , { fg = colors.white ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'Pending'         , { fg = colors.yellow,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'PendingContent'  , { fg = colors.white ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'Done'            , { fg = colors.teal  ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'DoneContent'     , { fg = colors.white ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'Cancelled'       , { fg = colors.gray7 ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'CancelledContent', { fg = colors.gray7 , strikethrough = true, italic = true,             })
    set_hl(0, 'NeorgTodoItem' .. i .. 'Urgent'          , { fg = colors.red   ,                                      bold = true })
    set_hl(0, 'NeorgTodoItem' .. i .. 'UrgentContent'   , { fg = colors.red   ,                                      bold = true })
    set_hl(0, 'NeorgTodoItem' .. i .. 'OnHold'          , { fg = colors.blue  ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'OnHoldContent'   , { fg = colors.white ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'Recurring'       , { fg = colors.green ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'RecurringContent', { fg = colors.white ,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'Uncertain'       , { fg = colors.purple,                                                  })
    set_hl(0, 'NeorgTodoItem' .. i .. 'UncertainContent', { fg = colors.white ,                                                  })
    -- }}}
end
-- }}}

-- set highlights
for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}

-- {{{ norg-specific keybinds
local neorg_callbacks = require('neorg.callbacks')

neorg_callbacks.on_event('core.keybinds.events.enable_keybinds', function(_, keybinds)
    -- Map all the below keybinds only when the 'norg' mode is active
    keybinds.map_event_to_mode('norg', {
        n = { -- Bind keys in normal mode
            { '<C-s>', 'core.integrations.telescope.find_linkable' },
        },

        i = { -- Bind in insert mode
            { '<C-k>', 'core.integrations.telescope.insert_link' },
        },
    },
    {
        silent = true,
        noremap = true,
    })
end)
-- }}}
