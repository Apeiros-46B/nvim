-- load all configs related to git plugins
-- {{{ return
return {
    require('config.plug.git.fugitive'), -- git wrapper
    require('config.plug.git.gitsigns'), -- git keybinds + info in gutter
}
-- }}}
