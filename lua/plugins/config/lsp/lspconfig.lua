-- sub-configuration for lspconfig
-- {{{ imports
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local on_attach = require('plugins.config.lsp.on_attach')
-- }}}

-- {{{ mason setup
local servers = {
    'jdtls',
    'lua_ls',
}

mason_lspconfig.setup({
    ensure_installed = servers,
})
-- }}}

-- servers
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

-- {{{ managed by mason
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
                        -- TODO: update this to work with nixos
                        runtimes = {
                            {
                                name = 'JavaSE-1.8',
                                path = '/usr/lib/jvm/java-8-amazon-corretto/',
                            },
                            {
                                name = 'JavaSE-11',
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
})
-- }}}

-- {{{ manual
-- {{{ html
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
-- }}}

-- {{{ lua_ls
add(lspconfig.lua_ls, {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            semantic = {
                variable = false,
            },
            diagnostics = {
                -- recognize globals
                globals = {
                    'vim',                                        -- vim-related globals
                    'awesome', 'client', 'root', 'screen', 'tag', -- awesome-related globals
                },
            },
            workspace = {
                checkThirdParty = 'ApplyInMemory',
            },
            telemetry = { enable = false },
        },
    },

    -- setup neodev
    before_init = require('neodev.lsp').before_init,
})
-- }}}

-- no configs
add(lspconfig.uiua, {})
add(lspconfig.nil_ls, {})
add(lspconfig.clangd, {})
add(lspconfig.glsl_analyzer, {})
-- }}}
