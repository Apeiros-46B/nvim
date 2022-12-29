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

o.cursorline = false
o.modeline = true
o.modelines = 5

o.errorbells = false

o.ruler = false
o.hidden = true
o.ignorecase = true
o.scrolloff = 2
o.incsearch = true

o.shortmess = 'filnxtToOFI'
o.showmode = false

o.laststatus = 3

-- diagnostics
vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        header = 'Diagnostics',
        source = 'always',
        focusable = true,
    },
    update_in_insert = true, -- default to false
    severity_sort = true, -- default to false
})

-- tab settings
o.tabstop = 4
o.softtabstop = -1
o.shiftwidth = 0
o.expandtab = true
o.smartindent = true

-- folding
o.foldmethod = 'marker'
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

o.titleold = 'st'
o.title = true

-- {{{ neovide
if vim.fn.exists('neovide') == 1 then
    o.guifont = 'JetBrainsMono Nerd Font Mono:h13'

    o.neovide_refresh_rate = 75
    o.neovide_refresh_rate_idle = 5

    g.neovide_padding_top    = 20
    g.neovide_padding_left   = 20
    g.neovide_padding_right  = 20
    g.neovide_padding_bottom = 20
end
-- }}}
-- }}}
