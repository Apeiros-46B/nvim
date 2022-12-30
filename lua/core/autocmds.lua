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

-- {{{ disable/enable relative numbers on insert mode enter/leave
au('InsertEnter', {
    pattern = '*',
    command = 'set nornu',
})

au('InsertLeave', {
    pattern = '*',
    command = 'set rnu',
})
-- }}}

-- {{{ autocmd on first insertenter to fix lsp not autostarting
local lsp_au
lsp_au = au('InsertEnter', {
    pattern = '*',
    callback = function()
        vim.cmd('do FileType')

        -- remove after first run
        if vim.bo.filetype ~= 'TelescopePrompt' then
            vim.api.nvim_del_autocmd(lsp_au)
        end
    end,
})
-- }}}
