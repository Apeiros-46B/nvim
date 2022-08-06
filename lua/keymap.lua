-- {{{
local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

local function unmap(mode, bind)
	vim.api.nvim_del_keymap(mode, bind)
end

local opt = {} --empty opt for maps with no extra options
local M = {}
-- }}}

--[[
    MAPPING:
	map takes 4 args:
		The first is the type, whether in all, normal, insert etc. (reference: https://github.com/nanotee/nvim-lua-guide#defining-mappings)
		The Second Arg is the keybind. Just like normal vim way
		The Third is the command to execute
		The Fourth is other extra options

	Example:  (toggles line numbers)
		map("n", "<C-n>", ":set rnu!<CR>", opt)
--]]

-- {{{ unmapping
--unmap('n', '<leader>f')
-- }}}

-- {{{ misc bindings
vim.g.mapleader = ' ' -- map leader key to space
vim.g.maplocalleader = ','

map('n', '<leader><leader>', ':Reload<CR>', opt) -- reload config
map('n', '<leader>S', ':source<CR>', opt) -- source current file

-- line wrap movement
map('', 'J', 'gj', opt)
map('', 'K', 'gk', opt)

map('n', '<leader>R', ':set rnu!<CR>', opt) -- toggle relative line numbers
map('n', '<leader>W', ':set wrap!<CR>', opt) -- toggle word wrap
map('', '<C-c>', ':CommentToggle<CR>', opt) -- toggle comment on current line or selection
map('', '<leader>/', ':CommentToggle<CR>', opt) -- toggle comment on current line or selection
map('', '<C-n>', ':NvimTreeToggle<CR>', opt) -- toggle nvimtree
-- map('', '<C-n>', ':CHADopen<CR>', opt) -- toggle chadtree
map('n', '<leader>bf', ':Neoformat<CR>', { noremap = true }) -- format current buffer with neoformat

map('n', '<leader>~', ':Dashboard<CR>', opt) -- map show dashboard
map('n', '<leader>Nf', ':DashboardNewFile', opt) -- new file

-- clipboard mappings
map('n', '<leader>ya', ':%y+<CR>', opt) -- Copy content of entire buffer to system clipboard
map('n', '<leader>yl', '"+yy', opt) -- yank current line into system clipboard
map('', '<leader>ys',  '"+y', opt) -- yank selection into system clipboard

-- write and quit shortcuts
map('n', 'WW', ':w<CR>', opt)
map('n', '<leader>q', ':wqa<CR>', opt)

-- glow
map('n', '<leader>p', ':Glow<CR>', opt)

-- toggle word counter and navic (see config/plug/lualine.lua)
map('n', '<leader>w', ':WordCountToggle<CR>', opt)
map('n', '<leader>n', ':NavicToggle<CR>', opt)

-- macros
for c in string.gmatch('abcdefghijklmnopqrstuvwxyz', '.') do
    map('n', '<leader>m' .. c, '@' .. c, opt)
end
-- }}}

-- {{{ autocompletion mappings for cmp
local cmp = require('cmp')
M.cmp_mappings = {

	['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
	['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-e>'] =cmp.mapping.close(),
	['<CR>'] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	}),
}
-- }}}

-- {{{ LSP/java-related binds
-- show floating diagnostic
map('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', opt)

-- trouble
map('n', '<leader>T', ':TroubleToggle<CR>', opt)

-- {{{ lspsaga
--- async lsp finder
map('n', '<leader>Lf', ':Lspsaga lsp_finder<CR>', opt)

--- code actions
map('n', '<M-CR>', ':Lspsaga code_action<CR>', opt)
map('v', '<M-CR>', ':<C-U>Lspsaga range_code_action<CR>', opt)

--- hover doc
map('n', '<leader>Lp', ':Lspsaga hover_doc<CR>', opt)
map('n', '<M-f>', ':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opt)
map('n', '<M-b>', ':lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opt)

--- signature help
map('n', '<leader>Ls', ':Lspsaga signature_help<CR>', opt)

--- rename
map('n', '<leader>Lr', ':Lspsaga rename<CR>', opt)

--- preview definition
map('n', '<leader>Ld', ':Lspsaga preview_definition<CR>', opt)

--- floating term
map('n', '<M-d>', ':Lspsaga open_floaterm<CR>', opt)
map('t', '<M-d>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>:q<CR>', opt)
-- }}}

-- mvn clean package
map('n', '<leader>Jb', ':vs | terminal<CR>imvn clean package -T 4<CR>', opt)

-- jdtls
map('n', '<leader>Jo', ':lua require("jdtls").organize_imports()<CR>', opt)
map('n', '<leader>Jev', ':lua require("jdtls").extract_variable()<CR>', opt)
map('v', '<leader>Jev', '<Esc>:lua require("jdtls").extract_variable(true)<CR>', opt)
map('n', '<leader>Jec', ':lua require("jdtls").exttract_constant()<CR>', opt)
map('v', '<leader>Jec', '<Esc>:lua require("jdtls").extract_constant(true)<CR>', opt)
map('v', '<leader>Jem', '<Esc>:lua require("jdtls").extract_method(true)<CR>', opt)
-- }}}

-- {{{ git mappings
M.gitsigns_mappings = {
	noremap = true,
	['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
	['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

	['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
	['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
	['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
	['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
	['v <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
	['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
	['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
	-- ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
	['n <leader>gS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
	['n <leader>gU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

	-- Text objects
	['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
}

map('n', '<leader>gg', ':Git<CR>', opt)
map('n', '<leader>gb', ':Git blame<CR>', opt)
-- }}}

-- {{{ buffer management
map('n', '<leader>bh', ':bp<CR>', { noremap = true })
map('n', '<leader>bk', ':bl<CR>', { noremap = true })
map('n', '<leader>bj', ':bf<CR>', { noremap = true })
map('n', '<leader>bl', ':bn<CR>', { noremap = true })
map('n', '<leader>bd', ':bd<CR>', { noremap = true })
-- }}}

-- {{{ window navigation
map('n', '<leader>h', ':wincmd h<CR>', opt)
map('n', '<leader>j', ':wincmd j<CR>', opt)
map('n', '<leader>k', ':wincmd k<CR>', opt)
map('n', '<leader>l', ':wincmd l<CR>', opt)
-- }}}

-- {{{ terminal commands
map('n', '<leader><CR>', ':vs | terminal<CR>i', opt)
map('n', '<leader>\\', ':sp | terminal<CR>i', opt)
map('t', '<C-esc>', '<C-\\><C-n>', opt)
-- }}}

-- {{{ telescope pullup
map('n', '<leader>fb', ':Telescope marks<CR>', { noremap = true })
map('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
map('n', '<leader>fr', ':Telescope oldfiles<CR>', { noremap = true })
map('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true })
map('n', '<leader>fn', ':Telescope notify<CR>', { noremap = true })
map('n', '<leader>gC', ':Telescope git_commits<CR>', { noremap = true })
map('n', '<leader>gB', ':Telescope git_branches<CR>', { noremap = true })
map('n', '<leader>bp', ':Telescope buffers<CR>', { noremap = true })
-- }}}

-- {{{ hop.nvim
map('n', '<leader>ah', ':HopWord<CR>', opt)
map('n', '<leader>ak', ':HopWordBC<CR>', opt)
map('n', '<leader>aj', ':HopWordAC<CR>', opt)
map('n', '<leader>al', ':HopWordMW<CR>', opt)
map('n', '<leader>ac', ':HopChar1<CR>', opt)
map('n', '<leader>aC', ':HopChar2<CR>', opt)
map('n', '<leader>ag', ':HopPattern<CR>', opt)
map('n', '<leader>an', ':HopLineStart<CR>', opt)
map('n', '<leader>af', ':HopWordCurrentLine<CR>', opt)
-- }}}

-- returns any externally-required keymaps for usage
return M
-- # vim foldmethod=marker
