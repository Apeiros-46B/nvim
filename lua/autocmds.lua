--[[

    autocmds.lua
    this file defines miscellaneous (non-plugin related) autocmds

--]]

-- {{{ imports
local api = vim.api
local au = api.nvim_create_autocmd
-- }}}

-- don't show line numbers on terminal window
au({ 'TermOpen' }, { pattern = 'term://*', command = 'setlocal nonumber norelativenumber ft=terminal' })

-- # vim: foldmethod=marker
