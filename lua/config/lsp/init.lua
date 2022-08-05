local setup = require('config.lsp.setup')

return {
	require('config.lsp.lua_lsp')(setup.on_attach),
	require('config.lsp.rust_lsp')(setup.on_attach),
}
