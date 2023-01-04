-- sub-configuration for mason.nvim (null-ls)
-- {{{ imports
local null_ls = require('null-ls')
local mason_null_ls = require('mason-null-ls')
-- }}}

return function(on_attach)
    -- {{{ setup null-ls and sources
    local builtins = null_ls.builtins

    null_ls.setup({
        -- debug = true,
        -- log_level = "trace",
        on_attach = on_attach,
        fallback_severity = vim.diagnostic.severity.ERROR,
        sources = {
            -- spelling
            builtins.diagnostics.codespell.with({ filetypes = { 'markdown', 'norg', 'tex' } }),
            builtins.formatting .codespell.with({ filetypes = { 'markdown', 'norg', 'tex' } }),

            builtins.diagnostics.shellcheck,
            builtins.formatting.shfmt,
        },
    })
    -- }}}

    -- {{{ setup automatic installation
    mason_null_ls.setup({
        ensure_installed = nil,
        automatic_installation = true,
        automatic_setup = false,
    })
    -- }}}
end
