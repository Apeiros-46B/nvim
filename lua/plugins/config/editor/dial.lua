-- configuration for dial.nvim plugin
-- {{{ imports
local augend = require('dial.augend')
local map    = require('dial.map')
-- }}}

-- {{{ keymaps
local map_opts = { noremap = true, silent = true }
local function keymap(mode, bind, exec)
    vim.api.nvim_set_keymap(mode, bind, exec, map_opts)
end

keymap('n', '<C-a>',  map.inc_normal() )
keymap('n', '<C-x>',  map.dec_normal() )
keymap('v', '<C-a>',  map.inc_visual() )
keymap('v', '<C-x>',  map.dec_visual() )
keymap('v', 'g<C-a>', map.inc_gvisual())
keymap('v', 'g<C-x>', map.dec_gvisual())
-- }}}

-- {{{ augends
require('dial.config').augends:register_group{

}
-- }}}
