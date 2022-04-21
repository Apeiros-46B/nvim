local wk = require('which-key')

wk.setup({
	plugins = {
		spelling = {
			enabled = true,
			suggestions = 40,
		},
	},
	key_labels = {
		['<space>'] = '↦',
		['<CR>'] = '↵',
		['<tab>'] = '⇥',
		['<bs>'] = '⌫',
	},
	layout = {
		align = 'center',
	},
})

local keymap = {
	a = {
		name = 'hop',
		h = { 'hop by word' },
		k = { 'hop by word (before cursor)' },
		j = { 'hop by word (after cursor)' },
		l = { 'hop by word (all windows)' },
		f = { 'hop by word (current line)' },
		c = { 'hop by given char' },
		C = { 'hop by 2 given chars' },
		g = { 'hop by pattern' },
		n = { 'hop by line start' },
	},

	b = {
		name = 'buffers',
		h = { 'focus first buffer in buflist' },
		j = { 'focus previous buffer in buflist' },
		k = { 'focus next buffer in buflist' },
		l = { 'focus last buffer in buflist' },
        f = { 'format buffer' },
	},

    d = { 'show diagnostic' },

	f = {
		name = 'telescope',
		f = { 'fuzzy file finder' },
        r = { 'recent files' },
		w = { 'fuzzy word search' },
	},

	g = {
		name = 'git',
        g = { 'fugitive' },
        C = { 'commit' },
        P = { 'push' },
        B = { 'fuzzy branch finder' },
        c = { 'fuzzy commit finder' },
		s = { 'stage hunk' },
		u = { 'undo stage hunk' },
		r = { 'reset hunk' },
		R = { 'reset buffer' },
		p = { 'preview hunk' },
		b = { 'blame line' },
		S = { 'stage buffer' },
		U = { 'reset buffer index' },
	},

    J = {
        name = 'java',
        o = { 'organize imports' },
        e = {
            name = 'extract',
            v = { 'variable' },
            c = { 'constant' },
            m = { 'method' },
        },
    },

    L = {
        name = 'LSP',
        h = { 'signature help' },
        l = { 'lsp finder' },
        p = {
            name = 'preview',
            d = { 'definition' },
            k = { 'hover doc' },
        },
        r = { 'rename' },
    },

    m = {
        name = 'macros',
    },

    p = { 'preview markdown' },

	h = { 'win focus left' },
	j = { 'win focus up' },
	k = { 'win focus down' },
	l = { 'win focus right' },
	s = { 'buffer picker' },

    q = { 'save and quit all' },

    T = { 'toggle trouble panel' },

	y = {
		name = 'yank',
		a = { 'yank entire buffer to system clipboard' },
		l = { 'yank line to system clipboard' },
        s = { 'yank selection to system clipboard' },
	},
	['<cr>'] = { 'term vsplit' },
	['\\'] = { 'term hsplit' },
    ['/'] = { 'toggle comment' },
    ['~'] = { 'dashboard' },
}

wk.register(keymap, {
	prefix = '<leader>',
})
