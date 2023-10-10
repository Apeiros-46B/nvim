-- configuration for nvim-autopairs plugin
local npairs = require('nvim-autopairs')

npairs.setup({
    disable_filetype = { 'fugitive', 'NvimTree', 'TelescopePrompt', 'vim' },
    fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey='Comment'
    },
})

local noquote = npairs.get_rule("'")[1].not_filetypes

noquote[#noquote+1] = 'lisp'
noquote[#noquote+1] = 'uiua'

npairs.get_rule("`").not_filetypes = { 'uiua' }
