local M = require('colors.elysium')

require('util').hl {
	iCursor = { fg = M.palette.bg0, bg = M.palette.blue   },
	vCursor = { fg = M.palette.bg0, bg = M.palette.purple },
	rCursor = { fg = M.palette.bg0, bg = M.palette.red    },

	StatusLine     = { bg = M.palette.bg1, fg = M.palette.fg3 },
	StatusLineTerm = { bg = M.palette.bg1, fg = M.palette.fg3 },
	TabLine        = { bg = M.palette.bg0, fg = M.palette.fg3, nocombine = true },
	TabLineFill    = { bg = M.palette.bg0, fg = M.palette.fg3, nocombine = true },

	WinBar   = { bg = 'NONE', fg = M.palette.fg3 },
	WinBarNC = { bg = 'NONE', fg = M.palette.fg3 },
}

return M
