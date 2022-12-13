-- sub-configuration for mason.nvim (lspconfig)
-- {{{ imports
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
-- }}}

return function(on_attach)
    -- {{{ setup
    local servers = {
        'jdtls',
        'julials',
        'sumneko_lua',
        'pyright',
        'rust_analyzer',
        'texlab',
        'zls',
    }

    mason_lspconfig.setup({
        ensure_installed = servers,
    })
    -- }}}

    -- {{{ handlers
    -- {{{ helper
    local function add_lspconfig(server, opts)
        local new_opts = { on_attach = on_attach }

        if opts then
            -- add on_attach
            new_opts = vim.tbl_extend('force', opts, new_opts)
        end

        server.setup(new_opts)
    end
    -- }}}

    -- {{{ setup
    mason_lspconfig.setup_handlers({
        -- {{{ default
        function(server_name)
            add_lspconfig(lspconfig[server_name])
        end,
        -- }}}

        -- {{{ [nvim-jdtls] jdtls
        jdtls = function()
            if vim.bo.filetype ~= 'java' then return end

            -- load nvim-jdtls
            require('packer').loader('nvim-jdtls')

            -- start
            local config = {
                cmd = { vim.fn.stdpath('data') .. '/mason/bin/jdtls' },
                root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

                settings = {
                    java = {
                        completion = {
                            importOrder = { '#', 'java', 'javax', 'lombok', 'org', 'com', 'net', 'io', 'me' }
                        },

                        contentProvider = { preferred = 'fernflower' },

                        ['eclipse.downloadSources'] = true,
                        ['maven.downloadSources'  ] = true,

                        sources = {
                            organizeImports = {
                                starThreshold = 9999,
                                staticStarThreshold = 9999,
                            },
                        },
                    },
                },

                on_attach = on_attach,
            }

            require('jdtls').start_or_attach(config)

            -- attach to newly opened java buffers
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function()
                    if not vim.lsp.buf_is_attached() then
                        require('jdtls').start_or_attach(config)
                    end
                end
            })
        end,
        -- }}}

        -- {{{ [rust-tools] rust-analyzer
        rust_analyzer = function()
            -- load rust-tools
            require('packer').loader('rust-tools.nvim')

            -- setup
            require('rust-tools').setup({
                tools = {
                    autoSetHints = true,
                    inlay_hints = {
                        right_align = false,
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
        end,
        -- }}}

        -- {{{ sumneko_lua
        sumneko_lua = function()
            -- lspconfig server, custom configuration
            add_lspconfig(lspconfig.sumneko_lua, {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            -- path = runtime_path,
                        },
                        diagnostics = {
                            -- recognize globals
                            globals = {
                                'vim', 'packer_plugins',                     -- vim-related globals
                                'awesome', 'client', 'root', 'screen', 'tag' -- awesome-related globals
                            },
                        },
                        workspace = {
                            -- library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = { enable = false },
                    },
                },
            })
        end,
        -- }}}

        -- {{{ texlab
        texlab = function()
            -- lspconfig server, custom configuration
            add_lspconfig(lspconfig.texlab, {
                filetypes = {
                    'bib',
                    'norg', -- make it work in Neorg files
                    'plaintex',
                    'tex',
                }
            })
        end
        -- }}}
    })
    -- }}}
    -- }}}
end
