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
-- {{{ buffer
map('n', '<leader>x', '<cmd>bdelete<CR>')
map('n', '<leader>X', '<cmd>bdelete!<CR>')
map('n', '<leader>j', '<cmd>bprevious<CR>')
map('n', '<leader>k', '<cmd>bnext<CR>')
-- }}}

-- {{{ [F] format
map('n', '<M-q>', 'gwip')
-- get rid of stuff from word processors                                                                                            nbsp
map('n', '<leader>Fw', [[<cmd>silent! keepp %s/[“”‟]/"/g | silent! keepp %s/[‘’‛]/'/g | silent! keepp %s/…/.../g | silent! keepp %s/ / /g<CR>]])
-- }}}

-- {{{ [l] lsp
-- show floating diagnostic
map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
-- }}}

-- {{{ [t] tab
map('n', '<leader>td', '<cmd>tabclose<CR>')
map('n', '<leader>th', '<cmd>tabfirst<CR>')
map('n', '<leader>tj', '<cmd>tabp<CR>'    )
map('n', '<leader>tk', '<cmd>tabn<CR>'    )
map('n', '<leader>tl', '<cmd>tablast<CR>' )
map('n', '<leader>tn', '<cmd>tabnew<CR>'  )
-- }}}

-- {{{ [T] toggle
map('n', '<leader>TW', '<cmd>set wrap!<CR>', {}) -- word wrap
-- }}}

-- {{{ [y] yank
map('n', '<leader>ya', '<cmd>%y+<CR>') -- yank entire buffer to system clipboard
map('',  '<leader>ys',  '"+y'        ) -- yank selection (or motion) into system clipboard
map('n', '<leader>yy', '"+yy'        ) -- yank current line into system clipboard
-- }}}

-- {{{ [<CR>] terminal
map('n', '<leader><CR><CR>', '<cmd>terminal<CR>i')
map('n', '<leader><CR>v',    '<cmd>vs | terminal<CR>i')
map('n', '<leader><CR>h',    '<cmd>sp | terminal<CR>i')
-- }}}

-- {{{ other
map('n', 'WW',    '<cmd>w<CR>')
-- }}}
-- }}}

-- {{{ return externally-required keymaps
return M
-- }}}
