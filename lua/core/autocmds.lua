-- define non-plugin related autocommands
-- {{{ imports
local api = vim.api
local au = api.nvim_create_autocmd
-- }}}

-- don't show line numbers on terminal window
au('TermOpen', { pattern = 'term://*', command = 'setlocal nonumber norelativenumber ft=terminal' })

-- {{{ title
au({ 'VimEnter', 'BufEnter' }, {
    callback = function()
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ':~')
        cwd = vim.fn.pathshorten(cwd, 2)

        local file = vim.fn.expand('%')
        file = vim.fn.pathshorten(file, 2)

        local titlestring = 'nvim' .. (cwd ~= '~' and ' ' .. cwd or '') .. (file ~= '' and ' -> ' .. file or '')

        vim.cmd(([[let &titlestring = '%s']]):format(titlestring))
    end
})
-- }}}
