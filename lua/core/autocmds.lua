-- define non-plugin related autocommands
-- {{{ imports
local api = vim.api
local au = api.nvim_create_autocmd
-- }}}

-- {{{ autocommands
-- don't show line numbers on terminal window
au({ 'TermOpen' }, { pattern = 'term://*', command = 'setlocal nonumber norelativenumber ft=terminal' })
-- }}}
