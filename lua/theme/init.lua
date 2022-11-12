-- handling theme loading
-- {{{ module definition
local M = {}
-- }}}

-- {{{ list of pre-packaged lualine themes
-- NOTE: certain lualine default themes are excluded for improved aesthetic changes
local lualine_def_themes = {
	'16color',
	'ayu_dark',
	'ayu_light',
	'ayu_mirage',
	'codedark',
	'dracula',
	'gruvbox',
	'gruvbox_light',
	'gruvbox_material',
	'horizon',
	'iceberg_dark',
	'iceberg_light',
	'jellybeans',
	'material',
	'modeus_vivendi',
	'molokai',
	'nightfly',
	'nord',
	'oceanicnext',
	'onedark',
	'onelight',
	'palenight',
	'papercolor_dark',
	'papercolor_light',
	'powerline',
	'seoul256',
	'solarized_dark',
	'solarized_light',
	'tommorow',
	'wombat',
}

-- string-based theme definitions for lualine themes [WIP]
local lualine_def_styles = {
	'powerline',
	'dotline',
	'chevron',
}
-- }}}

-- {{{ variable definitions
M.theme = 'everforest' -- specifies theme. default is 'everforest'

-- specifies line style
M.lualine_style_left = ''
M.lualine_style_right = ''

-- specifies line separator style
M.lualine_separator_left = ''
M.lualine_separator_right = ''

-- tabline styles
M.tabline_style_left = ''
M.tabline_style_right = ''

-- tabline separator
M.tabline_separator_left = ''
M.tabline_separator_right = ''

-- if the theme bundled with lualine?
-- used in config/plug/lualine.lua
M.is_lualine_default = false

-- local indicators if a theme has been loaded
local theme_loaded = false

-- colors
M.colors = {
    -- gray
    gray0  = '#282c34',
    gray1  = '#2b3339',
    gray2  = '#303c42',
    gray3  = '#384348',
    gray4  = '#445055',
    gray5  = '#607279',
    gray6  = '#7a8487',
    gray7  = '#859289',
    gray8  = '#9da9a0',

    -- foreground
    white  = '#d3c6aa',

    -- other colors
    red    = '#e67e80',
    orange = '#e69875',
    yellow = '#ddbc7f',
    green  = '#a7c080',
    teal   = '#83c092',
    blue   = '#7fbbb3',
    purple = '#d699b6',

    -- misc
    visual_bg = '#503946',
    diff_del  = '#4e3e43',
    diff_add  = '#404d44',
    diff_mod  = '#394f5a',
}
-- }}}

-- {{{ global wrappers
-- {{{ load theme
-- @param choice string
-- The theme name to load
function M.load(choice)
	require('theme.colorscheme.' .. choice) -- TODO: add `M.colors = <that>` when all color tables have been added
	theme_loaded = true
end
-- }}}

-- {{{ load lualine theme
-- @param choice string
-- The theme name to load
function M.load_lualine(choice)
	M.theme = choice

    -- checks if the arg is a theme in the default themes list,
    -- otherwise it requires a file
	local is_present = false
	for _, name in ipairs(lualine_def_themes) do
		if name == choice then
			is_present = true
			M.is_lualine_default = true
			M.theme = name
		end
	end
	if is_present == false then
		M.is_lualine_default = false
		M.theme = choice
	end
	theme_loaded = true
end
-- }}}

-- {{{ load both
-- @param choice string
-- The theme name to load
function M.load_both(choice)
	M.load(choice)
	M.load_lualine(choice)
	theme_loaded = true
end
-- }}}

-- {{{ load global style
function M.load_global_style(style, separator)
	if style and separator then
		M.set_lualine_style(style)
		M.set_tabline_style(style)
		M.set_lualine_separator(separator)
		M.set_tabline_separator(separator)
	end
end
-- }}}
-- }}}

-- {{{ lualine style loaders
-- {{{ set the style for the main bar
-- @param choice table
-- used in config/plus/lualine.lua
function M.set_lualine_style(choice)
	if type(choice) == 'table' then
		M.lualine_style_left = choice[1]
		M.lualine_style_right = choice[2]
	else
		M.lualine_style_left = ''
		M.lualine_style_right = ''
	end
end
-- }}}

-- {{{ set the style for the lualine
-- @param choice table
-- used in config/plus/lualine.lua
function M.set_lualine_separator(choice)
	if type(choice) == 'table' then
		M.lualine_separator_left = choice[1]
		M.lualine_separator_right = choice[2]
	else
		M.lualine_separator_left = ''
		M.lualine_separator_right = ''
	end
end
-- }}}
-- }}}

-- {{{ load default theme if no user choice
if theme_loaded == false then
	M.load_both(M.theme)
end
-- }}}

-- {{{ return
return M
-- }}}
