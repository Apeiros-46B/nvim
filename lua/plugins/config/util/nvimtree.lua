-- configuration for nvim-tree plugin
return function(theme)
    -- {{{ imports
    local colors    = theme.colors
    local nvim_tree = require('nvim-tree')
    -- }}}

    -- {{{ setup
    nvim_tree.setup({
        -- {{{ options
        disable_netrw = true,
        hijack_cursor = true,
        hijack_netrw  = true,
        -- }}}

        -- {{{ view
        view = {
            adaptive_size               = false,
            centralize_selection        = false,
            width                       = 30,
            hide_root_folder            = false,
            side                        = 'left',
            preserve_window_proportions = true,

            signcolumn = 'yes',
            mappings = {
                custom_only = false,
                list = {
                    -- user mappings go here
                },
            },
        },
        -- }}}

        -- {{{ renderer
        renderer = {
            add_trailing = true,
            group_empty = true,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = 'name',

            indent_markers = {
                enable        = true,
                inline_arrows = true,

                icons = {
                    corner = '└',
                    edge   = '│',
                    item   = '│',
                    bottom = '─',
                    none   = ' ',
                },
            },

            icons = {
                webdev_colors = true,
                git_placement = 'signcolumn',
                padding = ' ',
                symlink_arrow = ' -> ',
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = true,
                },
                glyphs = {
                    default  = '',
                    symlink  = '',
                    bookmark = '',
                    folder = {
                        arrow_closed = '│',
                        arrow_open   = '│',
                        default      = '',
                        open         = 'ﱮ',
                        empty        = '',
                        empty_open   = '',
                        symlink      = '',
                        symlink_open = '',
                    },
                    git = {
                        unstaged  = '×',
                        staged    = '',
                        unmerged  = '-',
                        renamed   = '',
                        untracked = '+',
                        deleted   = '',
                        ignored   = '',
                    },
                },
            },

            special_files = { 'LICENSE', 'README.md', 'pom.xml', 'Cargo.toml', 'Makefile' },
            symlink_destination = true,
        },
        -- }}}

        -- {{{ components
        diagnostics = {
            enable = true,
            show_on_dirs = false,
            show_on_open_dirs = true,
            debounce_delay = 50,
            severity = {
                min = vim.diagnostic.severity.HINT,
                max = vim.diagnostic.severity.ERROR
            },
            icons = { error = '', warning = '', info = '', hint = '' },
        },

        filesystem_watchers = {
            enable = true,
            debounce_delay = 50,
            ignore_dirs = {},
        },

        git = {
            enable = true,
            ignore = false,
            show_on_dirs = true,
            show_on_open_dirs = true,
            timeout = 400,
        },

        live_filter = {
            prefix              = 'FLTR: ',
            always_show_folders = true,
        },

        tab = {
            sync = {
                open   = true,
                close  = true,
                ignore = {},
            },
        },

        notify = {
            threshold = vim.log.levels.INFO,
        },
        -- }}}
    })
    -- }}}

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        NvimTreeNormal      = { bg = colors.gray1, fg = colors.white },
        NvimTreeEndOfBuffer = { bg = colors.gray1, fg = colors.gray1 },
        NvimTreeVertSplit   = { bg = colors.gray1, fg = colors.gray1 },
        NvimTreeCursorLine  = { bg = colors.gray2, fg = 'NONE'       },

        NvimTreeIndentMarker = { fg = colors.gray5 },

        NvimTreeRootFolder       = { fg = colors.gray7 },
        NvimTreeFolderName       = { fg = colors.blue  },
        NvimTreeFolderIcon       = { fg = colors.green },
        NvimTreeEmptyFolderName  = { fg = colors.blue  },
        NvimTreeOpenedFolderName = { fg = colors.blue  },

        NvimTreeSymlink     = { fg = colors.teal  , bold = true },
        NvimTreeExecFile    = { fg = colors.green , bold = true },
        NvimTreeSpecialFile = { fg = colors.purple, bold = true },
        NvimTreeImageFile   = { fg = colors.white ,             },
    }

    -- TODO: find out why this defer is needed for hl to be applied properly
    vim.defer_fn(function()
        for k, v in pairs(hl) do
            set_hl(0, k, v)
        end
    end, 30)
    -- }}}
end
