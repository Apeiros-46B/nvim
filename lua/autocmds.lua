--[[

    autocmds.lua
    This file defines various autocmds that nii-nvim uses

--]]

local au = vim.api.nvim_create_autocmd
local optl = vim.opt_local

-- Don't show line numbers on terminal window
au({ 'TermOpen' }, { pattern = 'term://*', command = 'setlocal nonumber norelativenumber ft=terminal' })

-- Change indentation to one space in Neorg files
au({ 'Filetype' }, { pattern = 'norg', callback = function() optl.tabstop = 1 end })

-- # vim: foldmethod=marker
