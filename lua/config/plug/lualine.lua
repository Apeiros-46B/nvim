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

-- get colors
local colors = scheme.colors
-- }}}

-- {{{ other imports
local vim = vim
local fn = vim.fn
local g = vim.g
local cc = vim.api.nvim_create_user_command -- cc stands for create command
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
-- scheme.set_lualine_seperator({ [[\]], [[/]] })

-- pointy
-- scheme.set_lualine_seperator({ '>', '<' })
-- scheme.set_lualine_seperator({ '<', '>' })
-- scheme.set_lualine_seperator({ '', '' })
-- scheme.set_lualine_seperator({ '', '' })
-- scheme.set_lualine_seperator({ '', '' })
-- scheme.set_lualine_seperator({ '', '' })
-- scheme.set_lualine_seperator({ '🞂',  '🞀'  })
-- scheme.set_lualine_seperator({ '🞀',  '🞂'  })
-- scheme.set_lualine_seperator({ '->', '<-' })
-- scheme.set_lualine_seperator({ '<-', '->' })

-- other
-- scheme.set_lualine_seperator({ '-', '-' })
scheme.set_lualine_seperator({ '~', '~' })
-- scheme.set_lualine_seperator({ '+', '+' })
-- scheme.set_lualine_seperator({ '', '' })
-- scheme.set_lualine_seperator({ '🞙', '🞙' })
-- }}}

-- {{{ reused functions, components & sections
-- {{{ functions
local mode_fmts = {
    -- normal/misc
    ['NORMAL'] = 'NOR',
    ['O-PENDING'] = 'OPR',
    ['MORE'] = 'MOR',
    ['CONFIRM'] = 'CF?',

    -- insert
    ['INSERT'] = 'INS',

    -- visual
    ['VISUAL'] = 'VIS',
    ['V-LINE'] = 'V-L',
    -- ['V-LINE'] = 'VLN',
    ['V-BLOCK'] = 'V-B',
    -- ['V-BLOCK'] = 'VBL',

    -- select
    ['SELECT'] = 'SEL',
    ['S-LINE'] = 'S-L',
    -- ['S-LINE'] = 'SLN',
    ['S-BLOCK'] = 'S-B',
    -- ['S-BLOCK'] = 'SBL',

    -- replace
    ['REPLACE'] = 'REP',
    -- ['REPLACE'] = 'RPL',
    ['V-REPLACE'] = 'V-R',
    -- ['V-REPLACE'] = 'VRP',

    -- cmd, terminal, shell, and ex
    ['COMMAND'] = 'CMD',
    ['SHELL'] = 'SHL',
    ['TERMINAL'] = 'TER',
    ['EX'] = 'EXM', -- M stands for mode, had to add to fit 3 chars
}

local function mode_fmt(str) return mode_fmts[str] end

local function short_cwd() return fn.fnamemodify(fn.getcwd(), ':~') end -- iconless
-- }}}

-- {{{ components
local datetime     = 'os.date("%d/%m:%u -> %R")'
local date         = 'os.date("%d/%m:%u")'
local time         = 'os.date("%R")'

local mode         = { 'mode', fmt = mode_fmt }
local branch       = { 'FugitiveHead', icon = '' }
local filename     = { 'filename', path = 0, shorting_target = 40, symbols = { modified = '', readonly = ' +RO', unnamed = 'No Name' } }
local filename_alt = { 'filename', path = 0, shorting_target = 40, symbols = { modified = '', readonly = '', unnamed = 'No Name' }, icon = '' }
local fileformat   = { 'fileformat', symbols = { unix = 'u', dos = 'd', mac = 'm' } }

-- {{{ navic
local navic_plugin = require('nvim-navic')

-- {{{ toggle with a command
g.show_navic = true

local function should_show_navic() return navic_plugin.is_available and g.show_navic end
cc('NavicToggle', function(_) g.show_navic = not g.show_navic end, { nargs = 0 })
-- }}}

local navic = { navic_plugin.get_location, cond = should_show_navic, colors = { bg = colors.gray3 } }
-- }}}
-- }}}

-- {{{ main sections
local sections = {
    lualine_a = { mode },
    lualine_b = { 'filesize', { 'filetype', colored = false, icon = { align = 'right' } } }, -- why won't right align work?
    lualine_c = { branch, { 'diff', symbols = { added = '', modified = '', removed = '' } } },
    lualine_x = { navic, filename },
    lualine_y = { fileformat, 'encoding' },
    lualine_z = { 'location' },
}
-- }}}
-- }}}

-- {{{ custom extensions
-- {{{ template
local extension_template = {
    -- lualine_a not defined because each extension has a different one
    lualine_b = { short_cwd },
    lualine_c = { branch }, -- TODO: add latest commit after branch
    lualine_x = { date },
    lualine_y = { 'hostname' },
    lualine_z = { 'location' },
}
-- }}}

-- {{{ extensions that use the template
-- {{{ dashboard
local dashboard = {}

dashboard.sections = vim.deepcopy(extension_template)

dashboard.sections.lualine_a = { function() return "DSH" end } -- DaSHboard

dashboard.sections.lualine_x = { '' }
dashboard.sections.lualine_z = { time }

dashboard.filetypes = { 'dashboard', 'starter' }
-- }}}

-- {{{ file tree
local file_tree = {}

file_tree.sections = vim.deepcopy(extension_template)

file_tree.sections.lualine_a = { { function() return "FTR" end, color = { bg = colors.red, gui = 'bold' } } } -- File TRee (I really need better abbrevations)

file_tree.sections.lualine_z = { { 'location', color = { bg = colors.red, gui = 'bold' } } }

file_tree.filetypes = { 'CHADTree', 'nerdtree', 'NvimTree' }
-- }}}

-- {{{ git
local GIT = { function() return "GIT" end, color = { bg = colors.orange, gui = 'bold' } } -- This one is obvious

-- fugitive panel (:Git)
local fugitive = {}

fugitive.sections = vim.deepcopy(extension_template)

fugitive.sections.lualine_a = { GIT }

fugitive.sections.lualine_z = { { 'location', color = { bg = colors.orange, gui = 'bold' } } }

fugitive.filetypes = { 'fugitive' }

-- editing a commit message
local gitcommit = {}

gitcommit.sections = vim.deepcopy(extension_template)

gitcommit.sections.lualine_a = { GIT }

gitcommit.sections.lualine_b = { { function() return "committing @" end, separator = '', padding = { left = 1 } }, short_cwd }

gitcommit.sections.lualine_z = { { 'location', color = { bg = colors.orange, gui = 'bold' } } }

gitcommit.filetypes = { 'gitcommit' }

-- fugitive blame (:Git blame)
local gitblame = {}

gitblame.sections = vim.deepcopy(extension_template)

gitblame.sections.lualine_a = { GIT }

gitblame.sections.lualine_y = { 'progress' }
gitblame.sections.lualine_z = { { 'location', color = { bg = colors.orange, gui = 'bold' } } }

gitblame.filetypes = { 'fugitiveblame' }
-- }}}

-- {{{ telescope
local telescope = {}

telescope.sections = vim.deepcopy(extension_template)

telescope.sections.lualine_a = { { function() return "TSC" end, color = { bg = colors.purple, gui = 'bold' } } } -- TeleSCope (I *really* need better abbreviations)

telescope.sections.lualine_z = { { 'location', color = { bg = colors.purple, gui = 'bold' } } }

telescope.filetypes = { 'TelescopePrompt' }
-- }}}

-- {{{ terminal
local terminal = {}

terminal.sections = vim.deepcopy(extension_template)

terminal.sections.lualine_a = { { function() return "TER" end, color = { bg = colors.teal, gui = 'bold' } } }
terminal.sections.lualine_b = { 'hostname', branch }
terminal.sections.lualine_c = { '' }

terminal.sections.lualine_x = { '' }
terminal.sections.lualine_y = { time }
terminal.sections.lualine_z = { { date, color = { bg = colors.teal, gui = 'bold' } } }

terminal.filetypes = { 'terminal' }
-- }}}

-- {{{ trouble
local trouble = {}

trouble.sections = vim.deepcopy(extension_template)

trouble.sections.lualine_a = { { function() return "TRB" end, color = { bg = colors.blue, gui = 'bold'} } }

trouble.sections.lualine_z = { { 'location', color = { bg = colors.blue, gui = 'bold' } } }

trouble.filetypes = { 'Trouble' }
-- }}}
-- }}}

-- {{{ extensions that use default sections
-- {{{ help/doc
local help = {}

help.sections = vim.deepcopy(sections)

help.sections.lualine_a = { { function() return "DOC" end, color = { bg = colors.yellow, gui = 'bold' } } } -- Same could be said about this
help.sections.lualine_b = { 'filesize', filename_alt }
help.sections.lualine_c = { '' }

help.sections.lualine_x = { '' }
help.sections.lualine_y = { 'progress' }
help.sections.lualine_z = { { 'location', color = { bg = colors.yellow, gui = 'bold' } } }

help.filetypes = { 'help' }
-- }}}

-- {{{ word count for documents
local wc = {}

-- {{{ word count function
local function word_count()
    local count = fn.wordcount()

    if count.visual_bytes ~= nil then
        return count.visual_chars .. 'c ' .. count.visual_words .. 'w'
    else
        return count.chars        .. 'c ' .. count.words        .. 'w'
    end
end
-- }}}

-- {{{ toggle with a command
g.show_word_count = true

local function should_show_word_count() return g.show_word_count end
cc('WordCountToggle', function() g.show_word_count = not g.show_word_count end, { nargs = 0 })
-- }}}

wc.sections = vim.deepcopy(sections)

wc.sections.lualine_x = { { word_count, cond = should_show_word_count }, filename }

wc.filetypes = { 'markdown', 'adoc', 'norg', 'org', 'text' }
-- }}}
-- }}}
-- }}}

-- {{{ lualine setup config
require('lualine').setup({
    -- {{{ extensions
    extensions = {
        -- uses a more minimal template
        dashboard, -- dashboard
        file_tree, -- file trees (CHADTree, NERDTree, NvimTree)
        fugitive,  -- fugitive pane
        gitblame,  -- fugitive blame sidebar
        gitcommit, -- editing commit messages
        telescope, -- telescope fuzzy finder
        terminal,  -- terminal
        trouble,   -- trouble.nvim

        -- modifies the default sections
        help,      -- `:help` panel
        wc         -- word counter for markdown, org, and txt files
    },
    -- }}}

    -- {{{ options
	options = {
		theme = lualine_theme,

		section_separators = { left = scheme.lualine_style_left, right = scheme.lualine_style_right },
		component_separators = { left = scheme.lualine_seperator_left, right = scheme.lualine_seperator_right },

        always_divide_middle = true,
        globalstatus = true,
	},

	sections = sections,
    -- }}}
})
-- }}}
