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
map('n', 'WW',    '<Cmd>w<CR>',    opt) -- write shortcut
map('n', '<C-j>', '<Cmd>join<CR>', opt)
-- }}}

-- {{{ [b] buffer
map('n', 'J', '<Cmd>bp<CR>', opt)
map('n', 'K', '<Cmd>bn<CR>', opt)

map('n', '<leader>bd', '<Cmd>bd<CR>', opt)
map('n', '<leader>bh', '<Cmd>bp<CR>', opt)
map('n', '<leader>bj', '<Cmd>bf<CR>', opt)
map('n', '<leader>bk', '<Cmd>bl<CR>', opt)
map('n', '<leader>bl', '<Cmd>bn<CR>', opt)
-- }}}

-- {{{ [l] lsp
-- show floating diagnostic
map('n', '<leader>d', '<Cmd>lua vim.diagnostic.open_float()<CR>', opt)
-- }}}

-- {{{ [t] tab
map('n', '<leader>td', '<Cmd>tabclose<CR>', opt)
map('n', '<leader>th', '<Cmd>tabp<CR>',     opt)
map('n', '<leader>tj', '<Cmd>tabfirst<CR>', opt)
map('n', '<leader>tk', '<Cmd>tablast<CR>',  opt)
map('n', '<leader>tl', '<Cmd>tabn<CR>',     opt)
map('n', '<leader>tn', '<Cmd>tabnew<CR>',   opt)
-- }}}

-- {{{ [T] toggle
map('n', '<leader>Tr', '<Cmd>set rnu!<CR>',  {}) -- relative line numbers
map('n', '<leader>TW', '<Cmd>set wrap!<CR>', {}) -- word wrap
-- }}}

-- {{{ [y] yank
map('n', '<leader>ya', '<Cmd>%y+<CR>', opt) -- yank entire buffer to system clipboard
map('',  '<leader>ys',  '"+y',         opt) -- yank selection (or motion) into system clipboard
map('n', '<leader>yy', '"+yy',         opt) -- yank current line into system clipboard
-- }}}

-- {{{ [<CR>] terminal
map('n', '<leader><CR><CR>', '<Cmd>terminal<CR>i', opt)
map('n', '<leader><CR>v',    '<Cmd>vs | terminal<CR>i', opt)
map('n', '<leader><CR>h',    '<Cmd>sp | terminal<CR>i', opt)
-- }}}
-- }}}

-- {{{ return externally-required keymaps
return M
-- }}}
