-- configuration file for neodev.nvim plugin
require('neodev').setup({
    library = {
        enabled = true,
        runtime = true,
        types   = true,
        plugins = { 'nvim-treesitter', 'plenary.nvim', 'telescope.nvim' },
    },
    setup_jsonls = false,
    lspconfig = false,
})
