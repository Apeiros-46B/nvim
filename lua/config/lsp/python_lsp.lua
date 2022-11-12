return function(on_attach)
    return require('lspconfig').pyright.setup({ on_attach = on_attach })
end
