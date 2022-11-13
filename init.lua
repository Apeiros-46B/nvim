-- initialize configuration
-- {{{ core
-- disable shadafile during core config loading
vim.opt.shadafile = "NONE"

require('core.autocmds') -- autocommands
require('core.keymaps')  -- keymaps
require('core.options')  -- vim options
require('core.theme')    -- theme and colorscheme
require('core.misc')     -- miscellaneous

-- re-enable shadafile after core config loading
vim.opt.shadafile = ""
-- }}}

-- {{{ plugins & lsp
require('core.plugins')  -- load all plugins and lazy-load their configs
                         -- note that lspconfig and related are not lazy-loaded

require('core.lsp')      -- load lsp setup script and language servers
-- }}}
