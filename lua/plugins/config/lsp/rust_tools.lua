-- setup rust-tools (rust_analyzer)
return function(on_attach)
    return require('rust-tools').setup({
        tools = {
            autoSetHints = true,
            inlay_hints = {
                right_align = true,
                show_parameter_hints = true,
                parameter_hints_prefix = '',
                other_hints_prefix = '',
            },
        },

        server = {
            on_attach = on_attach,
            settings = {
                ['rust-analyzer'] = {
                    checkOnSave = {
                        command = 'clippy'
                    },
                }
            }
        },
    })
end
