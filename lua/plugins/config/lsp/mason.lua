-- main configuration for mason.nvim
return function(theme)
    -- {{{ imports
    local api    = vim.api
    local colors = theme.colors
    local mason  = require('mason')
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

    -- {{{ subconfigs
    -- neodev
    require('plugins.config.lsp.neodev')

    -- lspconfig
    require('plugins.config.lsp.lspconfig')

    -- null-ls
    require('plugins.config.lsp.null_ls')
    -- }}}

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        MasonError           = { fg = colors.red },

        MasonHeader          = { bg = colors.green , fg = colors.gray1, bold = true },
        MasonHeaderSecondary = { bg = colors.yellow, fg = colors.gray1, bold = true },

        MasonHeading         = { bold = true },

        MasonLink            = { bg = colors.blue, underline = true },
        MasonNormal          = { bg = colors.gray2                  },

        MasonMuted           = { fg = colors.gray8              },
        MasonMutedBlock      = { bg = colors.gray3,             },
        MasonMutedBlockBold  = { bg = colors.gray3, bold = true },

        MasonHighlight                   = { fg = colors.green                                  },
        MasonHighlightSecondary          = { fg = colors.teal                                   },
        MasonHighlightBlock              = { bg = colors.green,  fg = colors.gray1              },
        MasonHighlightBlockSecondary     = { bg = colors.yellow, fg = colors.gray1              },
        MasonHighlightBlockBold          = { bg = colors.green,  fg = colors.gray1, bold = true },
        MasonHighlightBlockBoldSecondary = { bg = colors.yellow, fg = colors.gray1, bold = true },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}
end
