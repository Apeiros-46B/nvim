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
            -- {{{ for documents
            -- write good
            builtins.diagnostics.write_good.with({
                extra_filetypes = { 'norg', 'tex' },
                -- disable some checks
                args = { '--no-passive', '--no-adverb', '--text=$TEXT', '--parse' },
            }),

            -- TODO: fix proselint saying resource not available
            -- builtins.diagnostics.proselint.with({
            --     extra_filetypes = { 'norg' },
            -- }),

            -- TODO: get textlint working
            -- builtins.diagnostics.textlint.with({
            --     extra_filetypes = { 'norg', 'tex' }
            -- }),

            -- spelling
            builtins.diagnostics.codespell.with({
                filetypes = { 'markdown', 'norg', 'tex' }
            }),
            builtins.formatting.codespell.with({
                filetypes = { 'markdown', 'norg', 'tex' }
            }),
            -- }}}

            -- {{{ for code
            builtins.diagnostics.shellcheck,
            builtins.formatting.shfmt,
            -- }}}
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
