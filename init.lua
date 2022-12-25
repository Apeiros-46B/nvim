-- initialize configuration
-- {{{ bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)
-- }}}

-- {{{ core
--> disable shadafile during core config loading
vim.opt.shadafile = 'NONE'

--> autocommands
require('core.autocmds')

--> keymaps and bindings
require('core.keymaps')

--> general vim options
require('core.options')

--> re-enable shadafile
vim.opt.shadafile = ''
-- }}}

-- {{{ plugins
--> load
require('plugins.lazy')
-- }}}
