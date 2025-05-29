local util = require('util')
local colors = require('core.theme').colors

return {
	{
		'rebelot/heirline.nvim',
		opts = function()
			local conds = require('heirline.conditions')
			local hutils = require('heirline.utils')
			return {
				opts = {
					colors = colors,
					disable_winbar_cb = function(args)
						return conds.buffer_matches({
							buftype = { 'nofile', 'prompt', 'quickfix' },
							filetype = { 'gitsigns-blame', 'toggleterm' },
						}, args.buf)
					end
				},
				statusline = { -- {{{
					hl = { bg = 'bg1' },
					{
						static = {
							mode_colors = {
								n       = 'fg3',
								no      = 'green',
								nov     = 'green',
								noV     = 'green',
								i       = 'blue',
								v       = 'purple',
								V       = 'purple',
								['\22'] = 'purple',
								c       = 'aqua',
								s       = 'purple',
								S       = 'purple',
								['\19'] = 'purple',
								R       = 'red',
								r       = 'red',
								['!']   = 'aqua',
								t       = 'aqua',
							},
							mode_color = function(self)
								local mode = conds.is_active() and vim.fn.mode(1) or 'n'
								return self.mode_colors[mode]
							end,
						},
						provider = ' ',
						hl = function(self)
							return { bg = self:mode_color() }
						end
					},
					{
						provider = function()
							return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':~') .. ' '
						end,
						hl = { bg = 'bg2' },
					},
					{
						provider = function(_)
							local str = require('nvim-navic').get_location({ depth_limit = 10 })
							if str and str ~= '' then
								str = ' %-01.' .. vim.o.columns - 30 .. '(' .. str .. '%) '
							end
							return str
						end,
						update = { 'CursorMoved' },
					},
					{ provider = '%=' },
					{
						condition = function()
							return vim.v.hlsearch ~= 0
						end,
						provider = function()
							local _, res = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 80 })
							local total   = (res and res.total  ) or 0
							local current = (res and res.current) or 0
							return current .. '/' .. total .. ' '
						end,
					},
				}, -- }}}
				winbar = { -- {{{
					hl = { bg = 'bg0', fg = 'fg0' },
					{ provider = ' %f ' },
					{
						condition = function()
							return vim.bo.modified
						end,
						provider = '* ',
						hl = { fg = 'red' },
					},
					{
						condition = function()
							return vim.bo.buftype ~= 'terminal'
							   and vim.bo.buftype ~= 'help'
							   and (not vim.bo.modifiable or vim.bo.readonly)
						end,
						provider = 'RO ',
						hl = { fg = 'bg5' },
					},
					{
						condition = function()
							return vim.bo.fenc ~= '' and vim.bo.fenc ~= 'utf-8'
						end,
						provider = function()
							return '(' .. vim.bo.fenc .. ') '
						end,
						hl = { fg = 'bg5' },
					},
					{
						provider = '%=',
						hl = { bg = 'bg0' },
					}
				}, -- }}}
				tabline = { -- {{{
					hl = { bg = 'bg1', fg = 'fg3' },
					static = {
						is_nvim_tree = function(self)
							local windows = vim.api.nvim_tabpage_list_wins(0)
							if #windows <= 1 then
								return false
							end
							self.winid = windows[1]
							local bufnr = vim.api.nvim_win_get_buf(self.winid)
							return vim.bo[bufnr].filetype == 'NvimTree'
						end,
					},
					{
						condition = function(self) return self:is_nvim_tree() end,
						provider = function(self)
							return string.rep(' ', vim.api.nvim_win_get_width(self.winid))
						end,
						hl = 'NvimTreeNormal',
					},
					{
						condition = function(self) return self:is_nvim_tree() end,
						provider = ' ',
						hl = 'VertSplit',
					},
					-- TODO: buffer switcher
					hutils.make_buflist {
						condition = function(self)
							return not conds.buffer_matches({
								buftype = { 'nofile', 'prompt', 'quickfix', 'terminal' },
								filetype = {},
							}, self.bufnr)
						end,
						provider = function(self)
							local name = vim.api.nvim_buf_get_name(self.bufnr)
							if name == '' then
								name = '[No Name]'
							else
								name = vim.fn.fnamemodify(name, ':t')
							end
							return ' ' .. name .. ' '
						end,
						hl = function(self)
							return {
								bg = self.is_active and 'bg_accent' or nil,
								fg = (self.is_active or self.is_visible) and 'fg2' or nil,
							}
						end,
					},
					{
						provider = '%=',
						hl = { bg = 'bg0' },
					},
					hutils.make_tablist {
						provider = function(self)
							return ' ' .. self.tabnr .. ' '
						end,
						hl = function(self)
							return {
								bg = self.is_active and 'bg_accent' or nil,
								fg = self.is_active and 'fg2' or nil,
							}
						end,
					},
				}, -- }}}
			}
		end,
	},
	{
		-- TODO: fix bufdelete errors and spontaneous <C-g>
		'Apeiros-46B/nvim-scrlbkun',
		cond = true,
		event = 'VeryLazy',
		opts = util.opts_with_hl(
			{
				width = 1,
				winblend = 0,
				fadeout_time = 0,
				excluded_filetypes = { 'NvimTree', 'terminal' },
				excluded_buftypes = { 'prompt' },
				cursor = {
					priority = 1000,
					signs = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
				},
				search = {
					draw_events_tab = {
						'TextChanged',
						'TextChangedI',
						'TextChangedP',
						'TabEnter',
						{ 'CmdlineLeave', {'/', '\\?', ':'} },
						{ 'CmdlineChanged', {'/', '\\?'} },
						{ 'User', { 'SearchCleared' } },
					},
				},
				diagnostics = { draw_columns = { 1 } },
				githunks = { enabled = false },
			},
			{
				ScrlbkunBar              = { bg = colors.bg1     },
				ScrlbkunCursor           = { fg = colors.blue    },
				ScrlbkunSearch           = { fg = colors.bg_aqua },
				ScrlbkunDiagnosticsError = { fg = colors.red     },
				ScrlbkunDiagnosticsWarn  = { fg = colors.yellow  },
				ScrlbkunDiagnosticsInfo  = { fg = colors.aqua    },
				ScrlbkunDiagnosticsHint  = { fg = colors.blue    },
				ScrlbkunGithunksAdd      = { fg = colors.green   },
				ScrlbkunGithunksDelete   = { fg = colors.red     },
				ScrlbkunGithunksChange   = { fg = colors.blue    },
			}
		),
	},
	{
		'j-hui/fidget.nvim',
		event = 'VeryLazy',
		opts = {
		},
	},
	{
		'nvim-telescope/telescope-ui-select.nvim',
		event = 'VeryLazy',
		config = function()
			require('telescope').load_extension('ui-select')
		end
	},
}
