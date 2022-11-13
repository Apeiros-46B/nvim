-- {{{ bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end
-- }}}

-- {{{ packer
local packer = require('packer')
packer.startup({
	function(use)
		-- packer self management
		use('wbthomason/packer.nvim')

		-- {{{ lsp/autocompletion/snippets
		-- lsp plugins
		use({ 'neovim/nvim-lspconfig' })
		use({ 'onsails/lspkind-nvim' })

        -- language servers
        use({ 'mfussenegger/nvim-jdtls' })
        use({ 'simrat39/rust-tools.nvim' })

        -- debugging
        use({ 'mfussenegger/nvim-dap' })

		-- autocompletion
		use({
			'hrsh7th/nvim-cmp',
			requires = {
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'hrsh7th/cmp-path' },
				{ 'hrsh7th/cmp-buffer' },
			},
		})

        use({ 'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim' })

		-- snippets
		use({ 'sirver/ultisnips' })
		use({ 'quangnguyen30192/cmp-nvim-ultisnips' })

        -- lsp-related utils
        use({ 'folke/lsp-colors.nvim' })
        use({ 'glepnir/lspsaga.nvim' })
        use({ 'SmiteshP/nvim-navic' })
        use({ 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' })
		-- }}}

		-- {{{ utility plugins
		-- status line
		use({
            'nvim-lualine/lualine.nvim', requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true
            },
        })

        -- tabline
		-- use({ 'kdheepak/tabline.nvim' })

        -- fuzzy finder
		use({
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' }
            },
        })

        -- other
		use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })
		use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
		use({ 'windwp/nvim-autopairs' })
		use({ 'terrortylor/nvim-comment' })
		use({ 'sbdchd/neoformat' })
		use({ 'phaazon/hop.nvim' })
        use({ 'jghauser/mkdir.nvim' })
        use({ 'folke/which-key.nvim' })
        use({ 'echasnovski/mini.nvim' })
        use({ 'itchyny/calendar.vim' })
        use({ 'famiu/nvim-reload' })
        use({ 'soywod/himalaya' })
        use({ 'jbyuki/quickmath.nvim' })

        -- #3a454a
        -- #384348
		-- }}}

        -- {{{ git plugins
		use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } })
        use({ 'tpope/vim-fugitive' })
        use({ 'tpope/vim-rhubarb' })
        -- }}}

        -- {{{ improved syntax plugins
        -- treesitter
		use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

        -- colors
        use({ 'rrethy/vim-hexokinase', run = 'make hexokinase' })
		-- use({ 'norcalli/nvim-colorizer.lua' })

        -- documents
        use({ 'nvim-neorg/neorg', requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' }, run = ':Neorg sync-parsers' })
		-- }}}

		-- {{{ themes
		-- popular themes incoming
		use({ 'joshdick/onedark.vim'    })
		use({ 'sickill/vim-monokai'     })
		use({ 'morhetz/gruvbox'         })
		use({ 'shaunsingh/nord.nvim'    })
		use({ 'sainnhe/gruvbox-material'})

		-- neesh themes
		use({ 'sainnhe/everforest'     }) -- best theme btw
		use({ 'relastle/bluewery.vim'  })
		use({ 'haishanh/night-owl.vim' })
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

-- {{{ other
-- workaround for plugins that need rtp (himalaya)
local packer_compiled = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
vim.cmd('luafile'  .. packer_compiled)
-- }}}

-- # vim foldmethod=marker
