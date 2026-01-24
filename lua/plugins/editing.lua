local util = require('util')
local colors = require('colors').palette

return {
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = { disable_filetype = { 'TelescopePrompt', 'uiua' } },
	},
	{
		'windwp/nvim-ts-autotag',
		event = 'InsertEnter',
		opts = {},
	},
	{
		'kylechui/nvim-surround',
		event = 'VeryLazy',
		opts = {
			keymaps = {
				insert          = '<C-g>s',
				insert_line     = '<C-g>S',
				normal          = 'ys',
				normal_cur      = 'yss',
				normal_line     = 'yS',
				normal_cur_line = 'ySS',
				visual          = 'S',
				visual_line     = 'gS',
				delete          = 'ds',
				change          = 'cs',
			},
			highlight = { duration = 0 },
			move_cursor = 'begin',
		},
	},
	{
		'Wansmer/treesj',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		keys = {
			{
				'gs', mode = 'n',
				function()
					local ok, _ = pcall(vim.treesitter.get_parser, 0)
					if ok then
						require('treesj').toggle()
					else
						-- fallback to mini.splitjoin if there is no TS parser
						require('mini.splitjoin').toggle()
					end
				end,
			},
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 240,
		},
	},
	{
		'nvim-mini/mini.splitjoin',
		lazy = true,
		opts = { mappings = { toggle = '' } },
	},
	{
		'nvim-mini/mini.align',
		keys = {
			{ 'ga', mode = { 'n', 'v' } },
			{ 'gA', mode = { 'n', 'v' } },
		},
		opts = {},
	},
	{
		'nvim-mini/mini.trailspace',
		event = 'VeryLazy',
		keys = {
			{ 'gS', '<cmd>lua require("mini.trailspace").trim()<CR>', mode = 'n' }
		},
		opts = util.opts_with_hl({}, {
			MiniTrailspace = { bg = colors.bg_yellow },
		}),
	},
	{
		'ggandor/leap.nvim',
		keys = {
			{ 's', '<Plug>(leap)', mode = 'n' },
			{ 's', '<Plug>(leap)', mode = 'o' },
		},
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-path',
			-- 'quangnguyen30192/cmp-nvim-ultisnips',
		},
		event = 'InsertEnter',
		opts = function()
			local cmp = require('cmp')
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

			util.hl {
				Cmp       = { fg = 'NONE',     bg = colors.bg1     },
				CmpSel    = { fg = 'NONE',     bg = colors.bg_blue },
				CmpBorder = { fg = colors.bg1, bg = colors.bg1     },

				CmpItemAbbrDeprecated = { fg = colors.fg3,  strikethrough = true },
				CmpItemAbbrMatch      = { fg = colors.aqua, bold          = true },
				CmpItemAbbrMatchFuzzy = { fg = colors.aqua                       },
				CmpItemAbbrMenu       = { fg = colors.blue                       },

				CmpItemKindField         = { fg = colors.red     },
				CmpItemKindKeyword       = { fg = colors.red     },
				CmpItemKindModule        = { fg = colors.red     },
				CmpItemKindConstant      = { fg = colors.orange  },
				CmpItemKindOperator      = { fg = colors.orange  },
				CmpItemKindSnippet       = { fg = colors.orange  },
				CmpItemKindUnit          = { fg = colors.orange  },
				CmpItemKindEnum          = { fg = colors.yellow  },
				CmpItemKindEnumMember    = { fg = colors.yellow  },
				CmpItemKindReference     = { fg = colors.yellow  },
				CmpItemKindConstructor   = { fg = colors.green   },
				CmpItemKindFunction      = { fg = colors.green   },
				CmpItemKindMethod        = { fg = colors.green   },
				CmpItemKindProperty      = { fg = colors.green   },
				CmpItemKindColor         = { fg = colors.aqua    },
				CmpItemKindInterface     = { fg = colors.aqua    },
				CmpItemKindTypeParameter = { fg = colors.aqua    },
				CmpItemKindVariable      = { fg = colors.blue    },
				CmpItemKindClass         = { fg = colors.purple  },
				CmpItemKindEvent         = { fg = colors.purple  },
				CmpItemKindStruct        = { fg = colors.purple  },
				CmpItemKindValue         = { fg = colors.purple  },
				CmpItemKindFile          = { fg = colors.fg0     },
				CmpItemKindFolder        = { fg = colors.fg0     },
				CmpItemKindText          = { fg = colors.fg3     },
			}
			local kind_map = {
				Text          = 'text',
				Method        = 'method',
				Function      = 'func',
				Constructor   = 'ctor',
				Field         = 'field',
				Variable      = 'var',
				Class         = 'class',
				Interface     = 'trait',
				Module        = 'module',
				Property      = 'prop',
				Unit          = 'unit',
				Value         = 'value',
				Enum          = 'enum',
				Keyword       = 'keyw',
				Snippet       = 'snip',
				Color         = 'color',
				File          = 'file',
				Reference     = 'ref',
				Folder        = 'dir',
				EnumMember    = 'enumv',
				Constant      = 'const',
				Struct        = 'struct',
				Event         = 'event',
				Operator      = 'oper',
				TypeParameter = 'type',
			}

			return {
				enabled = function()
					return vim.bo.filetype ~= 'TelescopePrompt'
				end,
				view = {
					entries = { name = 'custom', selection_order = 'near_cursor' }
				},
				window = {
					completion = {
						winhighlight = 'Normal:Cmp,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None',
						col_offset = -1,
						side_padding = 0,
					},
				},
				formatting = {
					fields = { 'kind', 'abbr', 'menu' },
					format = function(_, item)
						item.menu = '(' .. (kind_map[item.kind] or 'other') .. ') '
						item.kind_hl_group = 'CmpItemKind' .. item.kind
						item.kind = '█'
						return item
					end,
				},

				completion = { keyword_length = 1 },
				preselect = cmp.PreselectMode.None,
				mapping = {
					['<C-Space>'] = cmp.mapping.complete(),
					['<Tab>']     = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
					['<S-Tab>']   = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
					['<C-j>']     = cmp.mapping.scroll_docs(1),
					['<C-k>']     = cmp.mapping.scroll_docs(-1),
					['<C-e>']     = cmp.mapping.close(),
					['<CR>']      = cmp.mapping.confirm { cmp.ConfirmBehavior.Insert, select = true },
				},

				sources = cmp.config.sources {
					-- { name = 'ultisnips', priority = 3 },
					{ name = 'nvim_lsp',  priority = 2 },
					{ name = 'path',      priority = 1 },
				},
				snippet = {
					-- expand = function(args)
					-- 	vim.fn['UltiSnips#Anon'](args.body)
					-- end
				},
			}
		end,
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		event = 'LspAttach',
	},
	-- {
	-- 	'SirVer/ultisnips',
	-- 	ft = 'snippets',
	-- 	event = 'InsertEnter',
	-- 	init = function()
	-- 		vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
	-- 		vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
	-- 		vim.g.UltiSnipsEdit = 'vertical'
	-- 		vim.g.UltiSnipsSnippetDirectories = {
	-- 			'UltiSnips',
	-- 			vim.fn.stdpath('config') .. '/snippets',
	-- 		}
	-- 	end
	-- },
	{
		'jbyuki/venn.nvim',
		cmd = { 'VBox' },
		keys = {
			{
				'<leader>v',
				function()
					local venn_enabled = vim.inspect(vim.b.venn_enabled)
					if venn_enabled == "nil" then
						vim.b.venn_enabled = true
						vim.cmd 'setlocal ve=all'
						vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
						vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
						vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
						vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
						vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>",       { noremap = true })
					else
						vim.b.venn_enabled = nil
						vim.cmd 'setlocal ve='
						vim.api.nvim_buf_del_keymap(0, "n", "H")
						vim.api.nvim_buf_del_keymap(0, "n", "J")
						vim.api.nvim_buf_del_keymap(0, "n", "K")
						vim.api.nvim_buf_del_keymap(0, "n", "L")
						vim.api.nvim_buf_del_keymap(0, "v", "f")
					end
				end,
				mode = 'n'
			}
		},
	},
}
