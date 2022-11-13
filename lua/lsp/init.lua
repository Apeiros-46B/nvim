-- setup all lsp servers
local setup = require('setup')
return require('servers')(setup.on_attach)
