-- define keymaps
-- {{{ imports & helpers
local function map(mode, bind, exec, opts)
    local options = { noremap = true, silent = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

-- local function unmap(mode, bind)
--     vim.api.nvim_del_keymap(mode, bind)
-- end

local opt = { silent = true } -- default opts
local M = {}

vim.g.mapleader = ' ' -- map leader key to space
vim.g.maplocalleader = ','
-- }}}

-- {{{ unmapping
-- unmap('n', '<leader>f')
-- }}}

-- {{{ mapping
-- note that these are only vanilla vim keymaps, all plugin keymaps are handled in `plugins.lazy`
-- {{{ misc
map('n', 'WW', ':w<CR>', opt) -- write shortcut
-- }}}

-- {{{ [b] buffer
map('n', '<leader>bd', ':bd<CR>',                opt)
map('n', '<leader>bh', ':bp<CR>',                opt)
map('n', '<leader>bj', ':bf<CR>',                opt)
map('n', '<leader>bk', ':bl<CR>',                opt)
map('n', '<leader>bl', ':bn<CR>',                opt)
-- }}}

-- {{{ [l] lsp
-- show floating diagnostic
map('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', opt)
-- }}}

-- {{{ [t] tab
map('n', '<leader>td', ':tabclose<CR>', opt)
map('n', '<leader>th', ':tabp<CR>',     opt)
map('n', '<leader>tj', ':tabfirst<CR>', opt)
map('n', '<leader>tk', ':tablast<CR>',  opt)
map('n', '<leader>tl', ':tabn<CR>',     opt)
map('n', '<leader>tn', ':tabnew<CR>',   opt)
-- }}}

-- {{{ [T] toggle
map('n', '<leader>Tr', ':set rnu!<CR>', {}) -- relative line numbers
map('n', '<leader>TW', ':set wrap!<CR>', {}) -- word wrap
-- }}}

-- {{{ [y] yank
map('n', '<leader>ya', ':%y+<CR>', opt) -- yank entire buffer to system clipboard
map('', '<leader>ys',  '"+y', opt) -- yank selection into system clipboard
map('n', '<leader>yy', '"+yy', opt) -- yank current line into system clipboard
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
