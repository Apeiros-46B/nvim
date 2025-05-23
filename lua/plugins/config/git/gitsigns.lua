-- configuration for gitsigns plugin
-- {{{ setup
require('gitsigns').setup({
    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_'  },
        topdelete    = { text = '‾' },
        changedelete = { text = '~'  },
        untracked    = { text = '│' },
    },

    signcolumn = true, -- toggle with `:Gitsigns toggle_signs`
    numhl = false, -- toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- toggle with `:Gitsigns toggle_word_diff`

    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },

    attach_to_untracked = true,

    current_line_blame = false, -- toggle with `:Gitsigns toggle_current_line_blame`

    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
    },

    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,

    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
    },
})
-- }}}
