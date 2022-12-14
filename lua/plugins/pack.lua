-- load packer plugins and lazy-load their configs
-- {{{ imports
local fn = vim.fn
local cmd = vim.cmd
local lazy = require('plugins.lazy')
-- }}}

-- {{{ bootstrapping
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    cmd [[packadd packer.nvim]]
end
-- }}}

-- {{{ setup
local packer = require('packer')

packer.startup({
    -- categories ordered alphabetically (with the exception of core)
    -- plugin within categories ordered by importance
    function(use)
        -- {{{ plugins that should be loaded before other plugins
        -- impatient
        use({ 'lewis6991/impatient.nvim' })

        -- packer self management
        use({ 'wbthomason/packer.nvim' })

        -- other
        use({ 'nvim-lua/plenary.nvim'                  }) -- plenary
        use({ 'nvim-lua/popup.nvim'                    }) -- popup
        use({ 'sainnhe/everforest', commit = 'd855af5' }) -- best theme in existence
        -- }}}

        -- {{{ [completion] plugins related to completion
        -- snippets
        use({
            'sirver/ultisnips',
            event = 'InsertEnter',
            config = function()
                require('plugins.config.completion.ultisnips')
            end,
        })

        -- cmp
        -- do not lazy load, starter and neorg break
        use({
            'hrsh7th/nvim-cmp',
            config = function()
                require('plugins.config.completion.cmp')
            end,
            requires = {
                -- cmp sources
                {
                    'hrsh7th/cmp-buffer',
                    after = 'nvim-cmp',
                    event = 'InsertEnter',
                },
                {
                    'uga-rosa/cmp-dictionary',
                    after = 'nvim-cmp',
                    ft = 'norg',
                    config = function()
                        require('plugins.config.completion.cmp_dictionary')
                    end,
                },
                {
                    'petertriho/cmp-git',
                    after = 'nvim-cmp',
                    event = 'InsertEnter',
                },
                {
                    'hrsh7th/cmp-nvim-lsp',
                    after = 'nvim-cmp',
                    event = 'LspAttach',
                },
                {
                    'quangnguyen30192/cmp-nvim-ultisnips',
                    after = 'nvim-cmp',
                    event = 'InsertEnter',
                },
                {
                    'hrsh7th/cmp-path',
                    after = 'nvim-cmp',
                    event = 'InsertEnter',
                },
            }
        })
        -- }}}

        -- {{{ [editor] utility plugins related to core editor functionality
        -- text editing
        use({
            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            config = function()
                require('plugins.config.editor.autopairs')
            end,
        })
        use({
            'terrortylor/nvim-comment',
            cmd = 'CommentToggle',
            config = function()
                require('plugins.config.editor.comment')
            end,
        })
        use({
            'kylechui/nvim-surround',
            config = function()
                require('plugins.config.editor.surround')
            end,
        })

        -- navigation
        use({
            'phaazon/hop.nvim',
            cmd = lazy.hop_cmds,
            config = function()
                require('plugins.config.editor.hop')
            end,
        })

        -- misc
        use({
            'jghauser/mkdir.nvim',
            cmd = { 'w', 'write' },
        })
        use({
            'nat-418/boole.nvim',
            cmd = 'Boole',
            config = function()
                require('plugins.config.editor.boole')
            end,
        })
        -- use({
        --     'Ron89/thesaurus_query.vim',
        --     ft = { 'markdown', 'norg' },
        -- })
        -- }}}

        -- {{{ [git] plugins related to git
        use({
            'lewis6991/gitsigns.nvim',
            opt = true,
            setup = function()
                require('plugins.lazy').git('gitsigns.nvim')
            end,
            config = function()
                require('plugins.config.git.gitsigns')
            end,
        })
        use({
            'tpope/vim-fugitive',
            cmd = 'Git',
            setup = function()
                require('plugins.lazy').git('vim-fugitive')
            end,
        })
        use({
            'tpope/vim-rhubarb',
            opt = true,
            setup = function()
                require('plugins.lazy').git('vim-rhubarb')
            end,
        })
        -- }}}

        -- {{{ [lsp] plugins related to lsp, dap, or linters
        -- core
        use({
            'neovim/nvim-lspconfig',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('nvim-lspconfig')
            end,
        })

        -- null-ls
        use({
            'jose-elias-alvarez/null-ls.nvim',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('null-ls.nvim')
            end,
        })

        -- mason
        --> main
        use({
            'williamboman/mason.nvim',
            opt = true,
            cmd = 'Mason',
            after = { 'mason-lspconfig.nvim', 'mason-null-ls.nvim' },
            setup = function()
                require('plugins.lazy').on_file_open('mason.nvim')
            end,
            config = function()
                require('plugins.config.lsp.mason')
            end,
        })
        --> lspconfig
        use({
            'williamboman/mason-lspconfig.nvim',
            after = 'nvim-lspconfig',
        })
        --> null-ls
        use({
            'jay-babu/mason-null-ls.nvim',
            after = 'null-ls.nvim',
        })

        -- dap
        use({
            'mfussenegger/nvim-dap',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('nvim-dap')
            end,
        })

        -- plugins to enhance specific servers
        -- loaded using mason, no loading or config done here
        use({ 'simrat39/rust-tools.nvim', opt = true })
        use({ 'mfussenegger/nvim-jdtls',  opt = true })

        -- other lsp-related
        use({
            'onsails/lspkind-nvim',
            after = { 'nvim-cmp', 'nvim-lspconfig' },
            config = function()
                ---@diagnostic disable-next-line: different-requires
                require('plugins.config.lsp.lspkind')
            end,
        })
        use({
            'folke/lsp-colors.nvim',
            after = 'lspkind-nvim',
        })
        use({
            'folke/trouble.nvim',
            event = 'LspAttach',
            cmd = { 'Trouble', 'TroubleToggle' },
            config = function()
                require('plugins.config.lsp.trouble')
            end,
        })
        use({
            'glepnir/lspsaga.nvim',
            event = 'LspAttach',
            cmd = 'Lspsaga',
            config = function()
                require('plugins.config.lsp.lspsaga')
            end,
        })

        use({
            'SmiteshP/nvim-navic',
            event = 'LspAttach',
            config = function()
                require('plugins.config.lsp.navic')
            end,
        })
        -- }}}

        -- {{{ [syntax] plugins for file formats or syntax (esp. highlighting)
        -- treesitter
        -- do not lazy-load, neorg breaks
        use({
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require('plugins.config.syntax.treesitter')
            end,
            run = ':TSUpdate',
        })
        use({ 'nvim-treesitter/nvim-treesitter-textobjects' })

        -- the holy grail
        use({
            'nvim-neorg/neorg',
            ft = 'norg',
            requires = { 'nvim-neorg/neorg-telescope' },
            config = function()
                require('plugins.config.syntax.neorg')
            end,
            run = ':Neorg sync-parsers',
        })

        -- dimming & highlighting items
        use({
            'zbirenbaum/neodim',
            event = 'LspAttach',
            config = function()
                require('plugins.config.syntax.neodim')
            end,
        })
        use({
            'RRethy/vim-illuminate',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('vim-illuminate')
            end,
            config = function()
                require('plugins.config.syntax.illuminate')
            end,
        })

        -- other
        use({
            'folke/todo-comments.nvim',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('todo-comments.nvim')
            end,
            config = function()
                require('plugins.config.syntax.todo_comments')
            end,
        })
        -- }}}

        -- {{{ [ui] plugins that enhance the user interface
        -- devicons
        use({
            'kyazdani42/nvim-web-devicons',
            ft = 'TelescopePrompt',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('nvim-web-devicons')
            end,
            config = function()
                require('plugins.config.ui.devicons')
            end,
        })

        -- status line
        use({
            'nvim-lualine/lualine.nvim',
            config = function()
                require('plugins.config.ui.lualine')
            end,
        })

        -- scrollbar
        use({
            'kensyo/nvim-scrlbkun',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('nvim-scrlbkun')
            end,
            config = function()
                require('plugins.config.ui.scrlbkun')
            end,
        })

        -- keybind help
        use({
            'folke/which-key.nvim',
            cmd = 'WhichKey',
            keys = { '<leader>', ',', 'g', 'z', [[']] },
            config = function()
                require('plugins.config.ui.which_key')
            end,
        })
        -- }}}

        -- {{{ [util] miscellaneous utilities/other plugins
        -- telescope & extensions
        -- do not lazy load, neorg breaks
        use({
            'nvim-telescope/telescope.nvim',
            config = function()
                require('plugins.config.util.telescope')
            end,
        })
        use({
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
        })
        --> extensions
        use({
            'rudism/telescope-dict.nvim',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('telescope-dict.nvim')
            end
        })

        -- other
        use({
            'kyazdani42/nvim-tree.lua',
            cmd = { 'NvimTreeFocus', 'NvimTreeToggle', 'NvimTreeOpen' },
            config = function()
                require('plugins.config.util.nvimtree')

                -- load devicons if not yet loaded
                require('packer').loader('nvim-web-devicons')
            end,
        })
        use({
            'echasnovski/mini.nvim', -- note that modules in other categories are loaded here
            config = function()
                require('plugins.config.ui.mini_starter')        -- starter
                require('plugins.config.ui.mini_tabline')        -- tabline
                require('plugins.config.editor.mini_trailspace') -- trailspace
            end,
        })
        use({
            'jbyuki/quickmath.nvim',
            cmd = 'Quickmath',
        })
        use({
            'itchyny/calendar.vim',
            cmd = 'Calendar',
            config = function()
                require('plugins.config.util.calendar')
            end,
        })
        use {
            'NFrid/due.nvim',
            ft = 'norg',
            config = function()
                require('plugins.config.util.due')
            end,
        }
        -- }}}

        -- {{{ bootstrapping
        if packer_bootstrap then
            packer.sync()
        end
        -- }}}
    end,

    -- {{{ packer config
    config = {
        display = {
            -- display packer dialogue in the center in a floating window
            open_fn = require('packer.util').float,
        },
    },
    -- }}}
})
-- }}}
