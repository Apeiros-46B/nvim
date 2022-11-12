-- {{{ load plugins
--> incl. dep bootstrap, plugin declarations
require('plug')
-- }}}

-- {{{ load core config
--> autocmds, keymaps, and options
require('config.core')

--> theme library
require('theme').load_both('everforest')
-- }}}

-- {{{ load other config
--> lsp server configurations
require('config.lsp')

--> plugin configurations
require('config.plug')
-- }}}
