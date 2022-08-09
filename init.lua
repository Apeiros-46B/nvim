-- load all packer plugins
require('plug')

-- load keybindings and editor options
require('keymap')
require('options')
require('autocmds')

-- load theme loading library
local scheme = require('lib.scheme')

-- load theme
-- scheme.load_scheme('everforest')
-- scheme.load_lualine_scheme('everforest')
scheme.load_shared_scheme('everforest')

-- load configurations
require('config.lsp') -- lsp server config
require('config.plug') -- plugin config
require('config.modules') -- user contrib files (wip)

-- # vim foldmethod=marker
