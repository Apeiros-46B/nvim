local M = {}

vim.api.nvim_create_augroup('my.hl_override', { clear = false })

function M.hl(hl)
	local function cb()
		for k, v in pairs(hl) do
			vim.api.nvim_set_hl(0, k, v)
		end
	end
	-- rehighlight after colorscheme loaded
	vim.api.nvim_create_autocmd('ColorScheme', {
		group = 'my.hl_override',
		callback = cb,
	})
	cb()
end

function M.opts_with_hl(opts, hl)
	return function()
		M.hl(hl)
		return opts
	end
end

return M
