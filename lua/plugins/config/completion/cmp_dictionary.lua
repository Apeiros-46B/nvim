-- configuration for cmp dictionary source
require('cmp_dictionary').setup({
    dic = {
        norg = { '/usr/share/dict/words' },
        markdown = { '/usr/share/dict/words' },
    },
    exact = 2,
    first_case_insensitive = false,
    document = false,
    document_command = "wn %s -over",
    async = false,
    max_items = -1,
    capacity = 5,
    debug = false,
})
