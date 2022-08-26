local wk = require('which-key')

wk.setup({
	plugins = {
		spelling = {
			enabled = true,
			suggestions = 40,
		},
	},
	key_labels = {
		['<leader>'] = 'SPC',
		['<space>'] = 'SPC',
		['<CR>'] = 'RET',
		['<tab>'] = 'TAB',
		['<bs>'] = 'BSP',
	},
	layout = {
		align = 'center',
	},
})

local ldr_keymap = {
	a = {
		name = 'Hop',
		h = { 'Hop by word' },
		k = { 'Hop by word (before cursor)' },
		j = { 'Hop by word (after cursor)' },
		l = { 'Hop by word (all windows)' },
		f = { 'Hop by word (current line)' },
		c = { 'Hop by given char' },
		C = { 'Hop by 2 given chars' },
		g = { 'Hop by pattern' },
		n = { 'Hop by line start' },
	},

	b = {
		name = 'Buffers',
		h = { 'Focus first buffer in buflist' },
		j = { 'Focus previous buffer in buflist' },
		k = { 'Focus next buffer in buflist' },
		l = { 'Focus last buffer in buflist' },
        f = { 'Format buffer' },
	    p = { 'Buffer picker' },
	},

    d = { 'Show diagnostic' },

	f = {
		name = 'Find [Telescope]',
        b = { 'Bookmark' },
		f = { 'File' },
        r = { 'Recent file' },
		w = { 'Word' },
	},

	g = {
		name = 'Git',
        g = { 'Fugitive' },
        B = { 'Fuzzy branch finder' },
        C = { 'Fuzzy commit finder' },
		s = { 'Stage hunk' },
		u = { 'Undo stage hunk' },
		r = { 'Reset hunk' },
		R = { 'Reset buffer' },
		p = { 'Preview hunk' },
		b = { 'Blame' },
		S = { 'Stage buffer' },
		U = { 'Reset buffer index' },
	},

    J = {
        name = 'JDTLS',
        b = { 'Build project with Maven' },
        o = { 'Organize imports' },
        e = {
            name = 'Extract',
            v = { 'Variable' },
            c = { 'Constant' },
            m = { 'Method' },
        },
    },

    L = {
        name = 'LSP',
        d = { 'Preview definition' },
        f = { 'LSP finder' },
        g = {
            name = 'Go to',
            D = { 'Declaration' },
            d = { 'Definition' },
            i = { 'Implementation' },
            t = { 'Type definition' },
        },
        h = { 'Previous diagnostic' },
        l = { 'Next diagnostic' },
        p = { 'Open hover doc' },
        R = { 'See references' },
        r = { 'Rename' },
        s = { 'Signature help' },
        w = {
            name = 'Workspace',
            a = { 'Add folder' },
            l = { 'List folders' },
            r = { 'Remove folder' },
        }
    },

    M = {
        name = 'Macros',
    },

    m = {
        name = 'Preview math',
        a = { 'All' },
        p = { 'Popup' },
    },

    N = {
        name = 'New',
        f = { 'File' },
    },

    n = { 'Toggle Navic' },

    P = { 'Preview Markdown' },

    q = { 'Save and quit all' },

    S = { 'Source current file' },

    T = { 'Toggle Trouble panel' },

    t = { 'Trim trailing spaces' },

	y = {
		name = 'Yank',
		a = { 'Yank entire buffer to system clipboard' },
		l = { 'Yank line to system clipboard' },
        s = { 'Yank selection to system clipboard' },
	},

    W = { 'Toggle word wrap' },
    w = { 'Toggle word count' },

	h = { 'Focus left window' },
	j = { 'Focus up window' },
	k = { 'Focus down window' },
	l = { 'Focus right window' },

    ['<leader>'] = { 'Reload configuration' },

	['<CR>'] = {
        name = 'Terminal',
        ['<CR>'] = 'Vertical',
        h = 'Horizontal',
    },

    ['/'] = { 'Toggle comment' },
    ['~'] = { 'Show splash screen' },
}

wk.register(ldr_keymap, {
	prefix = '<leader>',
})

local g_keymap = {
    -- himalaya
    a = { 'Download attachments' },
    C = { 'Copy message' },
    D = { 'Delete message' },
    m = { 'Change mailbox' },
    M = { 'Move message' },
    p = { 'Previous inbox page' },
    r = { 'Reply' },
    R = { 'Reply all' },
    w = { 'Write a new message' },

    -- neorg
    t = {
        name = 'Todos',
        c = { 'Cancel' },
        d = { 'Mark as done' },
        h = { 'Put on hold' },
        i = { 'Mark as important' },
        p = { 'Mark as pending' },
        r = { 'Mark as recurring' },
        u = { 'Mark as undone' },
    },
    O = { 'Show ToC' },
    -- e = {
    --     name = 'Export',
    --     p = 'As PDF',
    --     d = 'As DOCX',
    -- },
}

wk.register(g_keymap, {
    prefix = 'g'
})
