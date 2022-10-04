local wk = require('which-key')

wk.setup({
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on ' in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 40, -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    operators = { gc = 'Comments' },
    key_labels = {
		['<leader>'] = 'SPC',
		['<space>'] = 'SPC',
		['<CR>'] = 'RET',
		['<tab>'] = 'TAB',
		['<bs>'] = 'BSP',
    },
    icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '-', -- symbol used between a key and it's label
        group = '+ ', -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
        border = 'none', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = 'center', -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ '}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { 'j', 'k' },
      v = { 'j', 'k' },
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
        name = 'Neorg',
        c = { 'Toggle concealer' },
        C = { 'Refresh concealer' },
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
