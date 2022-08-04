-- Copyright (c) 2021 Jnhtr
-- MIT license, see LICENSE for more details.
-- LuaFormatter off
local colors = {
	base_fg = '#2B3339',
	light_fg = '#9DA9A0',
    secondary = '#445055',
	background = '#384348',
	norm_bg = '#A7C080',
	ins_bg = '#7FBBB3',
	vis_bg = '#D699B6',
	rep_bg = '#E67E80',
	cmd_bg = '#83C092',
	int_bg = '#282C34',
}

local ext_colors = {
    -- Gray
	gray0  = '#282C34',
    gray1  = "#2b3339",
    gray2  = "#303c42",
    gray3  = "#384348",
    gray4  = "#445055",
    gray5  = "#607279",
    gray6  = "#7a8487",
    gray7  = "#859289",
    gray8  = '#9DA9A0',

    -- Foreground
    white  = "#d3c6aa",

    -- Other colors
    red    = "#e67e80",
    orange = "#e69875",
    yellow = "#ddbc7f",
    green  = "#a7c080",
    teal   = "#83c092",
    blue   = "#7fbbb3",
    purple = "#d699b6",
}

--LuaFormatter on
local theme = {
	normal = {
		a = { bg = colors.norm_bg, fg = colors.base_fg, gui = 'bold' },
		b = { bg = colors.secondary, fg = colors.light_fg },
		c = { bg = colors.background, fg = colors.light_fg },
	},
	insert = {
		a = { bg = colors.ins_bg, fg = colors.base_fg, gui = 'bold' },
		b = { bg = colors.secondary, fg = colors.light_fg },
		c = { bg = colors.background, fg = colors.light_fg },
	},
	visual = {
		a = { bg = colors.vis_bg, fg = colors.base_fg, gui = 'bold' },
		b = { bg = colors.secondary, fg = colors.light_fg },
		c = { bg = colors.background, fg = colors.light_fg },
	},
	replace = {
		a = { bg = colors.rep_bg, fg = colors.base_fg, gui = 'bold' },
		b = { bg = colors.secondary, fg = colors.light_fg },
		c = { bg = colors.background, fg = colors.light_fg },
	},
	command = {
		a = { bg = colors.cmd_bg, fg = colors.base_fg, gui = 'bold' },
		b = { bg = colors.secondary, fg = colors.light_fg },
		c = { bg = colors.background, fg = colors.light_fg },
	},
	inactive = {
		a = { bg = colors.int_bg, fg = colors.base_fg, gui = 'bold' },
		b = { bg = colors.secondary, fg = colors.light_fg },
		c = { bg = colors.background, fg = colors.light_fg },
	},
}

return { colors = ext_colors, theme = theme }
