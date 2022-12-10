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
        use({ 'nvim-lua/plenary.nvim'                  }) -- plenary
        use({ 'nvim-lua/popup.nvim'                    }) -- popup
        use({ 'kyazdani42/nvim-web-devicons'           }) -- devicons
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
        use({
            'hrsh7th/nvim-cmp',
            -- this breaks things
            -- event = 'InsertEnter',
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
        use({
            'Ron89/thesaurus_query.vim',
            ft = { 'markdown', 'norg' },
            cmd = {
                'Thesaurus',
                'ThesaurusQueryLookupCurrentWord',
                'ThesaurusQueryReplace',
                'ThesaurusQueryReplaceCurrentWord',
                'ThesaurusQueryReset',
            },
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

        -- {{{ [lsp] plugins related to lsp, dap, or linters
        -- core
        use({
            'neovim/nvim-lspconfig',
            opt = true,
            setup = function()
                require('plugins.lazy').on_file_open('nvim-lspconfig')
            end,
        })

        -- mason
        use({
            'williamboman/mason-lspconfig.nvim',
            after = 'nvim-lspconfig',
        })
        use({
            'williamboman/mason.nvim',
            opt = true,
            after = 'mason-lspconfig.nvim',
            setup = function()
                require('plugins.lazy').on_file_open('mason.nvim')
            end,
            config = function()
                require('plugins.config.lsp.mason')
            end,
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
        -- `opt = true` because loaded using mason
        use({ 'simrat39/rust-tools.nvim', opt = true })

        -- other lsp-related
        use({
            'onsails/lspkind-nvim',
            after = { 'nvim-cmp', 'nvim-lspconfig' },
            config = function()
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

        -- not lazy-loaded because required by lualine
        -- figure out how to lazy-load later
        use({
            'SmiteshP/nvim-navic',
            config = function()
                require('plugins.config.lsp.navic')
            end,
        })
        -- }}}

        -- {{{ [syntax] plugins for file formats or syntax (esp. highlighting)
        -- treesitter
        use({
            'nvim-treesitter/nvim-treesitter',
            -- this breaks things
            -- cmd = lazy.treesitter_cmds,
            -- setup = function()
            --     require('plugins.lazy').on_file_open('nvim-treesitter')
            -- end,
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
            after = { 'nvim-treesitter', 'nvim-cmp', 'telescope.nvim' },
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
            config = function()
                require('plugins.config.ui.scrlbkun')
            end,
        })

        -- keybind help
        use({
            'folke/which-key.nvim',
            ft = 'starter',
            cmd = 'WhichKey',
            keys = { '<leader>', ',', 'g', 'z', [[']] },
            config = function()
                require('plugins.config.ui.which_key')
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
            -- this breaks things
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
            cmd = { 'NvimTreeFocus', 'NvimTreeToggle', 'NvimTreeOpen' },
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

-- {{{ misc
-- workaround for plugins that need rtp (himalaya)
local packer_compiled = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
cmd('luafile'  .. packer_compiled)
-- }}}
