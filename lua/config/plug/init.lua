-- load all plugin configurations
-- {{{ return
return {
    require('config.plug.completion'), -- configs related to completion engine
    require('config.plug.editing'),    -- configs related to general text editing
    require('config.plug.git'),        -- configs related to git plugins
    require('config.plug.lsp'),        -- configs related to lsp plugins
    require('config.plug.ui'),         -- configs related to user interface
    require('config.plug.util'),       -- configs related to other utility plugins
}
-- }}}
