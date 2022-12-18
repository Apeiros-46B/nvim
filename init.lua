-- initialize configuration
-- {{{ impatient
vim.defer_fn(function()
    pcall(require, 'impatient')
end, 0)
-- }}}

-- {{{ core
--> disable shadafile during core config loading
vim.opt.shadafile = 'NONE'

--> autocommands
require('core.autocmds')

--> keymaps and bindings
require('core.keymaps')

--> general vim options
require('core.options')

--> theme/colorscheme
require('core.theme')

--> miscellaneous utils
require('core.util')

--> re-enable shadafile
vim.opt.shadafile = ''
-- }}}

-- {{{ plugins
--> lazy-load plugins and their configs
require('plugins.pack')
-- }}}
