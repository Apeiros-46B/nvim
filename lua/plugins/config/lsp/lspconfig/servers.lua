-- define and set opts for lsp servers
-- {{{ imports
local t = table
local lspconfig = require('lspconfig')
-- }}}

-- {{{ setup
return function(on_attach)
    -- {{{ helper
    local function add(server, opts)
        local new_opts = { on_attach = on_attach }

        if opts then
            -- add on_attach
            new_opts = vim.tbl_extend('force', opts, new_opts)
        end

        server.setup(new_opts)
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
                    -- library = vim.api.nvim_get_runtime_file('', true),
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
end
-- }}}
