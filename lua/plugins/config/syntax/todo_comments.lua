-- configuration for todo_comments.nvim plugin
-- {{{ imports
-- main
local todo_comments = require('todo-comments')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
todo_comments.setup({
    signs = false,
    keywords = {
        FIX  = { color = 'error',   alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE'   } },
        TODO = { color = 'info'                                                  },
        HACK = { color = 'warning'                                               },
        WARN = { color = 'warning'                                               },
        PERF = { color = 'hint',    alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { color = 'default', alt = { 'INFO'                             } },
        TEST = { color = 'test',    alt = { 'TESTING', 'PASSED', 'FAILED'      } },
    },
    gui_style = {
        fg = 'NONE',
        bg = 'BOLD',
    },
    merge_keywords = true,
    highlight = {
        multiline         = true,
        multiline_pattern = '^.',
        multiline_context = 10,

        before  = '',
        keyword = 'wide_fg',
        after   = '',
        pattern = [[.*<(KEYWORDS)\s*:]],

        comments_only = true,
        max_line_len  = 400,
    },
    colors = {
        error   = { 'Red'   , colors.red    },
        warning = { 'Yellow', colors.yellow },
        info    = { 'Green' , colors.green  },
        hint    = { 'Aqua'  , colors.teal   },
        default = { 'Blue'  , colors.blue   },
        test    = { 'Purple', colors.purple },
    },
})
-- }}}
