require('core.keys')
require('core.opts')

vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = '*:*o',
	command = 'redrawstatus',
})
vim.api.nvim_create_autocmd('SwapExists', {
	pattern = '*',
	callback = function()
		vim.v.swapchoice = 'o'
		vim.defer_fn(function() print('Opened RO due to swapfile') end, 100)
	end
})
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	callback = function()
		vim.opt_local.formatoptions = 'jnql'
	end
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown',
	callback = function()
		vim.opt_local.formatlistpat = [[^\s*\(\([│>]\|╰─\)\s*\)\?\(\d\+\.\|[-+*]\)\?\s*]]
	end
})

-- fix double-press issue on some terminals
local function fix_kbd()
	io.write('\27[>0u')
	io.flush()
end
local ns
ns = vim.on_key(function()
	fix_kbd()
	vim.on_key(nil, ns)
end)
vim.defer_fn(fix_kbd, 100)
