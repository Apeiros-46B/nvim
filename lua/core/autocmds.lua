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

-- antlr4
vim.filetype.add({ extension = { g4 = 'antlr4' } })

-- uiua
vim.filetype.add({ extension = { ua = 'uiua' } })
--> format on save
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.ua',
    callback = function(_)
        vim.cmd(([[
            silent! !uiua fmt %s
            mkview
            e
            loadview
        ]]):format(vim.fn.expand('<amatch>')))
    end,
})

-- HVM
vim.filetype.add({ extension = { hvm  = 'hvm'  } })
vim.filetype.add({ extension = { hvmc = 'hvmc' } })
vim.filetype.add({ extension = { hvml = 'hvml' } })
