-- define keymaps
-- {{{ imports & helpers
local function map(mode, bind, exec, opts)
    local options = { noremap = true, silent = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_set_keymap(mode, bind, exec, options)
end

local M = {}

vim.g.mapleader = ' ' -- map leader key to space
vim.g.maplocalleader = ','
-- }}}

-- {{{ unmapping
-- unmap('n', '<leader>f')
-- }}}

-- {{{ mapping
-- note that these are only vanilla nvim keymaps, all plugin keymaps are handled in `plugins.lazy`
-- {{{ [b] buffer
map('n', '<M-x>', '<Cmd>bd!<CR>')
map('n', 'X',     '<Cmd>bd<CR>')
map('n', 'J',     '<Cmd>bp<CR>')
map('n', 'K',     '<Cmd>bn<CR>')

map('n', '<leader>bd', '<Cmd>bd<CR>')
map('n', '<leader>bh', '<Cmd>bp<CR>')
map('n', '<leader>bj', '<Cmd>bf<CR>')
map('n', '<leader>bk', '<Cmd>bl<CR>')
map('n', '<leader>bl', '<Cmd>bn<CR>')
-- }}}

-- {{{ [F] format
-- get rid of annoying curly quotation marks and apostrophes
map('n', '<leader>Fc', [[<Cmd>%s/[“”‟]/"/g | %s/[‘’‛]/'/g<CR>]])
-- }}}

-- {{{ [l] lsp
-- show floating diagnostic
map('n', '<leader>d', '<Cmd>lua vim.diagnostic.open_float()<CR>')
-- }}}

-- {{{ [t] tab
map('n', '<leader>td', '<Cmd>tabclose<CR>')
map('n', '<leader>th', '<Cmd>tabp<CR>'    )
map('n', '<leader>tj', '<Cmd>tabfirst<CR>')
map('n', '<leader>tk', '<Cmd>tablast<CR>' )
map('n', '<leader>tl', '<Cmd>tabn<CR>'    )
map('n', '<leader>tn', '<Cmd>tabnew<CR>'  )
-- }}}

-- {{{ [T] toggle
map('n', '<leader>Tr', '<Cmd>set rnu!<CR>',  {}) -- relative line numbers
map('n', '<leader>TW', '<Cmd>set wrap!<CR>', {}) -- word wrap
-- }}}

-- {{{ [y] yank
map('n', '<leader>ya', '<Cmd>%y+<CR>') -- yank entire buffer to system clipboard
map('',  '<leader>ys',  '"+y'        ) -- yank selection (or motion) into system clipboard
map('n', '<leader>yy', '"+yy'        ) -- yank current line into system clipboard
-- }}}

-- {{{ [<CR>] terminal
map('n', '<leader><CR><CR>', '<Cmd>terminal<CR>i')
map('n', '<leader><CR>v',    '<Cmd>vs | terminal<CR>i')
map('n', '<leader><CR>h',    '<Cmd>sp | terminal<CR>i')
-- }}}

-- {{{ misc
-- exit shortcuts
map('n', 'WW',    '<Cmd>w<CR>')
map('n', 'WQ',    '<Cmd>wq<CR>')
map('n', '<M-w>', '<Cmd>w<CR>')
map('n', '<M-q>', '<Cmd>wq<CR>')
map('n', '<M-Q>', '<Cmd>q!<CR>')

map('', '<C-j>', 'J')
-- }}}
-- }}}

-- {{{ return externally-required keymaps
return M
-- }}}
