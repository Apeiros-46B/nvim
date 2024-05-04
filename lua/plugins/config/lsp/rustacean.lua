-- set rustaceanvim options
vim.g.rustaceanvim = {
    tools = {
        hover_actions = {
            replace_builtin_hover = false,
        },
    },

    server = {
        on_attach = require('plugins.config.lsp.on_attach'),
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = 'clippy'
                },
                imports = {
                    granularity = {
                        enforce = true,
                    },
                    merge = {
                        glob = false,
                    },
                },
                inlayHints = {
                    closureStyle = 'rust_analyzer',
                    expressionAdjustmentHints = {
                        enable = "reborrow",
                    },
                    lifetimeElisionHints = {
                        enable = 'skip-trivial',
                    },
                },
            }
        }
    },
}
