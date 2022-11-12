local setup = require('setup')

-- setup all lsp servers
return require('servers')(setup.on_attach)
