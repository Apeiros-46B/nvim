-- load all other configs
-- {{{ return
return {
    require('config.plug.util.calendar'),        -- calendar
    require('config.plug.util.mini_trailspace'), -- [mini.nvim] detect and remove trailing spaces
    require('config.plug.util.neorg'),           -- norg document format and organizational tools
    require('config.plug.util.nvimtree'),        -- file tree as a left pane
    require('config.plug.util.presence'),        -- discord rich presence
    require('config.plug.util.telescope'),       -- telescope fuzzy finder/picker
    require('config.plug.util.treesitter'),      -- treesitter
    require('config.plug.util.which-key'),       -- popup to remind the user of keybinds (TODO?: replace with hydra.nvim)
}
-- }}}
