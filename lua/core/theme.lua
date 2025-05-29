local M = {}

M.colors = {
	bg0       = '#ffffff',
	bg1       = '#f4f4f4',
	bg2       = '#ebebeb',
	bg3       = '#e4e4e4',
	bg4       = '#dfdfdf',
	bg5       = '#dcdcdc',
	fg0       = '#333333',
	fg1       = '#202020',
	fg2       = '#000000',
	fg3       = '#777777',
	red       = '#904961',
	orange    = '#934c3d',
	yellow    = '#b5803e',
	green     = '#427138',
	aqua      = '#117555',
	blue      = '#535d9c',
	purple    = '#79508a',
	bg_red    = '#e9dbdf',
	bg_yellow = '#f0e6d8',
	bg_green  = '#d9e3d7',
	bg_aqua   = '#cfe3dd',
	bg_blue   = '#dddfeb',
	bg_purple = '#e4dce8',
	bg_cursor = '#fafafa',
}
M.colors.accent = M.colors.blue
M.colors.bg_accent = M.colors.bg_blue

-- M.colors = {
-- 	bg0       = '#2b3339',
-- 	bg1       = '#323c41',
-- 	bg2       = '#3a454a',
-- 	bg3       = '#445055',
-- 	bg4       = '#53605c',
-- 	bg5       = '#53605c',
-- 	fg0       = '#d3c6aa',
-- 	fg1       = '#d3c6aa',
-- 	fg2       = '#d3c6aa',
-- 	fg3       = '#859289',
-- 	red       = '#e67e80',
-- 	orange    = '#e69875',
-- 	yellow    = '#ddbc7f',
-- 	green     = '#a7c080',
-- 	aqua      = '#83c092',
-- 	blue      = '#7fbbb3',
-- 	purple    = '#d699b6',
-- 	bg_red    = '#4e3e43',
-- 	bg_yellow = '#4a4940',
-- 	bg_green  = '#404d44',
-- 	bg_aqua   = '#394f5a',
-- 	bg_blue   = '#394f5a',
-- 	bg_purple = '#503946',
-- }

require('util').hl {
	iCursor = { bg = M.colors.blue   },
	vCursor = { bg = M.colors.purple },
	rCursor = { bg = M.colors.red    },

	StatusLine     = { bg = M.colors.bg1, fg = M.colors.fg3 },
	StatusLineTerm = { bg = M.colors.bg1, fg = M.colors.fg3 },
	TabLine        = { bg = M.colors.bg0, fg = M.colors.fg3, nocombine = true },
	TabLineFill    = { bg = M.colors.bg0, fg = M.colors.fg3, nocombine = true },

	WinBar   = { bg = 'NONE', fg = M.colors.fg3 },
	WinBarNC = { bg = 'NONE', fg = M.colors.fg3 },
}

return M
