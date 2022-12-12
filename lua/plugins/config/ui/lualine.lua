-- configuration for lualine statusline
-- {{{ imports
local api = vim.api
local fn = vim.fn
local g = vim.g

local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ main style
local style = {}

style = { l = '', r = '' }
-- }}}

-- {{{ separator style
local sep = {}

-- sep = { l = '│', r = '│' }
-- sep = { l = '┃', r = '┃' }
-- sep = { l = '⎮', r = '⎮' }
-- sep = { l = '|', r = '|' }

-- sep = { l = [[\]], r = [[\]] }
-- sep = { l = [[/]], r = [[/]] }
-- sep = { l = [[/]], r = [[\]] }
-- sep = { l = [[\]], r = [[/]] }

-- sep = { l = '>', r = '<' }
-- sep = { l = '<', r = '>' }
-- sep = { l = '', r = '' }
-- sep = { l = '', r = '' }
-- sep = { l = '', r = '' }
-- sep = { l = '', r = '' }
-- sep = { l = '🞂', r =  '🞀'  }
-- sep = { l = '🞀', r =  '🞂'  }
-- sep = { l = '->', r = '<-' }
-- sep = { l = '<-', r = '->' }

-- sep = { l = '-', r = '-' }
sep = { l = '~', r = '~' }
-- sep = { l = '+', r = '+' }
-- sep = { l = '', r = '' }
-- sep = { l = '🞙', r = '🞙' }
-- }}}

-- {{{ theme
local function a(color)
	return { bg = color, fg = colors.gray1, gui = 'bold' }
end

local b = { bg = colors.gray4, fg = colors.gray8 }
local c = { bg = colors.gray3, fg = colors.gray8 }

local lualine_theme = {
	normal = {
		a = a(colors.green),
		b = b,
		c = c,
	},
	insert = {
		a = a(colors.blue),
		b = b,
		c = c,
	},
	visual = {
		a = a(colors.purple),
		b = b,
		c = c,
	},
	replace = {
		a = a(colors.red),
		b = b,
		c = c,
	},
	command = {
		a = a(colors.teal),
		b = b,
		c = c,
	},
	inactive = {
		a = a(colors.gray8),
		b = b,
		c = c,
	},
}
-- }}}

-- {{{ reused functions, components & sections
-- {{{ functions
local mode_fmts = {
    -- normal/misc
    ['NORMAL'   ] = 'NOR',
    ['O-PENDING'] = 'OPR',
    ['MORE'     ] = 'MOR',
    ['CONFIRM'  ] = 'CF?',

    -- insert
    ['INSERT'] = 'INS',

    -- visual
    ['VISUAL' ] = 'VIS',
    ['V-LINE' ] = 'V-L',
    ['V-BLOCK'] = 'V-B',

    -- select
    ['SELECT' ] = 'SEL',
    ['S-LINE' ] = 'S-L',
    ['S-BLOCK'] = 'S-B',

    -- replace
    ['REPLACE'  ] = 'REP',
    ['V-REPLACE'] = 'V-R',

    -- cmd, terminal, shell, and ex
    ['COMMAND' ] = 'CMD',
    ['SHELL'   ] = 'SHL',
    ['TERMINAL'] = 'TER',
    ['EX'      ] = 'EXM', -- M stands for mode, had to add to fit 3 chars
}

local function mode_fmt(str) return mode_fmts[str] end

local function short_cwd() return vim.fn.pathshorten(fn.fnamemodify(fn.getcwd(), ':~'), 2) end -- iconless

-- {{{ word count function
local function word_count_fn()
    local count = fn.wordcount()

    if count.visual_bytes ~= nil then
        return table.concat({ count.visual_chars, 'c ', count.visual_words, 'w' }, '')
    else
        return table.concat({ count.chars       , 'c ', count.words       , 'w' }, '')
    end
end

-- {{{ toggle with a command
g.show_word_count = true

local function should_show_word_count() return g.show_word_count end
api.nvim_create_user_command('WordCountToggle', function() g.show_word_count = not g.show_word_count end, { nargs = 0 })
-- }}}
-- }}}
-- }}}

-- {{{ components
-- {{{ date/time
local datetime = 'os.date("%d/%m:%u -> %R")'
local date     = 'os.date("%d/%m:%u")'
local time     = 'os.date("%R")'
-- }}}

-- {{{ editing/files
local mode         = { 'mode', fmt = mode_fmt }
local filetype     = { 'filetype', colored = false, icon = { align = 'right' } } -- why won't right align work?
local fileformat   = { 'fileformat', symbols = { unix = 'u', dos = 'd', mac = 'm' } }
local filename     = { 'filename', path = 0, shorting_target = 40, symbols = { modified = '+', readonly = '+RO', unnamed = 'No Name' } }
local filename_alt = { 'filename', path = 0, shorting_target = 40, symbols = { modified = '+', readonly = '', unnamed = 'No Name' }, icon = '' }
local word_count   = { word_count_fn, cond = should_show_word_count }
-- }}}

-- {{{ git
local branch = { 'FugitiveHead', icon = '' }
local diff   = { 'diff', symbols = { added = '+', modified = '~', removed = '-' } }
-- }}}

-- {{{ lsp
local diagnostics  = {
    'diagnostics',
    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
    diagnostics_color = {
        error = 'LualineDiagnosticError',
        warn  = 'LualineDiagnosticWarn',
        info  = 'LualineDiagnosticInfo',
        hint  = 'LualineDiagnosticHint',
    }
}

-- {{{ custom highlights
local set_hl = api.nvim_set_hl

local hl = {
    LualineDiagnosticError = { fg = colors.red   , bg = lualine_theme.normal.c.bg },
    LualineDiagnosticWarn  = { fg = colors.yellow, bg = lualine_theme.normal.c.bg },
    LualineDiagnosticInfo  = { fg = colors.green , bg = lualine_theme.normal.c.bg },
    LualineDiagnosticHint  = { fg = colors.teal  , bg = lualine_theme.normal.c.bg },
}

for k, v in pairs(hl) do set_hl(0, k, v) end
-- }}}
-- }}}
-- }}}

local sections = {
    lualine_a = { mode },
    lualine_b = { 'filesize', filetype },
    lualine_c = { branch, diff, diagnostics },
    lualine_x = { '', filename },
    lualine_y = { fileformat, 'encoding' },
    lualine_z = { 'location' },
}
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

file_tree.sections.lualine_a = { { function() return "FTR" end, color = { bg = colors.blue, gui = 'bold' } } } -- File TRee (I really need better abbrevations)

file_tree.sections.lualine_z = { { 'location', color = { bg = colors.blue, gui = 'bold' } } }

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

-- {{{ help/doc
local help = {}

help.sections = vim.deepcopy(extension_template)

help.sections.lualine_a = { { function() return "DOC" end, color = { bg = colors.yellow, gui = 'bold' } } } -- Same could be said about this
help.sections.lualine_b = { 'filesize', filename_alt }
help.sections.lualine_c = { '' }

help.sections.lualine_x = { '' }
help.sections.lualine_y = { 'progress' }
help.sections.lualine_z = { { 'location', color = { bg = colors.yellow, gui = 'bold' } } }

help.filetypes = { 'help' }
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

trouble.sections.lualine_a = { { function() return "TRB" end, color = { bg = colors.red, gui = 'bold'} } }

trouble.sections.lualine_z = { { 'location', color = { bg = colors.red, gui = 'bold' } } }

trouble.filetypes = { 'Trouble' }
-- }}}

-- {{{ word count for documents
local wc = {}

wc.sections = vim.deepcopy(sections)

wc.sections.lualine_x = { word_count, filename }

--                markdown    asciidoc  neorg   org    text
wc.filetypes = { 'markdown', 'adoc',   'norg', 'org', 'text' }
-- }}}
-- }}}

-- {{{ setup
local function setup(new_sections)
    require('lualine').setup({
        -- {{{ extensions
        extensions = {
            -- uses a more minimal template
            dashboard,      -- dashboard
            file_tree,      -- file trees (CHADTree, NERDTree, NvimTree)
            fugitive,       -- fugitive pane
            gitblame,       -- fugitive blame sidebar
            gitcommit,      -- editing commit messages
            telescope,      -- telescope fuzzy finder
            terminal,       -- terminal
            trouble,        -- trouble.nvim

            -- modifies the default sections
            help,           -- `:help` panel
            himalaya,       -- inbox list and reading messages in himalaya
            himalaya_write, -- writing messages in himalaya
            wc              -- word counter for markdown, norg, and txt files
        },
        -- }}}

        -- {{{ options
        options = {
            theme = lualine_theme,

            section_separators   = { left = style.l, right = style.r },
            component_separators = { left = sep.l,   right = sep.r   },

            always_divide_middle = true,
            globalstatus = true,
        },

        sections = new_sections,
        -- }}}
    })
end

setup(sections)
-- }}}

return { setup = setup, sections = sections }
