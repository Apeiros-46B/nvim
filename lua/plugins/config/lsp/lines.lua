-- config for lsp_lines plugin
-- FIX: these options don't seem to work
vim.diagnostic.config({
    virtual_lines = false, -- disabled by default
    only_current_line = false,
    highlight_whole_line = false,
})

require('lsp_lines').setup()
