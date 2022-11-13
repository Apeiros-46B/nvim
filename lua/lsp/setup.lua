-- define LSP setup script
-- {{{ imports
local fn = vim.fn
local api = vim.api
-- }}}

-- {{{ on_attach
local on_attach = function(client, bufnr)

    -- {{{ helpers
    local function buf_map(...)
        api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_opt(...)
        api.nvim_buf_set_option(bufnr, ...)
    end
    -- }}}

    -- {{{ mappings
    local opts = { noremap = true, silent = true }

    buf_map('n', '<leader>lgD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_map('n', '<leader>lgd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_map('n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_map('n', '<leader>lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    buf_map('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_map('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_map('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    buf_map('n', '<leader>lR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_map('n', '<leader>lh', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_map('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- }}}

    -- {{{ mappings dependent on server capabilities
    if client.server_capabilities.document_formatting then
        buf_map('n', '<leader>Ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    elseif client.server_capabilities.document_range_formatting then
        buf_map('n', '<leader>Ff', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    end
    -- }}}

    -- {{{ autocommands dependent on server capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
-- }}}

    -- {{{ other
    -- omnifunc
    buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- attach navic
    require('nvim-navic').attach(client, bufnr)

    -- notify the user that the client has been attached
    vim.notify(string.format([[[LSP] attached client '%s']], client.name), 'INFO')
    -- }}}

end
-- }}}

-- {{{ standard paths for lsp servers
-- check if lspservers directory exists in data stdpath
-- and create one if not
local lspserver_dir = fn.isdirectory(fn.stdpath('data') .. '/lspservers')
if lspserver_dir == 0 then
    fn.mkdir(fn.stdpath('data') .. '/lspservers')
end
-- }}}

-- {{{ return
return { on_attach = on_attach, lspserver_dir = lspserver_dir }
-- }}}
