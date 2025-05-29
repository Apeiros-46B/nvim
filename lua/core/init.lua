require('core.keys')
require('core.opts')
require('core.theme')

vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = '*:*o',
	command = 'redrawstatus'
})
vim.api.nvim_create_autocmd('SwapExists', {
	pattern = '*',
	command = 'let v:swapchoice = "o"'
})
