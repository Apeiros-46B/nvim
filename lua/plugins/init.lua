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
        -- {{{ [_] plugins that should be loaded before other plugins
        -- impatient
        use({ 'lewis6991/impatient.nvim' })

        -- packer self management
        use({ 'wbthomason/packer.nvim' })

        -- other
        use({ 'nvim-lua/plenary.nvim'        }) -- plenary
        use({ 'nvim-lua/popup.nvim'          }) -- popup
        use({ 'kyazdani42/nvim-web-devicons' }) -- devicons
        use({ 'sainnhe/everforest'           }) -- best theme in existence
        -- }}}

        -- {{{ [completion] plugins related to completion
        -- snippets
        use({
            'sirver/ultisnips',
            event = 'InsertEnter',
            config = function()
                require('plugins.config.completion.ultisnips')
            end
        })

        -- cmp
        use({
            'hrsh7th/nvim-cmp',
            config = function()
                require('plugins.config.completion.cmp')
            end,
            requires = {
                -- cmp sources
                {
                    'hrsh7th/cmp-nvim-lsp',
                    event = 'LspAttach',
                    after = 'nvim-cmp',
                },
                {
                    'hrsh7th/cmp-path',
                    event = 'InsertEnter',
                    after = 'nvim-cmp',
                },
                {
                    'hrsh7th/cmp-buffer',
                    event = 'InsertEnter',
                    after = 'nvim-cmp',
                },
                {
                    'petertriho/cmp-git',
                    event = 'InsertEnter',
                    after = 'nvim-cmp',
                },
                {
                    'quangnguyen30192/cmp-nvim-ultisnips',
                    event = 'InsertEnter',
                    after = 'nvim-cmp',
                },
            }
        })
        -- }}}

        -- {{{ [editor] utility plugins related to core editor functionality
        -- text editing and formatting
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
                require('plugins.config.editor.nvimcomment')
            end,
        })
        use({
            'sbdchd/neoformat',
            cmd = 'Neoformat',
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
        use({ 'jghauser/mkdir.nvim' })
        use({
            'famiu/nvim-reload',
            cmd = 'Reload',
        })
        -- }}}

        -- {{{ [git] plugins related to git
        use({
            'lewis6991/gitsigns.nvim',
            opt = true,
            setup = function()
                require('plugins.lazy').gitsigns()
            end,
            config = function()
                require('plugins.config.git.gitsigns')
            end,
        })
        use({
            'tpope/vim-fugitive',
            cmd = 'Git',
        })
        use({
            'tpope/vim-rhubarb',
            after = 'vim-fugitive',
        })
        -- }}}

        -- {{{ [lsp] plugins related to lsp or debugging
        -- lsp plugins
        use({
            'neovim/nvim-lspconfig',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('nvim-lspconfig')
            end,
            config = function()
                require('plugins.config.lsp.lspconfig')
            end,
        })
        use({
            'onsails/lspkind-nvim',
            after = { 'nvim-cmp', 'nvim-lspconfig' },
            config = function()
                require('plugins.config.lsp.lspkind')
            end,
        })

        -- debugging
        use({
            'mfussenegger/nvim-dap',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('nvim-dap')
            end,
        })

        -- server providers
        use({
            'simrat39/rust-tools.nvim',
            ft = 'rs',
            config = function()
                require('plugins.config.lsp.rust_tools')(vim.g.on_attach)
            end
        })
        use({
            'mfussenegger/nvim-jdtls',
            ft = 'java',
            config = function()
                require('plugins.config.lsp.jdtls')(vim.g.on_attach)
            end
        })

        -- other lsp-related utils
        use({
            'folke/lsp-colors.nvim',
            after = 'lspkind-nvim',
        })
        use({
            'folke/trouble.nvim',
            after = 'lsp-colors.nvim',
            config = function()
                require('plugins.config.lsp.trouble')
            end,
        })
        use({
            'SmiteshP/nvim-navic',
            config = function()
                require('plugins.config.lsp.navic')
            end,
        })
        use({
            'glepnir/lspsaga.nvim',
            after = 'lsp-colors.nvim',
            cmd = 'Lspsaga',
            config = function()
                require('plugins.config.lsp.lspsaga')
            end,
        })
        -- }}}

        -- {{{ [syntax] plugins that add support for file formats or are related to syntax
        -- treesitter
        use({
            'nvim-treesitter/nvim-treesitter',
            -- cmd = lazy.treesitter_cmds,
            -- setup = function()
            --     require('plugins.lazy').on_file_open('nvim-treesitter')
            -- end,
            config = function()
                require('plugins.config.syntax.treesitter')
            end,
            run = ':TSUpdate',
        })

        -- the holy grail
        use({
            'nvim-neorg/neorg',
            ft = 'norg',
            cmd = 'Neorg',
            after = { 'nvim-treesitter', 'nvim-cmp', 'telescope.nvim' },
            requires = { 'nvim-neorg/neorg-telescope' },
            config = function()
                require('plugins.config.syntax.neorg')
            end,
            run = ':Neorg sync-parsers',
        })

        -- literate programming
        use({ 'jbyuki/ntangle.nvim' })
        -- }}}

        -- {{{ [ui] plugins that enhance the user interface
        -- status line
        use({
            'nvim-lualine/lualine.nvim',
            config = function()
                require('plugins.config.ui.lualine')
            end,
        })

        -- keybind help
        use({
            'folke/which-key.nvim',
            ft = 'starter',
            cmd = 'WhichKey',
            keys = { '<leader>', ',', 'g', 'z', [[']] },
            config = function()
                require('plugins.config.ui.which-key')
            end,
        })
        -- }}}

        -- {{{ [util] miscellaneous utilities/other plugins
        -- fuzzy finder
        use({
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
        })
        use({
            'nvim-telescope/telescope.nvim',
            -- ft = 'norg',
            -- cmd = 'Telescope',
            -- after = 'telescope-fzf-native.nvim',
            config = function()
                require('plugins.config.util.telescope')
            end,
        })

        -- other
        use({
            'kyazdani42/nvim-tree.lua',
            ft = 'starter',
            cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
            config = function()
                require('plugins.config.util.nvimtree')
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
            'Apeiros-46B/quickmath.nvim',
            cmd = 'Quickmath',
        })
        use({
            'itchyny/calendar.vim',
            cmd = 'Calendar',
            config = function()
                require('plugins.config.util.calendar')
            end,
        })
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

-- {{{ misc
-- workaround for plugins that need rtp (himalaya)
local packer_compiled = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
cmd('luafile'  .. packer_compiled)
-- }}}
