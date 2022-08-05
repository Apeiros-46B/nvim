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
	    p = { 'buffer picker' },
	},

    d = { 'show diagnostic' },

	f = {
		name = 'find [telescope]',
        b = { 'bookmark' },
		f = { 'file' },
        r = { 'recent file' },
		w = { 'word' },
	},

	g = {
		name = 'git',
        g = { 'fugitive' },
        B = { 'fuzzy branch finder' },
        C = { 'fuzzy commit finder' },
		s = { 'stage hunk' },
		u = { 'undo stage hunk' },
		r = { 'reset hunk' },
		R = { 'reset buffer' },
		p = { 'preview hunk' },
		b = { 'blame' },
		S = { 'stage buffer' },
		U = { 'reset buffer index' },
	},

    J = {
        name = 'java',
        b = { 'build project with maven' },
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
        d = { 'preview definition' },
        f = { 'LSP finder' },
        g = {
            name = 'go',
            D = { 'declaration' },
            d = { 'definition' },
            i = { 'implementation' },
            t = { 'type definition' },
        },
        h = { 'previous diagnostic' },
        l = { 'next diagnostic' },
        p = { 'open hover doc' },
        R = { 'see references' },
        r = { 'rename' },
        s = { 'signature help' },
        w = {
            name = 'workspace',
            a = { 'add folder' },
            l = { 'list folders' },
            r = { 'remove folder' },
        }
    },

    m = {
        name = 'macros',
    },

    N = {
        name = 'new',
        f = { 'file' },
    },

    n = { 'toggle navic' },

    p = { 'preview markdown' },

    q = { 'save and quit all' },

    S = { 'source current file' },

    T = { 'toggle trouble panel' },

	y = {
		name = 'yank',
		a = { 'yank entire buffer to system clipboard' },
		l = { 'yank line to system clipboard' },
        s = { 'yank selection to system clipboard' },
	},

    W = { 'toggle word wrap' },
    w = { 'toggle word count' },

	h = { 'win focus left' },
	j = { 'win focus up' },
	k = { 'win focus down' },
	l = { 'win focus right' },

    ['<leader>'] = { 'reload configuration' },
	['<cr>'] = { 'vsplit -> term' },
	['\\'] = { 'hsplit -> term' },
    ['/'] = { 'toggle comment' },
    ['~'] = { 'go to dashboard' },
}

wk.register(keymap, {
	prefix = '<leader>',
})
