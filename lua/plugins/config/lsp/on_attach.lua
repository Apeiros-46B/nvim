-- on_attach function

local navic_deny = { ['null-ls'] = true, ['glsl_analyzer'] = true, ['uiua'] = true }
local semantic_tokens_allow = { ['rust-analyzer'] = true }

return function(client, bufnr)
    -- {{{ helpers
    local function buf_map(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- }}}

    -- {{{ mappings
    local opts = { noremap = true, silent = true }

    buf_map('n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_map('n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_map('n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_map('n', '<leader>lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    buf_map('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_map('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_map('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    buf_map('n', '<leader>lR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_map('n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_map('n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

    buf_map('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    buf_map('n', '<leader>lF', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
    -- }}}

    -- {{{ other
    if client then
        if not navic_deny[client.name] then
            require('nvim-navic').attach(client, bufnr)
            require('nvim-navbuddy').attach(client, bufnr)
        end

        if not semantic_tokens_allow[client.name] then
            client.server_capabilities.semanticTokensProvider = {}
        end
    end
    -- }}}
end
