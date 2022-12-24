-- main configuration for mason.nvim
-- {{{ imports
-- main
local api    = vim.api
local mason  = require('mason')
local packer = require('packer')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ main
mason.setup({
    install_root_dir = vim.fn.stdpath('data') .. '/mason',
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
            package_installed   = '',
            package_pending     = '-',
            package_uninstalled = '×',
        },

        keymaps = {
            toggle_package_expand   = '<CR>',
            install_package         = 'i',
            update_package          = 'u',
            check_package_version   = 'c',
            update_all_packages     = 'U',
            check_outdated_packages = 'C',
            uninstall_package       = 'd',
            cancel_installation     = '<C-c>',
            apply_language_filter   = '<C-f>',
        },
    },
})
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

    buf_map('n', '<leader>lh', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_map('n', '<leader>ll', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

    buf_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

    buf_map('n', '<leader>lF', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
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

    -- attach navic if not null-ls
    if client.name ~= 'null-ls' then require('nvim-navic').attach(client, bufnr) end

    -- notify the user that the client has been attached
    vim.notify(string.format([[[LSP] attached client '%s']], client.name), 'INFO')
    -- }}}
end
-- }}}

-- {{{ lspconfig
-- load lspconfig if it isn't already
if not packer_plugins['nvim-lspconfig'] then
    packer.loader('nvim-lspconfig')
end

require('plugins.config.lsp.lspconfig')(on_attach)
-- }}}

-- {{{ null-ls
-- load null-ls if it isn't already
if not packer_plugins['null-ls.nvim'] then
    packer.loader('null-ls.nvim')
end

require('plugins.config.lsp.null_ls')(on_attach)
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
