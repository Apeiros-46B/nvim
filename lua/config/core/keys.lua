-- {{{ helper functions
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

vim.g.mapleader = ' ' -- map leader key to space
vim.g.maplocalleader = ','
-- }}}

-- {{{ unmapping
-- unmap('n', '<leader>f')
-- }}}

-- {{{ mapping
-- {{{ cmp
local cmp = require('cmp')

local next = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
local prev = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })

M.cmp_mappings = {
    ['<Tab>']     = next,
    ['<S-Tab>']   = prev,
    ['<C-n>']     = next,
    ['<C-p>']     = prev,

    ['<C-Space>'] = cmp.mapping.complete(),

    ['<C-d>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),

    ['<C-e>']     = cmp.mapping.close(),

    ['<CR>']      = cmp.mapping.confirm({
        behavior  = cmp.ConfirmBehavior.Insert,
        select    = true,
    }),
}
-- }}}

-- {{{ misc
map('n', 'WW', ':w<CR>', opt)

map('n', '<leader><leader><leader>', ':Reload<CR>', opt) -- source config
map('n', '<leader><leader>f', ':source<CR>', opt) -- source current file

map('', '<C-c>', ':CommentToggle<CR>', opt) -- toggle comment on current line or selection
map('', '<C-n>', ':NvimTreeToggle<CR>', opt) -- toggle nvimtree

map('n', '<leader>s', ':lua MiniStarter.open()<CR>', opt) -- show dashboard
map('n', '<leader>m', ':vs | enew | Quickmath<CR>', opt) -- open Quickmath in vertical split
-- }}}

-- {{{ [b] buffer
map('n', '<leader>bd', ':bd<CR>',                { noremap = true })
map('n', '<leader>bh', ':bp<CR>',                { noremap = true })
map('n', '<leader>bj', ':bf<CR>',                { noremap = true })
map('n', '<leader>bk', ':bl<CR>',                { noremap = true })
map('n', '<leader>bl', ':bn<CR>',                { noremap = true })
map('n', '<leader>bp', ':Telescope buffers<CR>', { noremap = true })
-- }}}

-- {{{ [F] format
map('n', '<leader>Fn', ':Neoformat<CR>', opt) -- neoformat current buffer
map('n', '<leader>Fs', ':lua MiniTrailspace.trim()<CR>', opt) -- trim trailing spaces
-- }}}

-- {{{ [f] find
map('n', '<leader>fb', ':Telescope marks<CR>', { noremap = true })
map('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
map('n', '<leader>fr', ':Telescope oldfiles<CR>', { noremap = true })
map('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true })
-- }}}

-- {{{ [g] git
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
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>gS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>gU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
}

map('n', '<leader>gg', ':Git<CR>', opt)
map('n', '<leader>gB', ':Git blame<CR>', opt)
map('n', '<leader>gc', ':Git commit<CR>', opt)
map('n', '<leader>gfc', ':Telescope git_commits<CR>', { noremap = true })
map('n', '<leader>gfb', ':Telescope git_branches<CR>', { noremap = true })
-- }}}

-- {{{ [h] hop
map('n', '<leader>hh', ':HopWord<CR>', opt)
map('n', '<leader>hk', ':HopWordBC<CR>', opt)
map('n', '<leader>hj', ':HopWordAC<CR>', opt)
map('n', '<leader>hl', ':HopWordMW<CR>', opt)
map('n', '<leader>hc', ':HopChar1<CR>', opt)
map('n', '<leader>hC', ':HopChar2<CR>', opt)
map('n', '<leader>hg', ':HopPattern<CR>', opt)
map('n', '<leader>hn', ':HopLineStart<CR>', opt)
map('n', '<leader>hf', ':HopWordCurrentLine<CR>', opt)
-- }}}

-- {{{ [j] jdtls
map('n', '<leader>jb', ':vs | terminal<CR>imvn clean package -T 4<CR>', opt)
map('n', '<leader>jo', ':lua require("jdtls").organize_imports()<CR>', opt)
map('n', '<leader>jev', ':lua require("jdtls").extract_variable()<CR>', opt)
map('v', '<leader>jev', '<Esc>:lua require("jdtls").extract_variable(true)<CR>', opt)
map('n', '<leader>jec', ':lua require("jdtls").exttract_constant()<CR>', opt)
map('v', '<leader>jec', '<Esc>:lua require("jdtls").extract_constant(true)<CR>', opt)
map('v', '<leader>jem', '<Esc>:lua require("jdtls").extract_method(true)<CR>', opt)
-- }}}

-- {{{ [l] lsp
-- show floating diagnostic
map('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', opt)

-- trouble
map('n', '<leader>T', ':TroubleToggle<CR>', opt)

-- {{{ lspsaga
--- lsp finder
map('n', '<leader>lf', ':Lspsaga lsp_finder<CR>', opt)

--- code actions
map('n', '<M-CR>', ':Lspsaga code_action<CR>', opt)
map('v', '<M-CR>', ':<C-U>Lspsaga range_code_action<CR>', opt)

--- hover doc
map('n', '<leader>lp', ':Lspsaga hover_doc<CR>', opt)
map('n', '<M-f>', ':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opt)
map('n', '<M-b>', ':lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opt)

--- rename
map('n', '<leader>lr', ':Lspsaga rename<CR>', opt)

--- peek definition
map('n', '<leader>ld', ':Lspsaga peek_definition<CR>', opt)

--- floating term
map('n', '<M-d>', ':Lspsaga open_floaterm<CR>', opt)
map('t', '<M-d>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>', opt)
map('t', '<M-x>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>', opt)
-- }}}
-- }}}

-- {{{ [n] neorg
map('n', '<leader>nc', ':Neorg toggle-concealer<CR>', opt)
map('n', '<leader>nC', ':Neorg toggle-concealer<CR>:Neorg toggle-concealer<CR>', opt)
map('n', [[\]], 'o- <Esc>a', opt)
-- }}}

-- {{{ [t] toggle
map('n', '<leader>tr', ':set rnu!<CR>', opt) -- relative line numbers
map('n', '<leader>tW', ':set wrap!<CR>', opt) -- word wrap

map('n', '<leader>tn', ':NavicToggle<CR>', opt) -- (lualine) navic
map('n', '<leader>tw', ':WordCountToggle<CR>', opt) -- (lualine) word counter
-- }}}

-- {{{ [y] yank
map('n', '<leader>ya', ':%y+<CR>', opt) -- yank entire buffer to system clipboard
map('n', '<leader>yl', '"+yy', opt) -- yank current line into system clipboard
map('', '<leader>ys',  '"+y', opt) -- yank selection into system clipboard
-- }}}

-- {{{ [<CR>] terminal
map('n', '<leader><CR><CR>', ':terminal<CR>i', opt)
map('n', '<leader><CR>v', ':vs | terminal<CR>i', opt)
map('n', '<leader><CR>h', ':sp | terminal<CR>i', opt)
-- }}}
-- }}}

-- {{{ return externally-required keymaps
return M
-- }}}
