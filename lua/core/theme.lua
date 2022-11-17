-- handle theme loading and custom highlights
-- {{{ module definition and imports
local M = {}
local set_hl = vim.api.nvim_set_hl
-- }}}

-- {{{ colors
-- TODO: get colors from colorscheme or custom highlights instead of hardcoding values
M.colors = {
    -- gray
    gray0  = '#282c34',
    gray1  = '#2b3339',
    gray2  = '#323c42',
    gray3  = '#3a454a',
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

-- {{{ load colorscheme
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) <= 0 then
    vim.g.everforest_better_performance = 1
    vim.g.everforest_background = 'hard'
    vim.o.background = 'dark'
    vim.cmd('colorscheme everforest')
end
-- }}}

-- {{{ custom highlights
M.hl = {
    NormalFloat = { bg = M.colors.gray3                      }, -- set background for floating windows
    FloatBorder = { bg = M.colors.gray3, fg = M.colors.gray3 }, -- remove border for floating windows
    EndOfBuffer = { bg = M.colors.gray1, fg = M.colors.gray1 }, -- remove tildes from gutter
}

for k,v in pairs(M.hl) do set_hl(0, k, v) end
-- }}}

-- {{{ return
return M
-- }}}
