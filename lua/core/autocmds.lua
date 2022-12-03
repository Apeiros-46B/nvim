-- define non-plugin related autocommands
-- {{{ imports
local api = vim.api
local au = api.nvim_create_autocmd
-- }}}

-- {{{ autocommands
-- don't show line numbers on terminal window
au({ 'TermOpen' }, { pattern = 'term://*', command = 'setlocal nonumber norelativenumber ft=terminal' })

-- {{{ title
-- au({ 'BufEnter', 'BufWinEnter' }, {
--     callback = function()
--         -- 'nvim - ' . (expand('%:h') == '/' ? '' : pathshorten(expand('%:h'))) . '/' .  expand('%:t')
--         local expanded = vim.fn.expand('%:h')
--         local titlestring = 'nvim - ' .. (expanded == '/' and '' or vim.fn.pathshorten(expanded)) .. '/' .. vim.fn.expand('%:t')
--         vim.cmd(([[let &titlestring = '%s']]):format(titlestring))
--     end
-- })

-- au({ 'VimEnter' }, { command = 'set title'          })
-- au({ 'VimLeave' }, { command = 'set titlestring=st' })
-- }}}
-- }}}
