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

local sq_not_ft = npairs.get_rule("'")[1].not_filetypes

sq_not_ft[#sq_not_ft+1] = 'lisp'
sq_not_ft[#sq_not_ft+1] = 'uiua'
