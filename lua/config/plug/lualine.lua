-- {{{ load scheme wrapper library
local scheme = require('lib.scheme')

-- initialize vars for schemes
local lualine_theme = nil

-- if a scheme is not bundled with lualine, look for a theme file
if scheme.is_lualine_default == false then
	lualine_theme = require('themes.lualine.' .. scheme.scheme)
else
	lualine_theme = scheme.scheme
end
-- }}}

-- {{{ custom separators
scheme.set_lualine_style({ '',  ''  })

-- lines
-- scheme.set_lualine_seperator({ '│', '│' }) -- thin box
-- scheme.set_lualine_seperator({ '┃', '┃' }) -- bold box
-- scheme.set_lualine_seperator({ '⎮', '⎮' }) -- idk what this is
-- scheme.set_lualine_seperator({ '|', '|' }) -- pipe

-- slashes
-- scheme.set_lualine_seperator({ [[\]], [[\]] })
-- scheme.set_lualine_seperator({ [[/]], [[/]] })
-- scheme.set_lualine_seperator({ [[/]], [[\]] })
scheme.set_lualine_seperator({ [[\]], [[/]] })

-- pointy
-- scheme.set_lualine_seperator({ '>', '<' })
-- scheme.set_lualine_seperator({ '<', '>' })
-- scheme.set_lualine_seperator({ '->', '<-' })
-- scheme.set_lualine_seperator({ '<-', '->' })
-- scheme.set_lualine_seperator({ '🞂',  '🞀'  })
-- scheme.set_lualine_seperator({ '🞀',  '🞂'  })

-- other
-- scheme.set_lualine_seperator({ '-', '-' })
-- scheme.set_lualine_seperator({ '', '' })
-- scheme.set_lualine_seperator({ '🞙', '🞙' })
-- }}}

-- {{{ custom mode format
local mode_fmt = {
    -- normal/misc
    ['NORMAL'] = "NOR",
    ['O-PENDING'] = "O-P",
    ['MORE'] = "MOR",
    ['CONFIRM'] = "CF?",

    -- insert
    ['INSERT'] = "INS",

    -- visual
    ['VISUAL'] = "VIS",
    ['V-LINE'] = "V-L",
    -- ['V-LINE'] = "VLN",
    ['V-BLOCK'] = "V-B",
    -- ['V-BLOCK'] = "VBL",

    -- select
    ['SELECT'] = "SEL",
    ['S-LINE'] = "S-L",
    -- ['S-LINE'] = "SLN",
    ['S-BLOCK'] = "S-B",
    -- ['S-BLOCK'] = "SBL",

    -- replace
    ['REPLACE'] = "RPL",
    ['V-REPLACE'] = "V-R",
    -- ['V-REPLACE'] = "VRP",

    -- cmd, terminal, shell, and ex
    ['COMMAND'] = "CMD",
    ['SHELL'] = "SHL",
    ['TERMINAL'] = "TER",
    ['EX'] = "EXM", -- M stands for mode, had to add to fit 3 chars
}
-- }}}

-- {{{ lualine setup config
require('lualine').setup({
	options = {
		theme = lualine_theme,

		section_separators = { left = scheme.lualine_style_left, right = scheme.lualine_style_right },
		component_separators = { left = scheme.lualine_seperator_left, right = scheme.lualine_seperator_right },

        ignore_focus = { 'NvimTree' },

        always_divide_middle = true,
        globalstatus = true,
	},

	sections = {
		-- lualine_a = { { 'mode', icon = '', fmt = function(str) return mode_fmt[str] end } }, -- icon
		lualine_a = { { 'mode', fmt = function(str) return mode_fmt[str] end } }, -- iconless

		lualine_b = { { 'filename', icon = { '', align = 'right' } }, 'filetype' }, -- icon
		-- lualine_b = { 'filename', { 'filetype', icons_enabled = false } }, -- iconless

		lualine_c = { { 'branch', icon = { '', align = 'right' } } }, -- icon
		-- lualine_c = { { 'branch', icons_enabled = false } }, -- iconless

        lualine_x = { '' }, -- nothing here

		lualine_y = { 'fileformat', { 'encoding', icon = '' } }, -- icon
		-- lualine_y = { { 'fileformat', icons_enabled = false }, 'encoding' }, -- iconless

		lualine_z = { 'progress', 'location' },
	},
})
-- }}}
