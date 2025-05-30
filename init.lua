local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		'git', 'clone', '--filter=blob:none', '--single-branch',
		'https://github.com/folke/lazy.nvim.git', lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.deprecate = function() end

require('core')
require('lazy').setup {
	spec = {
		require('colors').spec,
		{ import = 'plugins' },
	},
	dev = {
		path = '~/dev/vim',
		patterns = { 'elysium', 'uiua.vim' },
		fallback = true,
	},
	change_detection = { enabled = false },
	ui = {
		border = 'none',
		backdrop = 100,
		icons = {
			loaded     = '●',
			not_loaded = '',
			cmd        = '󰞷',
			config     = '󰊕',
			event      = '',
			ft         = '󰈙',
			init       = '',
			keys       = '󰘳',
			plugin     = '󰏓',
			runtime    = '󰆧',
			source     = '',
			start      = '',
			task       = '󰄬',
			lazy       = '   ',
			list       = { '', '', '', '' },
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				'tohtml',
				'getscript',
				'getscriptPlugin',
				'logipat',
				'man',
				'matchit',
				'netrw',
				'netrwPlugin',
				'netrwSettings',
				'netrwFileHandlers',
				'rplugin',
				'rrhelper',
				'spellfile',
				'tutor',
				'vimball',
				'vimballPlugin',
			},
		},
	},
}
