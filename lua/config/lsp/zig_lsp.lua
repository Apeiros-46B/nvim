return function(on_attach)
    return require('lspconfig').zls.setup({ on_attach = on_attach })
end
