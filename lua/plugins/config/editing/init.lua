-- load all configs related to general text editing
-- {{{ return
return {
    require('config.plug.editing.autopairs'),   -- automatically pair delimiters
    require('config.plug.editing.hop'),         -- navigate around text like easymotion
    require('config.plug.editing.nvimcomment'), -- toggle comment on current line or selection
}
-- }}}
