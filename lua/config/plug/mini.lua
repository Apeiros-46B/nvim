-- {{{ scheme & highlight import
local scheme = require('lib.scheme')
local colors = scheme.colors

local set_hl = vim.api.nvim_set_hl
local hl = {}
-- }}}

-- {{{ sessions
local sessions = require('mini.sessions')

-- {{{ setup
sessions.setup({
    -- Whether to read latest session if Neovim opened without file arguments
    autoread = false,

    -- Whether to write current session before quitting Neovim
    autowrite = true,

    -- Directory where global sessions are stored (use `''` to disable)
    directory = '~/.local/share/nvim/sessions', --<"session" subdir of user data directory from |stdpath()|>,

    -- File for local session (use `''` to disable)
    file = 'session.vim',

    -- Whether to force possibly harmful actions (meaning depends on function)
    force = { read = false, write = true, delete = false },

    -- Hook functions for actions. Default `nil` means 'do nothing'.
    hooks = {
        -- Before successful action
        pre = { read = nil, write = nil, delete = nil },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
    },

    -- Whether to print session path after action
    verbose = { read = false, write = true, delete = true },
})
-- }}}
-- }}}

-- {{{ starter
local starter = require('mini.starter')

-- {{{ sections
-- sessions but with lowercase names
local name_replacements = {
    ["There are no detected sessions in 'mini.sessions'"] = 'there are no detected sessions',
}

local sessions = starter.sections.sessions()()
for _,v in pairs(sessions) do
    for k,new in pairs(name_replacements) do
        if v.name == k then
            v.name = new
        end
    end

    v.section = 'sessions'
end

-- telescope
local telescope = {
    { action = 'Telescope find_files',      name = 'files',     section = 'telescope' },
    { action = 'Telescope oldfiles',        name = 'recents',   section = 'telescope' },
    { action = 'Telescope live_grep',       name = 'find word', section = 'telescope' },
    { action = 'Telescope command_history', name = 'cmd hist',  section = 'telescope' },
    { action = 'Telescope help_tags',       name = 'help',      section = 'telescope' },
}
-- }}}

-- {{{ setup
starter.setup({
    autoopen = true,
    evaluate_single = false,
    items = {
        sessions,
        telescope,
    },
    content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center', 'center'),
    },
    -- header = function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') end,
    header = function() return 'hello ' .. os.getenv('USER') .. '!' end,
    footer = function() return os.date("%d/%m:%u") end,
})
-- }}}

-- {{{ custom highlight
hl = {
    MiniStarterCurrent    = {                     bold = true },
    MiniStarterSection    = { fg = colors.blue  , bold = true },
    MiniStarterHeader     = { fg = colors.red   , bold = true },
    MiniStarterFooter     = { fg = colors.orange, bold = true },
    MiniStarterQuery      = { fg = colors.purple,             },
    MiniStarterItemPrefix = { fg = colors.green ,             },
}
for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}
-- }}}

-- {{{ tabline
local tabline = require('mini.tabline')

-- {{{ setup
tabline.setup({
    -- Whether to show file icons (requires 'kyazdani42/nvim-web-devicons')
    show_icons = true,

    -- Whether to set Vim's settings for tabline (make it always shown and
    -- allow hidden buffers)
    set_vim_settings = true,

    -- Where to show tabpage section in case of multiple vim tabpages.
    -- One of 'left', 'right', 'none'.
    tabpage_section = 'left',
})
-- }}}

-- {{{ custom highlight
hl = {
    MiniTablineCurrent                    = { bg = colors.green, fg = colors.gray1, bold = true                },
    MiniTablineModifiedCurrent            = { bg = colors.green, fg = colors.gray1, bold = true, italic = true },
    MiniTablineVisible                    = { bg = colors.gray4, fg = colors.gray8, bold = true,               },
    MiniTablineModifiedVisible            = { bg = colors.gray4, fg = colors.gray8, bold = true, italic = true },
    MiniTablineHidden                     = { bg = colors.gray4, fg = colors.gray8,                            },
    MiniTablineModifiedHidden             = { bg = colors.gray4, fg = colors.gray8,              italic = true },
    MiniTablineFill                       = { bg = colors.gray3,                                               },
    MiniTablineTabpagesection             = { bg = colors.green,                                               },
}
for k,v in pairs(hl) do set_hl(0, k, v) end
-- }}}
-- }}}

-- {{{ trailspace
local trailspace = require('mini.trailspace')

-- setup
trailspace.setup({
    only_in_normal_buffers = true,
})

-- custom highlight
set_hl(0, 'MiniTrailspace', { bg = colors.orange })
-- }}}
