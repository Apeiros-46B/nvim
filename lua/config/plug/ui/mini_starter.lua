-- configuration for starter module of mini.nvim
-- {{{ imports
local starter = require('mini.starter')
-- }}}

-- {{{ sections
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

-- {{{ custom highlights
local theme = require('theme')
local colors = theme.colors

local set_hl = vim.api.nvim_set_hl

local hl = {
    MiniStarterCurrent    = {                     bold = true },
    MiniStarterSection    = { fg = colors.blue  , bold = true },
    MiniStarterHeader     = { fg = colors.red   , bold = true },
    MiniStarterFooter     = { fg = colors.orange, bold = true },
    MiniStarterQuery      = { fg = colors.purple,             },
    MiniStarterItemPrefix = { fg = colors.green ,             },
}

for k, v in pairs(hl) do set_hl(0, k, v) end
-- }}}
