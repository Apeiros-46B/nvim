vim.o.errorbells = false
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.mousemodel = 'popup_setpos'
vim.o.guicursor = 'n-c-t:block,o:hor50,v-ve:block-vCursor,i-ci-sm:ver25-iCursor,r-cr:block-rCursor'

vim.o.rnu = true
vim.o.nu = true
vim.o.cul = true
vim.o.culopt = 'both'
vim.o.signcolumn = 'yes'
-- vim.o.fillchars = 'vert: ,fold: ,foldopen:,foldclose:,eob: ,trunc:⋮,truncrl:⋮'
vim.o.fillchars = 'vert: ,fold: ,eob: '
vim.o.listchars = 'tab:. ,trail:-,nbsp:+,precedes:⋮'

vim.o.ruler = true
vim.o.showmode = false
vim.o.shortmess = 'aoOstTIcCS'
vim.o.laststatus = 3
vim.o.showtabline = 2

vim.o.scrolloff = 2
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.o.modeline = true
vim.o.modelines = 5
vim.o.foldmethod = 'marker'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.o.swapfile = true
vim.o.undofile = true

vim.o.ts = 2
vim.o.sts = -1
vim.o.sw = 0
vim.o.et = false
vim.o.smartindent = true
vim.o.cinoptions = '=sl1g0N-sE-s'
vim.g.editorconfig = true

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hidden = true

vim.g.zig_fmt_autosave = false

vim.diagnostic.config({
	update_in_insert = true,
	severity_sort = true,
	underline = true,
	virtual_text = false,
	float = {
		header = '',
		source = 'always',
		focusable = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '▼',
			[vim.diagnostic.severity.WARN]  = '▲',
			[vim.diagnostic.severity.INFO]  = '●',
			[vim.diagnostic.severity.HINT]  = '●',
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
			[vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
			[vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
			[vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
		},
	},
})
