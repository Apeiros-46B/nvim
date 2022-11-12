-- load all packer plugins
require('plug')

-- load keybindings and editor options
require('keymap')
require('options')
require('autocmds')

-- load theme
require('lib.scheme').load_shared_scheme('everforest')

-- load custom highlights
require('highlights')

-- load configurations
require('config.lsp')     -- lsp server config
require('config.plug')    -- plugin config
require('config.modules') -- user contrib files (wip)

-- # vim foldmethod=marker
