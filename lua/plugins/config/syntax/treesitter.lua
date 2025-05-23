-- configuration for nvim-treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = 'all', -- 'all' | 'maintained' | list of langs
	sync_install     = false,
	ignore_install   = {},

	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},

    endwise = {
        enable = true,
    },
})

vim.api.nvim_set_hl(0, "@variable.member.zig", { link = "Blue" })
