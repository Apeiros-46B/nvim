-- setup all lsp servers
-- {{{ setup
local setup = require('plugins.config.lsp.lspconfig.setup')
vim.g.on_attach = setup.on_attach

return require('plugins.config.lsp.lspconfig.servers')(setup.on_attach)
-- }}}
