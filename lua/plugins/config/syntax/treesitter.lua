-- configuration for nvim-treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = 'all', -- 'all' | 'maintained' | list of langs
	sync_install     = false,
	ignore_install   = {},

	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
})

-- {{{ haxe
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.haxe = {
    install_info = {
        url = 'https://github.com/vantreeseba/tree-sitter-haxe', -- local path or git repo
        files = { 'src/parser.c' },
        -- optional entries:
        branch = 'main', -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = 'haxe', -- if filetype does not match the parser name
}
-- }}}
