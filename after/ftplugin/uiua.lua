vim.lsp.start({
    name = 'uiua_lsp',
    cmd = { 'uiua', 'lsp' },
})

vim.bo.commentstring = '#%s'
