local util = require('util')
local colors = require('colors').palette

return {
	{
		'yetone/avante.nvim',
		version = false,
		build = vim.fn.has('win32') ~= 0
			and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
			or 'make',
		event = 'VeryLazy',
		opts = util.opts_with_hl(
			{
				instructions_file = 'avante.md',
				provider = 'moonshot',
				providers = {
					moonshot = {
						endpoint = 'https://api.moonshot.ai/v1',
						model = 'kimi-k2.5',
						-- model = 'kimi-k2-0905-preview',
						timeout = 30000,
						extra_request_body = {
							temperature = 1.0,
							max_tokens = 32768,
						},
					},
					gemini = {
						model = 'gemini-3-flash-preview',
						timeout = 30000,
					},
				},
				behaviour = {
					auto_approve_tool_permissions = false,
				},
				selection = { enabled = false },
				windows = {
					sidebar_header = {
						align = 'left',
						rounded = false,
					},
					spinner = {
						thinking = { '·', '✢', '✳', '∗', '✻', '✽' },
					},
					input = {
						prefix = '',
						height = 12,
					},
					edit = {
						border = false,
						start_insert = true,
					},
					ask = {
						border = false,
						start_insert = false,
					},
				},
				highlight = {
					diff = {
						current = 'DiffDelete',
						incoming = 'DiffAdd',
					},
				},
			},
			{
				AvanteSidebarNormal                 = { link = 'Normal'              },
				AvanteSidebarWinHorizontalSeparator = { link = 'AvanteSidebarNormal' },
				AvanteSidebarWinSeparator           = { link = 'WinSeparator'        },
				AvanteInlineHint                    = { link = 'AvantePopupHint'     },

				AvanteTitle        = { fg = colors.bg0, bg = colors.bg0      },
				AvanteSubtitle     = { fg = colors.fg0, bg = colors.bg1      },
				AvanteThirdTitle   = { fg = colors.fg0, bg = colors.bg_green },
				AvanteConfirmTitle = { fg = colors.red, bg = colors.bg_red   },

				AvanteButtonDanger       = { fg = colors.red,   bg = colors.bg_red   },
				AvanteButtonDangerHover  = { fg = colors.bg0,   bg = colors.red      },
				AvanteButtonDefault      = { fg = colors.fg0,   bg = colors.bg1      },
				AvanteButtonDefaultHover = { fg = colors.fg0,   bg = colors.bg2      },
				AvanteButtonPrimary      = { fg = colors.green, bg = colors.bg_green },
				AvanteButtonPrimaryHover = { fg = colors.bg0,   bg = colors.green    },

				AvanteStateSpinnerCompacting  = { fg = colors.yellow, bg = colors.bg_yellow },
				AvanteStateSpinnerFailed      = { fg = colors.red,    bg = colors.bg_red    },
				AvanteStateSpinnerGenerating  = { fg = colors.fg3,    bg = colors.bg2       },
				AvanteStateSpinnerSearching   = { fg = colors.yellow, bg = colors.bg_yellow },
				AvanteStateSpinnerSucceeded   = { fg = colors.green,  bg = colors.bg_green  },
				AvanteStateSpinnerThinking    = { fg = colors.purple, bg = colors.bg_purple },
				AvanteStateSpinnerToolCalling = { fg = colors.blue,   bg = colors.bg_blue   },

				AvanteTaskCompleted = { fg = colors.blue,   bold = true },
				AvanteTaskFailed    = { fg = colors.red,    bold = true },
				AvanteTaskRunning   = { fg = colors.purple, bold = true },
				AvanteThinking      = { fg = colors.purple              },

				AvanteConflictCurrent       = { link = 'DiffDelete' },
				AvanteConflictIncoming      = { link = 'DiffAdd'    },
				AvanteConflictCurrentLabel  = { link = 'DiffDelete' },
				AvanteConflictIncomingLabel = { link = 'DiffAdd'    },

				AvanteToBeDeleted = { fg = colors.red, bg = colors.bg_red, strikethrough = true },
				AvanteToBeDeletedWOStrikethrough = { link = 'DiffDelete' },
			}
		),
	}
}
