-- set vim options
-- TODO: reorganize this
-- {{{ imports
local cmd = vim.cmd
local g = vim.g
local o = vim.o
-- }}}

-- {{{ options
cmd('syntax enable')

o.rnu = true
o.nu = true
o.mouse = 'a'
o.mousemodel = 'extend'

o.cursorline = true
o.cursorlineopt = 'line'
o.modeline = true
o.modelines = 5

o.errorbells = false

o.signcolumn = 'yes'
o.ruler = false
o.hidden = true
o.ignorecase = true
o.scrolloff = 2
o.incsearch = true

o.shortmess = 'aoOstTcFS'
o.showmode = false

o.laststatus = 3

-- indent
o.tabstop = 2
o.softtabstop = -1
o.shiftwidth = 0
o.expandtab = false
o.smartindent = true
o.cinoptions = '=sl1g0N-sE-s'
g.rust_recommended_style = false
g.python_recommended_style = false

-- folding
o.foldmethod = 'marker'
o.foldexpr = 'nvim_treesitter#foldexpr()'
g.markdown_folding = false

-- backup/swap files
o.swapfile = true
o.undofile = true

-- new win split options
o.splitbelow = true
o.splitright = true
o.completeopt = 'menuone,noselect'

-- truecolor
o.termguicolors = true

-- window title
o.titleold = 'st'
o.title = true

-- diagnostics
vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        header = '',
        source = 'always',
        focusable = true,
    },
    update_in_insert = true,
    severity_sort = true,
})

-- {{{ neovide
if vim.g.neovide then
    o.guifont = 'JetBrainsMono Nerd Font Mono:h13'

    g.neovide_padding_top    = 20
    g.neovide_padding_left   = 20
    g.neovide_padding_right  = 20
    g.neovide_padding_bottom = 20
end
-- }}}
-- }}}
