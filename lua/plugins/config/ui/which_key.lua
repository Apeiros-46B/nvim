-- {{{ setup
local wk = require('which-key')

wk.setup({
    plugins = {
        marks     = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode

        spelling = {
            enabled     = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 40,   -- how many suggestions should be shown in the list?
        },

        presets = {
            operators    = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions      = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows      = true, -- default bindings on <c-w>
            nav          = true, -- misc bindings to work with windows
            z            = true, -- bindings for folds, spelling and others prefixed with z
            g            = true, -- bindings for prefixed with g
        },
    },

    operators = {},

    key_labels = {
		['<localleader>'] = '+LCL',
		['<leader>'     ] = '+SPC',
		['<Space>'      ] = '+SPC',
		['<CR>'         ] = '+RET',
		['<Tab>'        ] = '+TAB',
		['<BS>'         ] = '+BSP',
    },

    icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '~', -- symbol used between a key and it's label
        group = '', -- symbol prepended to a group
    },

    popup_mappings = {
        scroll_down = '<c-f>', -- binding to scroll down inside the popup
        scroll_up = '<c-b>', -- binding to scroll up inside the popup
    },

    window = {
        border   = 'none', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin   = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding  = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },

    layout = {
        height  = { min = 4,  max = 25 },
        width   = { min = 20, max = 50 },
        spacing = 8,
        align   = 'center',
    },

    ignore_missing = false,

    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ '},

    show_help = true,

    triggers = 'auto',

    triggers_blacklist = {
        i = { 'j', 'k' },
        v = { 'j', 'k' },
    },
})
-- }}}

-- {{{ leader
local spc = {
    -- {{{ multi
	b = {
		name = 'Buffer',

        d = 'Delete current',
        f = 'Find',
		h = 'Focus previous',
		j = 'Focus first',
		k = 'Focus last',
		l = 'Focus next',
	    p = 'Picker',
	},

	f = {
		name = 'Find',

        b = 'Marks',
		f = 'Files',
        r = 'Recent files',
        s = 'Synonyms',
		w = 'Words',
	},

    F = {
        name = 'Format',

        n = 'Neoformat current buffer',
        s = 'Trim trailing whitespace',
    },

	g = {
		name = 'Git',

        f = {
            name = 'Find',
            b = 'Branches',
            c = 'Commits',
        },

		b = 'Blame line',
        B = 'Blame whole file',
        c = 'Commit',
        g = 'Fugitive',
		p = 'Preview hunk',
		r = 'Reset hunk',
		R = 'Reset buffer',
		s = 'Stage hunk',
		S = 'Stage buffer',
		u = 'Undo stage hunk',
		U = 'Reset buffer index',
	},

	h = {
		name = 'Hop',

		h = 'Hop by word',
		k = 'Hop by word (before cursor)',
		j = 'Hop by word (after cursor)',
		l = 'Hop by word (all windows)',
		f = 'Hop by word (current line)',
		c = 'Hop by given char',
		C = 'Hop by 2 given chars',
		g = 'Hop by pattern',
		n = 'Hop by line start',
	},

    j = {
        name = 'JDTLS',

        e = {
            name = 'Extract',

            v = 'Variable',
            c = 'Constant',
            m = 'Method',
        },

        b = 'Build project with Maven',
        o = 'Organize imports',
    },

    l = {
        name = 'LSP',

        g = {
            name = 'Go to',

            d = 'Definition',
            D = 'Declaration',
            i = 'Implementation',
            t = 'Type definition',
        },

        w = {
            name = 'Workspace',

            a = 'Add folder',
            l = 'List folders',
            r = 'Remove folder',
        },

        d = 'Peek definition',
        f = 'Find defs and refs',
        h = 'Previous diagnostic',
        l = 'Next diagnostic',
        p = 'Open hover doc',
        r = 'Rename',
        R = 'See references',
        t = 'Trouble',
    },

    n = {
        name = 'Neorg',

        c = 'Toggle concealer',
        C = 'Refresh concealer',
        t = 'Open note for today',
        T = 'Setup three-column notes',
    },

    t = {
        name = 'Tab',

        d = 'Delete current',
        h = 'Focus previous',
        j = 'Focus first',
        k = 'Focus last',
        l = 'Focus next',
        n = 'New',
    },

    T = {
        name = 'Toggle',

        n = 'Navic',
        r = 'Relative line numbers',
        W = 'Word wrap',
        w = 'Word counter',
    },

	y = {
		name = 'Yank',

		a = 'Yank entire buffer to system clipboard',
        s = 'Yank selection to system clipboard',
		y = 'Yank line to system clipboard',
	},

	['<CR>'] = {
        name = 'Terminal',

        h = 'Horizontal',
        v = 'Vertical',
        ['<CR>'] = 'In current pane',
    },
    -- }}}

    -- {{{ single
    c = 'Pick color',
    d = 'Show diagnostic',
    q = 'Open Qalc',
    s = 'SSR'
    -- }}}
}

wk.register(spc, { prefix = '<leader>', })
-- }}}

-- {{{ local leader
local lcl = {
    -- {{{ multi
    m = {
        name = 'Neorg mode',
        h = 'Traverse headings',
        n = 'Normal',
    },

    n = {
        name = 'Neorg new',
        n = 'Document',
    },

    t = {
        name = 'Neorg GTD',

        c = 'Capture task',
        e = 'Edit task under cursor',
        v = 'Open views',
    }
    -- }}}
}

wk.register(lcl, { prefix = '<localleader>' })
-- }}}

-- {{{ g
local g = {
    -- {{{ multi
    -- neorg
    t = {
        name = 'Todo',

        c = 'Cancel',
        d = 'Mark as done',
        h = 'Put on hold',
        i = 'Mark as important',
        p = 'Mark as pending',
        r = 'Mark as recurring',
        u = 'Mark as undone',
    },
    -- }}}

    -- {{{ single
    -- neorg
    O = 'Show ToC',
    -- }}}
}

wk.register(g, { prefix = 'g' })
-- }}}
