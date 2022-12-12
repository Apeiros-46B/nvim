-- configuration for mason.nvim package manager
-- {{{ imports
-- main
local api   = vim.api
local mason = require('mason')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ on_attach
local function on_attach(client, bufnr)
    -- {{{ helpers
    local function buf_map(...)
        api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_opt(...)
        api.nvim_buf_set_option(bufnr, ...)
    end
    -- }}}

    -- {{{ mappings
    local opts = { noremap = true, silent = true }

    buf_map('n', '<leader>lgD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_map('n', '<leader>lgd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_map('n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_map('n', '<leader>lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    buf_map('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_map('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_map('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    buf_map('n', '<leader>lR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_map('n', '<leader>lh', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_map('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- }}}

    -- {{{ mappings dependent on server capabilities
    if client.server_capabilities.document_formatting then
        buf_map('n', '<leader>Ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    elseif client.server_capabilities.document_range_formatting then
        buf_map('n', '<leader>Ff', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    end
    -- }}}

    -- {{{ autocommands dependent on server capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
    -- }}}

    -- {{{ other
    -- omnifunc
    buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- attach navic
    require('nvim-navic').attach(client, bufnr)

    -- notify the user that the client has been attached
    vim.notify(string.format([[[LSP] attached client '%s']], client.name), 'INFO')
    -- }}}
end
-- }}}

-- {{{ setup
-- {{{ main
local install_root_dir = vim.fn.stdpath('data') .. '/mason'

mason.setup({
    install_root_dir = install_root_dir,
    PATH             = 'prepend',

    log_level                 = vim.log.levels.INFO,
    max_concurrent_installers = 4,

    pip = {
        upgrade_pip = false,
        install_args = {},
    },

    github = {
        -- The template URL to use when downloading assets from GitHub.
        -- The placeholders are the following (in order):
        -- 1. The repository (e.g. 'rust-lang/rust-analyzer')
        -- 2. The release version (e.g. 'v0.3.0')
        -- 3. The asset name (e.g. 'rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz')
        download_url_template = 'https://github.com/%s/releases/download/%s/%s',
    },

    providers = { 'mason.providers.registry-api' },

    ui = {
        check_outdated_packages_on_open = true,

        border = 'none',

        icons = {
            package_installed = '',
            package_pending = '-',
            package_uninstalled = '×',
        },

        keymaps = {
            toggle_package_expand = '<CR>',
            install_package = 'i',
            update_package = 'u',
            check_package_version = 'c',
            update_all_packages = 'U',
            check_outdated_packages = 'C',
            uninstall_package = 'd',
            cancel_installation = '<C-c>',
            apply_language_filter = '<C-f>',
        },
    },
})
-- }}}

-- {{{ lspconfig
local mason_lspconfig = require('mason-lspconfig')

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
local lspconfig = require('lspconfig')

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
            cmd = { install_root_dir .. '/bin/jdtls' },
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
                            'vim',                                       -- vim-related globals
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
-- }}}

-- {{{ null-ls
local null_ls = require('null-ls')
local mason_null_ls = require('mason-null-ls')

-- {{{ null-ls setup
local builtins = null_ls.builtins

null_ls.setup({
    sources = {
        builtins.diagnostics.proselint.with({
            extra_filetypes = { 'norg' },
        }),
        builtins.diagnostics.shellcheck,

        builtins.formatting.shfmt,
        builtins.formatting.stylua,
    },
})
-- }}}

-- {{{ setup
mason_null_ls.setup({
    ensure_installed = nil,
    automatic_installation = true,
	automatic_setup = false,
})
-- }}}
-- }}}
-- }}}

-- {{{ custom highlights
local set_hl = vim.api.nvim_set_hl

local hl = {
    MasonError           = { fg = colors.red },

    MasonHeader          = { bg = colors.green , fg = colors.gray1, bold = true },
    MasonHeaderSecondary = { bg = colors.yellow, fg = colors.gray1, bold = true },

    MasonHeading         = { bold = true },

    MasonLink            = { bg = colors.blue, underline = true },
    MasonNormal          = { bg = colors.gray3                  },

    MasonMuted           = { fg = colors.gray8              },
    MasonMutedBlock      = { bg = colors.gray4,             },
    MasonMutedBlockBold  = { bg = colors.gray4, bold = true },

    MasonHighlight                   = { fg = colors.green                                  },
    MasonHighlightSecondary          = { fg = colors.teal                                   },
    MasonHighlightBlock              = { bg = colors.green,  fg = colors.gray1              },
    MasonHighlightBlockSecondary     = { bg = colors.yellow, fg = colors.gray1              },
    MasonHighlightBlockBold          = { bg = colors.green,  fg = colors.gray1, bold = true },
    MasonHighlightBlockBoldSecondary = { bg = colors.yellow, fg = colors.gray1, bold = true },
}

for k, v in pairs(hl) do set_hl(0, k, v) end
-- }}}
