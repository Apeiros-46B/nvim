local util = require('util')
local colors = require('colors').palette

local semantic_tokens_enabled = {
 	['rust-analyzer'] = true
}
local function on_attach(client, bufnr)
	if not client then return end
	if client:supports_method('textDocument/documentSymbol') then
		require('nvim-navic').attach(client, bufnr)
	end
	if not semantic_tokens_enabled[client.name] then
		client.server_capabilities.semanticTokensProvider = {}
	end
end

return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'master',
		build = ':TSUpdate',
		dependencies = { 'RRethy/nvim-treesitter-endwise' },

		event = 'VeryLazy',
		cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
		opts = {
			ensure_installed = 'all',
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
		},
		main = 'nvim-treesitter.configs',
	},
	{
		'neovim/nvim-lspconfig',
		event = 'VeryLazy',
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					on_attach(client, args.buf) end
			})
			local servers = {
				lua_ls = {},
				nil_ls = {},
				ts_ls = {},
				basedpyright = {},
				zls = {},
				ts_ls = {},
				uiua = {},
				qmlls = {
					cmd = { 'qmlls', '-E' }
				},
			}
			for srv, opts in pairs(servers) do
				vim.lsp.config(srv, opts)
				vim.lsp.enable(srv)
			end
		end,
	},
	{
		'mrcjkb/rustaceanvim',
		lazy = false,
		init = function()
			vim.g.rustaceanvim = {
				tools = {
					hover_actions = {
						replace_builtin_hover = false,
					},
				},
				server = {
					on_attach = on_attach,
					settings = {
						['rust-analyzer'] = {
							checkOnSave = true,
							imports = {
								granularity = {
									enforce = true,
								},
								merge = {
									glob = false,
								},
							},
							inlayHints = {
								closureStyle = 'rust_analyzer',
								expressionAdjustmentHints = { enable = 'reborrow' },
								lifetimeElisionHints = { enable = 'skip_trivial', },
							},
						}
					}
				},
			}
		end,
	},
	{
		'mfussenegger/nvim-jdtls',
		event = 'VeryLazy',
		-- TODO: configure
	},
	{
		'Apeiros-46B/uiua.vim',
		filetype = 'uiua',
		init = function()
			vim.g.uiua_recommended_style = 1
			vim.g.uiua_format_on_save = 1
			vim.g.uiua_dark_mode = require('colors').dark
		end,
		config = function()
			util.hl {
				uiuaRed              = { fg = colors.red    },
				uiuaOrange           = { fg = colors.orange },
				uiuaYellow           = { fg = colors.yellow },
				uiuaBeige            = { fg = colors.yellow },
				uiuaGreen            = { fg = colors.green  },
				uiuaAqua             = { fg = colors.aqua   },
				uiuaBlue             = { fg = colors.blue   },
				uiuaIndigo           = { fg = colors.purple },
				uiuaPurple           = { fg = colors.purple },
				uiuaPink             = { fg = colors.purple },
				uiuaLightPink        = { fg = colors.purple },
				uiuaFaded            = { fg = colors.fg3    },
				uiuaForegroundDark   = { fg = colors.fg0    },
				uiuaForegroundLight  = { fg = colors.fg0    },
				uiuaMacroSpecial     = { link = 'uiuaRed'      },
				uiuaPunctuation      = { link = 'uiuaFaded'    },
				uiuaMonadicP         = { link = 'uiuaOrange'   },
				uiuaDyadicP          = { link = 'uiuaOrange'   },
				uiuaPentadic         = { link = 'uiuaPurple'   },
				uiuaNum              = { link = 'uiuaPurple'   },
				uiuaNumShadow        = { link = 'uiuaNum'      },
				uiuaEsc              = { link = 'uiuaYellow'   },
				uiuaFmt              = { link = 'uiuaIndigo'   },
				uiuaUnicodeLiteral   = { link = 'uiuaIndigo'   },
				uiuaSignature        = { link = 'uiuaYellow'   },
				uiuaModPunct         = { link = 'uiuaFaded'    },
				uiuaLabel            = { link = 'uiuaAqua'     },
				uiuaSemanticComment  = { link = 'uiuaRed'      },
				uiuaSignatureComment = { link = 'uiuaPurple'   },
				uiuaComment          = { link = 'Comment'      },
			}
		end,
	},
	{
		'smjonas/inc-rename.nvim',
		event = 'LspAttach',
		cmd = 'IncRename',
		keys = { { '<leader>lr', ':IncRename ', mode = 'n' } },
		opts = {},
	},
	{
		url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		branch = 'main',
		event = 'LspAttach',
		keys = { { '<leader>ll', '<cmd>lua require("lsp_lines").toggle()<CR>' } },
		opts = {},
	},
	{
		'SmiteshP/nvim-navic',
		event = 'VeryLazy',
		opts = util.opts_with_hl(
			{
				icons = {
					File          = '󰈙 ',
					Module        = '󰏓 ',
					Namespace     = '󰏓 ',
					Package       = '󰏓 ',
					Class         = '󰠱 ',
					Method        = '󰆧 ',
					Property      = '󰜢 ',
					Field         = ' ',
					Constructor   = ' ',
					Enum          = ' ',
					Interface     = '󰕘 ',
					Function      = '󰊕 ',
					Variable      = '󰀫 ',
					Constant      = '󰏿 ',
					String        = ' ',
					Number        = ' ',
					Boolean       = ' ',
					Array         = '󰅪 ',
					Object        = '󰅩 ',
					Key           = '󰌋 ',
					Null          = '󰟢 ',
					EnumMember    = ' ',
					Struct        = '󰙅 ',
					Event         = ' ',
					Operator      = '󰆕 ',
					TypeParameter = '󰊄 ',
				},
				lsp = {
					auto_attach = false,
					preference = nil,
				},
				highlight = true,
				click = true,
				depth_limit_indicator = '..',
				separator = '  ',
			},
			{
				NavicIconsField         = { fg = colors.red    },
				NavicIconsConstant      = { fg = colors.orange },
				NavicIconsOperator      = { fg = colors.orange },
				NavicIconsEnum          = { fg = colors.yellow },
				NavicIconsEnumMember    = { fg = colors.yellow },
				NavicIconsConstructor   = { fg = colors.green  },
				NavicIconsFunction      = { fg = colors.green  },
				NavicIconsKey           = { fg = colors.green  },
				NavicIconsMethod        = { fg = colors.green  },
				NavicIconsProperty      = { fg = colors.green  },
				NavicIconsInterface     = { fg = colors.aqua   },
				NavicIconsTypeParameter = { fg = colors.aqua   },
				NavicIconsArray         = { fg = colors.blue   },
				NavicIconsBoolean       = { fg = colors.blue   },
				NavicIconsNumber        = { fg = colors.blue   },
				NavicIconsObject        = { fg = colors.blue   },
				NavicIconsString        = { fg = colors.blue   },
				NavicIconsVariable      = { fg = colors.blue   },
				NavicIconsClass         = { fg = colors.purple },
				NavicIconsEvent         = { fg = colors.purple },
				NavicIconsStruct        = { fg = colors.purple },
				NavicIconsFile          = { fg = colors.fg0    },
				NavicIconsModule        = { fg = colors.fg0    },
				NavicIconsNamespace     = { fg = colors.fg0    },
				NavicIconsNull          = { fg = colors.fg0    },
				NavicIconsPackage       = { fg = colors.fg0    },
				NavicText               = { fg = colors.fg3    },
				NavicSeparator          = { fg = colors.fg3    },
			}
		),
	},
	{
		url = 'https://git.sr.ht/~hedy/outline.nvim',
		lazy = true,
		cmd = { 'Outline', 'OutlineOpen' },
		keys = { { '<leader>lo', '<cmd>Outline<CR>' } },
		opts = {
			-- TODO
		},
	},
}
