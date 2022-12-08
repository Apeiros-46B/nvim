-- configuration for neorg plugin
-- {{{ imports
-- main
local neorg = require('neorg')
local api   = vim.api

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
neorg.setup({
    load = {
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
                            -- icon = '   🞅 ',
                            icon = '   ◉ ',
                            highlight = 'NeorgHeading4',
                        },

                        level_5 = {
                            enabled = true,
                            -- icon = '    🮮 ',
                            icon = '    ◈ ',
                            highlight = 'NeorgHeading5',
                        },

                        level_6 = {
                            enabled = true,
                            -- icon = '     🞏 ',
                            icon = '     ▣ ',
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
                            icon = '',
                            highlight = 'NeorgDefinition',
                        },
                        multi_prefix = {
                            enabled = true,
                            icon = '->',
                            highlight = 'NeorgDefinition',
                        },
                        multi_suffix = {
                            enabled = true,
                            icon = '<-',
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
                dim_code_blocks = {
                    conceal = true,
                    content_only = false,
                    enabled = true,
                    padding = { left = 0, right = 1 },
                    width = 'content',
                },
                folds = true,
                -- }}}
            },
        },
        -- }}}

        -- {{{ directory manager
        ['core.norg.dirman'] = {
            config = {
                workspaces = {
                    school = '~/org/school',
                    home   = '~/org/home',
                    gtd    = '~/org/gtd'
                },
            },
        },
        -- }}}

        -- {{{ essentials
        ['core.defaults'] = {},
        ['core.integrations.treesitter'] = {},
        -- }}}

        -- {{{ exports
        ['core.export']          = {},
        ['core.export.markdown'] = {
            config = {
                extensions = 'all',
            }
        },
        -- }}}

        -- {{{ gtd
        ["core.gtd.base"] = {
            config = {
                workspace = 'gtd',
            }
        },
        -- }}}

        -- {{{ telescope integration
        ['core.integrations.telescope'] = {},
        -- }}}

        ['core.itero'] = {},
        ['core.promo'] = {},
    }
})
-- }}}

-- {{{ custom highlights
-- import
local set_hl = api.nvim_set_hl

local hl = {
    -- {{{ selection window
    ['@neorg.selection_window.arrow'        ] = { fg = colors.white  },
    ['@neorg.selection_window.heading'      ] = { fg = colors.purple },
    ['@neorg.selection_window.key'          ] = { fg = colors.yellow },
    ['@neorg.selection_window.keyname'      ] = { fg = colors.blue   },
    ['@neorg.selection_window.nestedkeyname'] = { fg = colors.teal   },
    -- }}}

    -- {{{ tags
    ['@neorg.tags.ranged_verbatim.begin'         ] = { fg = colors.purple },
    ['@neorg.tags.ranged_verbatim.code_block'    ] = { bg = colors.gray2  },
    ['@neorg.tags.ranged_verbatim.end'           ] = { fg = colors.purple },
    ['@neorg.tags.ranged_verbatim.parameters'    ] = { fg = colors.blue   },

    ['@neorg.tags.ranged_verbatim.name'          ] = { fg = colors.purple },
    ['@neorg.tags.ranged_verbatim.name.delimiter'] = { fg = colors.gray7  },
    ['@neorg.tags.ranged_verbatim.name.word'     ] = { fg = colors.purple },

    -- {{{ document meta
    ['@neorg.tags.ranged_verbatim.document_meta.authors'       ] = { fg = colors.green               },
    ['@neorg.tags.ranged_verbatim.document_meta.description'   ] = { fg = colors.orange              },
    ['@neorg.tags.ranged_verbatim.document_meta.title'         ] = { fg = colors.red,    bold = true },

    ['@neorg.tags.ranged_verbatim.document_meta.categories'    ] = { fg = colors.green               },
    ['@neorg.tags.ranged_verbatim.document_meta.created'       ] = { fg = colors.teal                },
    ['@neorg.tags.ranged_verbatim.document_meta.updated'       ] = { fg = colors.teal                },
    ['@neorg.tags.ranged_verbatim.document_meta.version'       ] = { fg = colors.blue                },

    ['@neorg.tags.ranged_verbatim.document_meta.array.bracket' ] = { fg = colors.white               },
    ['@neorg.tags.ranged_verbatim.document_meta.array.value'   ] = { fg = colors.white               },
    ['@neorg.tags.ranged_verbatim.document_meta.object.bracket'] = { fg = colors.white               },
    ['@neorg.tags.ranged_verbatim.document_meta.trailing'      ] = { fg = colors.white               },

    ['@neorg.tags.ranged_verbatim.document_meta.key'           ] = { fg = colors.yellow, bold = true },
    ['@neorg.tags.ranged_verbatim.document_meta.value'         ] = { fg = colors.green               },
    -- }}}

    ['@neorg.tags.carryover.begin'         ] = { fg = colors.orange },
    ['@neorg.tags.carryover.parameters'    ] = { fg = colors.blue   },

    ['@neorg.tags.carryover.name'          ] = { fg = colors.orange },
    ['@neorg.tags.carryover.name.delimiter'] = { fg = colors.gray7  },
    ['@neorg.tags.carryover.name.word'     ] = { fg = colors.orange },
    -- }}}

    -- {{{ headings
    ['@neorg.headings.1.title' ] = { fg = colors.red   , bold = true },
    ['@neorg.headings.1.prefix'] = { fg = colors.red   , bold = true },
    ['@neorg.headings.2.title' ] = { fg = colors.orange, bold = true },
    ['@neorg.headings.2.prefix'] = { fg = colors.orange, bold = true },
    ['@neorg.headings.3.title' ] = { fg = colors.yellow, bold = true },
    ['@neorg.headings.3.prefix'] = { fg = colors.yellow, bold = true },
    ['@neorg.headings.4.title' ] = { fg = colors.green , bold = true },
    ['@neorg.headings.4.prefix'] = { fg = colors.green , bold = true },
    ['@neorg.headings.5.title' ] = { fg = colors.blue  , bold = true },
    ['@neorg.headings.5.prefix'] = { fg = colors.blue  , bold = true },
    ['@neorg.headings.6.title' ] = { fg = colors.purple, bold = true },
    ['@neorg.headings.6.prefix'] = { fg = colors.purple, bold = true },
    -- }}}

    -- {{{ quotes
    ['@neorg.quotes.1.prefix' ] = { fg = colors.gray7                },
    ['@neorg.quotes.1.content'] = { fg = colors.gray7, italic = true },
    ['@neorg.quotes.2.prefix' ] = { fg = colors.gray7                },
    ['@neorg.quotes.2.content'] = { fg = colors.gray7, italic = true },
    ['@neorg.quotes.3.prefix' ] = { fg = colors.gray8                },
    ['@neorg.quotes.3.content'] = { fg = colors.gray8, italic = true },
    ['@neorg.quotes.4.prefix' ] = { fg = colors.gray8                },
    ['@neorg.quotes.4.content'] = { fg = colors.gray8, italic = true },
    ['@neorg.quotes.5.prefix' ] = { fg = colors.gray9                },
    ['@neorg.quotes.5.content'] = { fg = colors.gray9, italic = true },
    ['@neorg.quotes.6.prefix' ] = { fg = colors.gray9                },
    ['@neorg.quotes.6.content'] = { fg = colors.gray9, italic = true },
    -- }}}

    -- {{{ links
    ['@neorg.links.description'          ] = { fg = colors.green },
    ['@neorg.links.description.delimiter'] = { fg = colors.gray7 },

    ['@neorg.links.file'          ] = { fg = colors.purple, underline = true },
    ['@neorg.links.file.delimiter'] = { fg = colors.gray7                    },

    -- {{{ location
    ['@neorg.links.location.definition'          ] = { fg = colors.white , bold      = true },
    ['@neorg.links.location.definition.prefix'   ] = { fg = colors.gray7                    },
    ['@neorg.links.location.delimiter'           ] = { fg = colors.gray7                    },
    ['@neorg.links.location.external_file'       ] = { fg = colors.orange                   },
    ['@neorg.links.location.external_file.prefix'] = { fg = colors.orange                   },
    ['@neorg.links.location.footnote'            ] = { fg = colors.white , bold      = true },
    ['@neorg.links.location.footnote.prefix'     ] = { fg = colors.gray7                    },
    ['@neorg.links.location.generic'             ] = { fg = colors.yellow                   },
    ['@neorg.links.location.generic.prefix'      ] = { fg = colors.yellow                   },
    ['@neorg.links.location.marker'              ] = { fg = colors.white                    },
    ['@neorg.links.location.marker.prefix'       ] = { fg = colors.orange                   },
    ['@neorg.links.location.url'                 ] = { fg = colors.blue  , underline = true },

    ['@neorg.links.location.heading.1'           ] = { fg = colors.red                      },
    ['@neorg.links.location.heading.1.prefix'    ] = { fg = colors.red                      },
    ['@neorg.links.location.heading.2'           ] = { fg = colors.orange                   },
    ['@neorg.links.location.heading.2.prefix'    ] = { fg = colors.orange                   },
    ['@neorg.links.location.heading.3'           ] = { fg = colors.yellow                   },
    ['@neorg.links.location.heading.3.prefix'    ] = { fg = colors.yellow                   },
    ['@neorg.links.location.heading.4'           ] = { fg = colors.green                    },
    ['@neorg.links.location.heading.4.prefix'    ] = { fg = colors.green                    },
    ['@neorg.links.location.heading.5'           ] = { fg = colors.blue                     },
    ['@neorg.links.location.heading.5.prefix'    ] = { fg = colors.blue                     },
    ['@neorg.links.location.heading.6'           ] = { fg = colors.purple                   },
    ['@neorg.links.location.heading.6.prefix'    ] = { fg = colors.purple                   },
    -- }}}
    -- }}}

    -- {{{ markup & delimiters
    -- standard
    ['@neorg.markup.bold'                    ] = {                                        bold          = true  },
    ['@neorg.markup.bold.delimiter'          ] = { fg = colors.gray7 ,                    bold          = true  },
    ['@neorg.markup.italic'                  ] = {                                        italic        = true  },
    ['@neorg.markup.italic.delimiter'        ] = { fg = colors.gray7 ,                    italic        = true  },
    ['@neorg.markup.underline'               ] = {                                        underline     = true  },
    ['@neorg.markup.underline.delimiter'     ] = { fg = colors.gray7 ,                    underline     = true  },
    ['@neorg.markup.strikethrough'           ] = {                                        strikethrough = true  },
    ['@neorg.markup.strikethrough.delimiter' ] = { fg = colors.gray7 ,                    strikethrough = true  },
    ['@neorg.markup.verbatim'                ] = { fg = colors.green , bg = colors.gray2,                       },
    ['@neorg.markup.verbatim.delimiter'      ] = { fg = colors.green , bg = colors.gray2, bold          = true  },

    -- other
    ['@neorg.markup.inline_math'             ] = { fg = colors.blue  , bg = colors.gray2,                       },
    ['@neorg.markup.inline_math.delimiter'   ] = { fg = colors.gray7 , bg = colors.gray2, bold          = true  },
    ['@neorg.markup.spoiler'                 ] = { fg = colors.white , bg = colors.gray2,                       },
    ['@neorg.markup.spoiler.delimiter'       ] = { fg = colors.white , bg = colors.white, bold          = true  },
    ['@neorg.markup.subscript'               ] = { fg = colors.orange,                                          },
    ['@neorg.markup.subscript.delimiter'     ] = { fg = colors.gray7 ,                    bold          = true  },
    ['@neorg.markup.superscript'             ] = { fg = colors.purple,                                          },
    ['@neorg.markup.superscript.delimiter'   ] = { fg = colors.gray7 ,                    bold          = true  },

    -- special
    ['@neorg.markup.inline_comment'          ] = { fg = colors.gray7 ,                    italic        = true  },
    ['@neorg.markup.inline_comment.delimiter'] = { fg = colors.gray7 ,                    italic        = true  },
    ['@neorg.markup.variable'                ] = { fg = colors.teal  , bg = colors.gray2,                       },
    ['@neorg.markup.variable.delimiter'      ] = { fg = colors.gray7 , bg = colors.gray2, bold          = true  },

    -- delimiters
    ['@neorg.delimiters.horizontal_line'     ] = { fg = colors.gray7                                            },
    ['@neorg.delimiters.strong'              ] = { fg = colors.gray7                                            },
    ['@neorg.delimiters.weak'                ] = { fg = colors.gray7                                            },
    -- }}}

    -- {{{ misc
    ['@neorg.error'                        ] = { fg = colors.red                   },

    ['@neorg.markers.prefix'               ] = { fg = colors.orange                },
    ['@neorg.markers.title'                ] = { fg = colors.white                 },

    ['@neorg.definitions.content'          ] = { fg = colors.white , italic = true },
    ['@neorg.definitions.prefix'           ] = { fg = colors.gray7                 },
    ['@neorg.definitions.suffix'           ] = { fg = colors.gray7                 },
    ['@neorg.definitions.title'            ] = { fg = colors.white , bold   = true },

    ['@neorg.footnotes.content'            ] = { fg = colors.white , italic = true },
    ['@neorg.footnotes.prefix'             ] = { fg = colors.gray7                 },
    ['@neorg.footnotes.suffix'             ] = { fg = colors.gray7                 },
    ['@neorg.footnotes.title'              ] = { fg = colors.white , bold   = true },

    ['@neorg.anchors.declaration'          ] = { fg = colors.teal                  },
    ['@neorg.anchors.declaration.delimiter'] = { fg = colors.gray7                 },
    ['@neorg.anchors.definition.delimiter' ] = { fg = colors.gray7                 },

    ['@neorg.insertions'                   ] = { fg = colors.white , bold   = true },
    ['@neorg.insertions.item'              ] = { fg = colors.yellow                },
    ['@neorg.insertions.parameters'        ] = { fg = colors.gray7 , italic = true },
    ['@neorg.insertions.prefix'            ] = { fg = colors.gray7                 },
    ['@neorg.insertions.variable.name'     ] = { fg = colors.teal                  },
    ['@neorg.insertions.variable.value'    ] = { fg = colors.gray7                 },

    ['@neorg.modifiers.escape'             ] = { fg = colors.yellow                },
    ['@neorg.modifiers.link'               ] = { fg = colors.gray7                 },
    ['@neorg.modifiers.trailing'           ] = { fg = colors.gray7                 },
    -- }}}
}

-- {{{ same value for 6 highlights
for i = 1, 6 do
    -- {{{ lists
    -- ordered lists
    hl['@neorg.lists.unordered.' .. i .. '.prefix'] = { fg = colors.gray7 }

    -- unordered lists
    hl['@neorg.lists.ordered.'   .. i .. '.prefix'] = { fg = colors.gray7 }
    -- }}}

    -- {{{ todos
    local todos = {
        undone    = { pre = { fg = colors.gray7  } },
        pending   = { pre = { fg = colors.yellow } },
        done      = { pre = { fg = colors.teal   } },
        cancelled = {
            pre     = { fg = colors.gray7                                      },
            content = { fg = colors.gray7, strikethrough = true, italic = true },
        },
        urgent    = {
            pre     = { fg = colors.red, bold = true },
            content = { fg = colors.red              },
        },
        on_hold   = { pre = { fg = colors.blue                } },
        recurring = { pre = { fg = colors.green               } },
        uncertain = { pre = { fg = colors.purple, bold = true } },
    }

    for k, v in pairs(todos) do
        local content = v.content or { fg = colors.white }

        hl['@neorg.todo_items.' .. k .. '.' .. i              ] = v.pre
        hl['@neorg.todo_items.' .. k .. '.' .. i .. '.content'] = content
    end
    -- }}}
end
-- }}}

-- set highlights
for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}

-- {{{ neorg-specific keybinds
local neorg_callbacks = require('neorg.callbacks')

neorg_callbacks.on_event('core.keybinds.events.enable_keybinds', function(_, keybinds)
    -- Map all the below keybinds only when the 'norg' mode is active
    keybinds.map_event_to_mode('norg', {
        n = { -- Bind keys in normal mode
            { '<C-s>', 'core.integrations.telescope.find_linkable' },
        },

        i = { -- Bind in insert mode
            { '<C-l>', 'core.integrations.telescope.insert_link' },
        },
    },
    {
        silent = true,
        noremap = true,
    })
end)
-- }}}

-- {{{ autocmds
-- {{{ imports
local au = api.nvim_create_autocmd
local cc = api.nvim_create_user_command
local exec = api.nvim_exec
local optl = vim.opt_local
-- }}}

-- {{{ autocmd on opening a norg file
au({ 'Filetype' }, { pattern = 'norg', callback = function()
    -- {{{ opts
    optl.tabstop   = 1 -- change indentation width to 1
    -- optl.foldlevel = 7 -- disable automatic folding
    -- }}}

    -- {{{ custom comment function
    cc('CommentToggle', function(tbl)
        -- {{{ +one-line comment+
        if tbl.range == 0 then
            -- one-line comment +like this+

            -- {{{ check if commented
            local current_line = api.nvim_get_current_line()
            local comment_expr = vim.regex([[^\s*+.*+\s*$]])

            if comment_expr:match_str(current_line) then
            -- }}}
            -- {{{ comment or uncomment
                -- there is already a comment, so uncomment the line
                exec([[exec 's/\(^\s*\)+\(.*\)+\(\s*$\)/\1\2\3' | noh]], false)
            else
                -- there isn't a comment, so comment the line
                exec([[exec 's/\(^\s*\)\(.*\)\(\s*$\)/\1+\2+\3' | noh]], false)
            end
            -- }}}
        -- }}}
        -- {{{ @comment multiline comment @end
        elseif tbl.range == 2 then
            -- multiline comment
            -- @comment
            -- like this
            -- @end

            -- {{{ check if commented
            local commented0 = false
            local commented1 = false

            local comment_expr = vim.regex([[^\s*@comment\s*$]])
            local end_expr     = vim.regex([[^\s*@end\s*$]]    )

            exec(tostring(tbl.line2),     false); commented0 = (end_expr    :match_str(api.nvim_get_current_line()) and                 true )
            exec(tostring(tbl.line1),     false); commented0 = (comment_expr:match_str(api.nvim_get_current_line()) and (commented0 and true))
            exec(tostring(tbl.line2 + 1), false); commented1 = (end_expr    :match_str(api.nvim_get_current_line()) and                 true )
            exec(tostring(tbl.line1 - 1), false); commented1 = (comment_expr:match_str(api.nvim_get_current_line()) and (commented1 and true))
            -- }}}
            -- {{{ comment or uncomment
            if commented0 then -- uncomment
                -- last
                exec(tostring(tbl.line2), false)
                api.nvim_set_current_line(''); exec([[exec "normal i\<BS>\<Esc>"]], false)

                -- first
                exec(tostring(tbl.line1), false)
                api.nvim_set_current_line(''); exec([[exec "normal i\<BS>\<Esc>"]], false)
            elseif commented1 then -- uncomment
                -- last
                exec(tostring(tbl.line2 + 1), false)
                api.nvim_set_current_line(''); exec([[exec "normal i\<BS>\<Esc>"]], false)

                -- first
                exec(tostring(tbl.line1 - 1), false)
                api.nvim_set_current_line(''); exec([[exec "normal i\<BS>\<Esc>"]], false)
            else -- comment
                -- last
                exec(tostring(tbl.line2),       false)
                exec([[exec "normal o\<Esc>"]], false)

                api.nvim_set_current_line('@end')

                -- first
                exec(tostring(tbl.line1),       false)
                exec([[exec "normal O\<Esc>"]], false)

                api.nvim_set_current_line('@comment')
            end
            -- }}}
        end
        -- }}}
    end, { range = true, nargs = 0 })
    -- }}}
end})
-- }}}
-- }}}
