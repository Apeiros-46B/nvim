-- LSP servers
-- {{{ imports
local t = table
local lspconfig = require('lspconfig')
local rust_tools = require('rust-tools')
-- }}}

-- {{{ setup
return function(on_attach)

    -- {{{ helpers
    local M = {}

    local function add(server, opts)
        local new_opts = { on_attach = on_attach }

        if server == rust_tools then
            -- if setting up non-lspconfig servers, don't add on_attach
            new_opts = opts
        elseif opts then
            -- add on_attach
            new_opts = vim.tbl_extend('force', opts, new_opts)
        end

        t.insert(M, server.setup(new_opts))
    end
    -- }}}

    -- {{{ no opts
    --> [various web langs] eslint
    add(lspconfig.eslint)

    --> [julia] julials
    add(lspconfig.julials)

    --> [python] pyright
    add(lspconfig.pyright)

    --> [svelte] svelte
    add(lspconfig.svelte)

    --> [typescript] tsserver
    add(lspconfig.tsserver)

    --> [zig] zls
    add(lspconfig.zls)
    -- }}}

    -- {{{ opts
    --> {{{ [rust] rust_analyzer (rust-tools)
    add(require('rust-tools'), {
        tools = {
            autoSetHints = true,
            inlay_hints = {
                right_align = true,
                show_parameter_hints = true,
                parameter_hints_prefix = "",
                other_hints_prefix = "",
            },
        },

        server = {
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy"
                    },
                }
            }
        },
    })
    --> }}}

    --> {{{ [lua] sumneko_lua
    add(lspconfig.sumneko_lua, {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    -- path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global and `awesome`-related globals
                    globals = { 'vim', 'root', 'client', 'awesome', 'screen', 'tag' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file('', true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    })
    --> }}}

    --> {{{ [tex/latex] texlab
    add(lspconfig.texlab, {
        filetypes = {
            'bib',
            'norg',
            'plaintex',
            'tex',
        }
    })
    --> }}}
    -- }}}

    return M
end
-- }}}
