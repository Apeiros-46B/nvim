-- zk config
require('zk').setup({
    picker = 'telescope',

    lsp = {
        config = {
            cmd = { 'zk', 'lsp' },
            name = 'zk',
            on_attach = require('plugins.config.lsp.on_attach'),
        },

        auto_attach = {
            enabled = true,
            filetypes = { 'norg' },
        }
    }
})
