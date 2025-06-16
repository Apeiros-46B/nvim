local util = require('util')

return {
	{
		'lewis6991/gitsigns.nvim',
		event = 'VeryLazy',
		cmd = 'Gitsigns',
		keys = {
			{ ']c', '<cmd>lua require("gitsigns.actions").next_hunk()<CR>'                },
			{ '[c', '<cmd>lua require("gitsigns.actions").prev_hunk()<CR>'                },
			{ 'ih', ':<C-U>lua require("gitsigns.actions").select_hunk()<CR>', mode = 'o' },
			{ 'ih', ':<C-U>lua require("gitsigns.actions").select_hunk()<CR>', mode = 'x' },

			{ '<leader>gS', '<cmd>lua require("gitsigns").stage_buffer()<CR>'    },
			{
				'<leader>gs',
				'<cmd>lua require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })<CR>',
				mode = 'v'
			},
			{ '<leader>gs', '<cmd>lua require("gitsigns").stage_hunk()<CR>'      },
			{ '<leader>gu', '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>' },
			{ '<leader>gp', '<cmd>lua require("gitsigns").preview_hunk()<CR>'    },

			{ '<leader>gR', '<cmd>lua require("gitsigns").reset_buffer()<CR>' },
			{
				'<leader>gr',
				'<cmd>lua require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })<CR>',
				mode = 'v'
			},
			{ '<leader>gr', '<cmd>lua require("gitsigns").reset_hunk()<CR>'   },

			{ '<leader>gB',  '<cmd>Gitsigns blame<CR>'                     },
			{ '<leader>gb',  '<cmd>Gitsigns blame_line<CR>'                },
			{ '<leader>gtb', '<cmd>Gitsigns toggle_current_line_blame<CR>' },
		},
		opts = util.opts_with_hl(
			{
				signs = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '🭻' },
					topdelete    = { text = '🭶' },
					changedelete = { text = '━' },
				},
				signs_staged = {
					add          = { text = '│' },
					change       = { text = '│' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '─' },
				},
				signcolumn = true,
				auto_attach = true,
				current_line_blame_opts = { virt_text_pos = 'right_align' },
				current_line_blame_formatter = '<author> (<author_time:%R>): <summary>',
			},
			{
				GitSignsStagedAdd          = { link = 'GitSignsAdd'          },
				GitSignsStagedChange       = { link = 'GitSignsChange'       },
				GitSignsStagedDelete       = { link = 'GitSignsDelete'       },
				GitSignsStagedChangedelete = { link = 'GitSignsChangedelete' },
				GitSignsStagedTopdelete    = { link = 'GitSignsTopdelete'    },
			}
		),
	}
}
