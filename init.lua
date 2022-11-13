-- initialize configuration
-- {{{ core
-- disable shadafile during core config loading
vim.opt.shadafile = 'NONE'

require('core.autocmds') -- autocommands
require('core.keymaps')  -- keymaps & bindings
require('core.options')  -- general vim options
require('core.theme')    -- theme / colorscheme
require('core.util')     -- miscellaneous utils

-- re-enable shadafile after core config loading
vim.opt.shadafile = ''
-- }}}

-- {{{ plugins & lsp
require('plugins')  -- all plugins & TODO: lazy-loaded configs
require('lsp')      -- lsp setup script & language servers
-- }}}
