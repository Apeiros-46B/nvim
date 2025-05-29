local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, options)
end

vim.g.mapleader = ' '

map('n', '<leader>x', '<cmd>bdelete<CR>')
map('n', '<leader>X', '<cmd>bdelete!<CR>')
map('n', '<leader>j', '<cmd>bnext!<CR>')
map('n', '<leader>k', '<cmd>bprev!<CR>')

map('n', '<leader>z', '<cmd>tabclose<CR>')
map('n', '<leader>u', '<cmd>tabnext<CR>')
map('n', '<leader>i', '<cmd>tabprev<CR>')

map('n', '<leader><CR>', '<cmd>vertical botright terminal<CR>')
map('n', '<leader><Bslash>', '<cmd>bot terminal<CR>')
map('t', '<C-w><C-n>', '<C-\\><C-n>')

map('', '<leader>y', '"+y')

map('n', '<leader>d',   '<cmd>lua vim.diagnostic.open_float()<CR>')
map('n', '<leader>lj',  '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<leader>lk',  '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<M-CR>',      '<cmd>lua vim.lsp.buf.code_action()<CR>')

map('n', 'cc', '<cmd>silent! nohl | doautocmd User SearchCleared<CR>')
map('n', '<C-c>', 'gcc', { noremap = false })
map('v', '<C-c>', 'gc',  { noremap = false })
