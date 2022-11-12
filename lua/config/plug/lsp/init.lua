-- load all configs related to lsp plugins
--> NOTE: lsp servers are handled in `lua/config/lsp`
-- {{{ return
return {
    require('config.plug.lsp.lspkind'), -- vscode-like pictograms
    require('config.plug.lsp.lspsaga'), -- lsp-related utilities
    require('config.plug.lsp.trouble'), -- diagnostic overview panel
}
-- }}}
