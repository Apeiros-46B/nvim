return function(on_attach)
    return require('lspconfig').texlab.setup({
        filetypes = { 'tex', 'plaintex', 'bib', 'norg' },
        on_attach = on_attach,
    })
end
