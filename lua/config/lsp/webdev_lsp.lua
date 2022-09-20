return function(on_attach)
    -- ts
    require('lspconfig').tsserver.setup({ on_attach = on_attach })

    -- svelte
    require('lspconfig').svelte.setup({ on_attach = on_attach })

    -- eslint
    require('lspconfig').eslint.setup({ on_attach = on_attach })
end
