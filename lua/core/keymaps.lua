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
map('n', '<leader>x', '<Cmd>bdelete<CR>')
map('n', '<leader>X', '<Cmd>bdelete!<CR>')
map('n', '<leader>j', '<Cmd>bprevious<CR>')
map('n', '<leader>k', '<Cmd>bnext<CR>')
-- }}}

-- {{{ [F] format
map('n', '<M-q>', 'gwip')
-- get rid of stuff from word processors                                                                                            nbsp
map('n', '<leader>Fw', [[<Cmd>silent! keepp %s/[“”‟]/"/g | silent! keepp %s/[‘’‛]/'/g | silent! keepp %s/…/.../g | silent! keepp %s/ / /g<CR>]])
-- }}}

-- {{{ [l] lsp
-- show floating diagnostic
map('n', '<leader>d', '<Cmd>lua vim.diagnostic.open_float()<CR>')
-- }}}

-- {{{ [t] tab
map('n', '<leader>td', '<Cmd>tabclose<CR>')
map('n', '<leader>th', '<Cmd>tabfirst<CR>')
map('n', '<leader>tj', '<Cmd>tabp<CR>'    )
map('n', '<leader>tk', '<Cmd>tabn<CR>'    )
map('n', '<leader>tl', '<Cmd>tablast<CR>' )
map('n', '<leader>tn', '<Cmd>tabnew<CR>'  )
-- }}}

-- {{{ [T] toggle
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

-- {{{ other
map('n', 'WW',    '<Cmd>w<CR>')
-- }}}
-- }}}

-- {{{ return externally-required keymaps
return M
-- }}}
