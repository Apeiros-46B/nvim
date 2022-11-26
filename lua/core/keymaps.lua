-- define keymaps
-- {{{ imports & helpers
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

local opt = { silent = true } -- default opts
local M = {}

vim.g.mapleader = ' ' -- map leader key to space
vim.g.maplocalleader = ','
-- }}}

-- {{{ unmapping
-- unmap('n', '<leader>f')
-- }}}

-- {{{ mapping
-- {{{ misc
map('n', 'WW', ':w<CR>', opt) -- write shortcut

map('', '<C-c>', ':CommentToggle<CR>', opt) -- toggle comment on current line or selection
map('', '<C-n>', ':NvimTreeToggle<CR>', opt) -- toggle nvimtree

map('n', '<leader>s', ':lua MiniStarter.open()<CR>', opt) -- show dashboard
map('n', '<leader>m', ':vs | enew | Quickmath<CR>', opt) -- open Quickmath in vertical split
map('n', '<leader>M', ':sp | enew | Quickmath<CR>', opt) -- open Quickmath in vertical split
-- }}}

-- {{{ [b] buffer
map('n', '<leader>bd', ':bd<CR>',                opt)
map('n', '<leader>bh', ':bp<CR>',                opt)
map('n', '<leader>bj', ':bf<CR>',                opt)
map('n', '<leader>bk', ':bl<CR>',                opt)
map('n', '<leader>bl', ':bn<CR>',                opt)
map('n', '<leader>bp', ':Telescope buffers<CR>', opt)
-- }}}

-- {{{ [f] find
map('n', '<leader>fb', ':Telescope marks<CR>', opt)
map('n', '<leader>ff', ':Telescope find_files<CR>', opt)
map('n', '<leader>fr', ':Telescope oldfiles<CR>', opt)
map('n', '<leader>fw', ':Telescope live_grep<CR>', opt)
-- }}}

-- {{{ [F] format
map('n', '<leader>Fn', ':Neoformat<CR>', opt) -- neoformat current buffer
map('n', '<leader>Fs', ':lua MiniTrailspace.trim()<CR>', opt) -- trim trailing spaces
-- }}}

-- {{{ [g] git
map('n', '<leader>gg', ':Git<CR>', opt)
map('n', '<leader>gB', ':Git blame<CR>', opt)
map('n', '<leader>gc', ':Git commit<CR>', opt)
map('n', '<leader>gfc', ':Telescope git_commits<CR>', opt)
map('n', '<leader>gfb', ':Telescope git_branches<CR>', opt)
-- }}}

-- {{{ [h] hop
map('n', '<leader>hh', ':HopWord<CR>', {})
map('n', '<leader>hk', ':HopWordBC<CR>', {})
map('n', '<leader>hj', ':HopWordAC<CR>', {})
map('n', '<leader>hl', ':HopWordMW<CR>', {})
map('n', '<leader>hc', ':HopChar1<CR>', {})
map('n', '<leader>hC', ':HopChar2<CR>', {})
map('n', '<leader>hg', ':HopPattern<CR>', {})
map('n', '<leader>hn', ':HopLineStart<CR>', {})
map('n', '<leader>hf', ':HopWordCurrentLine<CR>', {})
-- }}}

-- {{{ [j] jdtls
map('n', '<leader>jb', ':vs | terminal<CR>imvn clean package -T 4<CR>', opt)
map('n', '<leader>jo', ':lua require("jdtls").organize_imports()<CR>', opt)
map('n', '<leader>jev', ':lua require("jdtls").extract_variable()<CR>', opt)
map('v', '<leader>jev', ':<C-u>lua require("jdtls").extract_variable(true)<CR>', opt)
map('n', '<leader>jec', ':lua require("jdtls").exttract_constant()<CR>', opt)
map('v', '<leader>jec', ':<C-u>lua require("jdtls").extract_constant(true)<CR>', opt)
map('v', '<leader>jem', ':<C-u>lua require("jdtls").extract_method(true)<CR>', opt)
-- }}}

-- {{{ [l] lsp
-- show floating diagnostic
map('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', opt)

-- trouble
map('n', '<leader>lt', ':TroubleToggle<CR>', opt)

-- {{{ lspsaga
--- lsp finder
map('n', '<leader>lf', ':Lspsaga lsp_finder<CR>', opt)

--- code actions
map('n', '<M-CR>', ':Lspsaga code_action<CR>', opt)

--- hover doc
map('n', '<leader>lp', ':Lspsaga hover_doc<CR>', opt)

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
map('n', '<leader>nc', ':Neorg toggle-concealer<CR>',                            opt)
map('n', '<leader>nC', ':Neorg toggle-concealer<CR>:Neorg toggle-concealer<CR>', opt)

-- open a note for today
map('n', '<leader>nt', ':lua vim.cmd(os.date("e %d_%m.norg"))<CR>', opt)

-- three-column notes
vim.api.nvim_create_user_command('ThreeColumn', 'exec "normal a* Keywords\n- "|vs|exec "normal a\n\n* Takeaways\n- "|vs|exec "normal a\n\n* Connections\n- "|silent %s/^- $/  - /|exec "normal $"|wincmd h|exec "normal $"|wincmd h|exec "normal $"', { nargs = 0 })

map('n', '<leader>nT', ':ThreeColumn<CR>', opt)
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

map('n', '<leader>Tn', ':NavicToggle<CR>', {}) -- (lualine) navic
map('n', '<leader>Tw', ':WordCountToggle<CR>', {}) -- (lualine) word counter
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
