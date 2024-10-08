-- PLEASE READ THE FOLLOWING:
--- this runs when editing a buffer with the "uiua" filetype
----- you must put this file in after/ftplugin/ in your own config and name it uiua.vim for this to happen
--- define the filetype "uiua" somewhere, e.g. `vim.filetype.add({ extension = { ua = 'uiua' } })`
--- replace the last line with your own mechanism for calling on_attach (the one here only works for my config)
--- see also the syntax highlighting script in `after/syntax/uiua.vim`
--- for format on save functionality, I use the following snippet elsewhere in my config:
--[=[
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.ua',
    callback = function(_)
        vim.cmd(([[
            silent! !uiua fmt %s
            mkview
            e
            loadview
        ]]):format(vim.fn.expand('<amatch>')))
    end,
})
--]=]

vim.lsp.start({
    name = 'uiua_lsp',
    cmd = { 'uiua', 'lsp' },
})

vim.bo.commentstring = '#%s'

-- this is just for my own config, will not work on others
-- call your on_attach (or don't) your own way
require('plugins.config.lsp.on_attach')(nil, vim.fn.bufnr())
