-- sub-configuration for mason.nvim (lspconfig)
-- {{{ imports
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
-- }}}

return function(on_attach)
    -- {{{ setup
    local servers = {
        'awk_ls',
        'gopls',
        'jdtls',
        'julials',
        'pyright',
        'lua_ls',
        'svelte',
        'tsserver',
        'rust_analyzer',
        'zls',
    }

    mason_lspconfig.setup({
        ensure_installed = servers,
    })
    -- }}}

    -- {{{ handlers
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

    -- {{{ setup
    mason_lspconfig.setup_handlers({
        -- {{{ default
        function(server_name)
            add(lspconfig[server_name])
        end,
        -- }}}

        -- {{{ [nvim-jdtls] jdtls
        jdtls = function()
            if vim.bo.filetype ~= 'java' then return end

            -- start
            local config = {
                cmd = { vim.fn.stdpath('data') .. '/mason/bin/jdtls' },
                root_dir = require('jdtls.setup').find_root({ '.git', '.idea', '.jdtlsroot', 'mvnw', 'gradlew', 'pom.xml' }),

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

                        configuration = {
                            runtimes = {
                                {
                                    name = 'JavaSE-1.8',
                                    path = '/usr/lib/jvm/java-8-amazon-corretto/',
                                },
                                {
                                    name = 'JavaSE-16',
                                    path = '/usr/lib/jvm/java-16-amazon-corretto/',
                                },
                                {
                                    name = 'JavaSE-17',
                                    path = '/usr/lib/jvm/java-17-amazon-corretto/',
                                },
                            }
                        }
                    },
                },

                on_attach = on_attach,
            }

            require('jdtls').start_or_attach(config)

            -- attach to newly opened java buffers
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function()
                    require('jdtls').start_or_attach(config)
                end
            })
        end,
        -- }}}

        -- {{{ [rust-tools] rust-analyzer
        rust_analyzer = function()
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

        -- {{{ julials
        julials = function()
            add(lspconfig.julials, {
                on_new_config = function(new_config, _)
                    -- custom julia executable
                    local julia = os.getenv('HOME') .. '/.julia/environments/nvim-lspconfig/bin/julia'

                    if lspconfig.util.path.is_file(julia) then
                        new_config.cmd[1] = julia
                    else
                        vim.notify('follow instructions @ https://discourse.julialang.org/t/neovim-languageserver-jl/37286/83 for instant startup')
                    end
                end
            })
        end,
        -- }}}

        -- {{{ sumneko_lua
        lua_ls = function()
            -- lspconfig server, custom configuration
            add(lspconfig.sumneko_lua, {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- recognize globals
                            globals = {
                                'vim',                                       -- vim-related globals
                                'awesome', 'client', 'root', 'screen', 'tag' -- awesome-related globals
                            },
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })
        end,
        -- }}}
    })
    -- }}}
    -- }}}
end
