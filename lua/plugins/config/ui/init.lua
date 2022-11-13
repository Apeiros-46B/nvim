-- load all configs related to user interface
-- {{{ return
return {
    require('config.plug.ui.lualine'),      -- lualine statusline
    require('config.plug.ui.mini_starter'), -- [mini.nvim] dashboard/splash screen
    require('config.plug.ui.mini_tabline'), -- [mini.nvim] tabline (TODO: replace with cokeline)
    require('config.plug.ui.navic'),        -- lsp navigation bar on statusline
}
-- }}}
