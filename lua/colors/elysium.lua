local M = {}

M.palette = {
	bg0       = '#ffffff',
	bg1       = '#f4f4f4',
	bg2       = '#ebebeb',
	bg3       = '#e4e4e4',
	bg4       = '#dfdfdf',
	bg5       = '#dcdcdc',
	fg0       = '#333333',
	fg1       = '#202020',
	fg2       = '#000000',
	fg3       = '#777777',
	red       = '#904961',
	orange    = '#934c3d',
	yellow    = '#b5803e',
	green     = '#427138',
	aqua      = '#117555',
	blue      = '#535d9c',
	purple    = '#79508a',
	bg_red    = '#e9dbdf',
	bg_yellow = '#f0e6d8',
	bg_green  = '#d9e3d7',
	bg_aqua   = '#cfe3dd',
	bg_blue   = '#dddfeb',
	bg_purple = '#e4dce8',
	bg_shade  = '#fafafa',
}
M.palette.accent    = M.palette.blue
M.palette.bg_accent = M.palette.bg_blue

M.spec = {
	'Apeiros-46B/elysium',
	lazy = false,
	priority = 1000,
	config = function(plugin)
		vim.opt.rtp:append(plugin.dir .. '/ports/vim')
		vim.cmd('colorscheme elysium')
	end,
}

M.dark = false

return M
