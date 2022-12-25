-- set vim options
-- {{{ imports
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local o = vim.o
-- }}}

-- {{{ options
cmd('syntax enable') 	-- syntax highlighting
o.rnu = false         	-- relative line numbers
o.nu = true         	-- line numbers
o.mouse = 'a'       	-- mouse controls
o.cursorline = true 	-- highlight line cursor is in
o.modeline = true   	-- enable modlines for files
o.modelines = 5			-- number of modelines

o.errorbells = false 	-- auditory stimulation annoying

opt.ruler = false		-- how line number/column
opt.hidden = true 		-- keeps buffers loaded in the background
opt.ignorecase = true
opt.scrolloff = 4   	-- buffer starts scrolling 4 lines from the end of view
opt.incsearch = true
opt.lazyredraw = true   -- lazy redraw
opt.shortmess = 'filnxtToOFI'

-- diagnostics
vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        show_header = true,
        source = 'always',
        -- border = 'rounded',
        focusable = true,
    },
    update_in_insert = true, -- default to false
    severity_sort = true, -- default to false
})

-- tab settings
o.tabstop = 4 			-- 4 tabstop
o.softtabstop = -1      -- inherit tabstop
o.shiftwidth = 0        -- inherit tabstop
o.expandtab = true     	-- tabs -> spaces
o.smartindent = true    -- nice indenting

-- folding
o.foldmethod = 'marker' -- set fold method to marker
g.markdown_folding = false -- markdown folding

-- backup/swap files
opt.swapfile = true  	-- have files saved to swap
opt.undofile = true		-- file undo history preserved outside current session

-- new win split options
opt.splitbelow = true
opt.splitright = true
o.completeopt = 'menuone,noselect'

-- truecolor
opt.termguicolors = true

-- neovide
o.guifont = 'JetBrainsMono Nerd Font Mono:h13'
-- }}}
