-- sub-configuration for mason.nvim (lspconfig)
-- {{{ imports
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
-- }}}

-- {{{ setup
local servers = {
    'awk_ls',
    'gopls',
    'hls',
    'html',
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
local on_attach = require('plugins.config.lsp.on_attach')

-- {{{ helper
local function add(server, opts)
    local new_opts = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }

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
                        importOrder = { '#', 'java', 'javax', 'lombok', 'org', 'com', 'net', 'io', 'me', 'xyz' }
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
                    auto = true,
                    right_align = false,
                    only_current_line = true,
                    show_parameter_hints = true,
                    parameter_hints_prefix = '<== ',
                    other_hints_prefix = '-> ',
                },
            },

            server = {
                on_attach = on_attach,
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
        })
    end,
    -- }}}

    -- {{{ html
    html = function()
        -- broadcast snippet capabilities for completion
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        add(lspconfig.html, {
            capabilities = capabilities,
            settings = {
                html = {
                    completion = {
                        attributeDefaultValue = 'singlequotes'
                    },
                    format = {
                        indentInnerHtml = true,
                        templating = true,
                        wrapLineLength = 120,
                        wrapAttributes = 'auto',
                    },
                    hover = {
                        documentation = true,
                        references = true,
                    },
                    mirrorCursorOnMatchingTag = true,
                },
            },
        })
    end,
    -- }}}

    -- {{{ julials
    julials = function()
        add(lspconfig.julials, {
            settings = {
                enableTelemetry = false,

                NumThreads = 2,

                completionmode = 'import',
                runtimeCompletions = true,

                lint = {
                    missingrefs = 'all',
                }
            },

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

    -- {{{ lua_ls
    lua_ls = function()
        -- lspconfig server, custom configuration
        add(lspconfig.lua_ls, {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- recognize globals
                        globals = {
                            'vim',                                        -- vim-related globals
                            'awesome', 'client', 'root', 'screen', 'tag', -- awesome-related globals
                            'ipe',
                        },
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },

            -- setup neodev
            before_init = require('neodev.lsp').before_init,
        })
    end,
    -- }}}
})
-- }}}
-- }}}
