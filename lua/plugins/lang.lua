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
	-- broken in new nvim
	-- if not semantic_tokens_enabled[client.name] then
	-- 	client.server_capabilities.semanticTokensProvider = {}
	-- end
end

local function md_callout(icon, name, hl)
	return {
		raw = '[!' .. name:upper() .. ']',
		rendered = icon .. ' ' .. name,
		highlight = 'RenderMarkdown' .. hl,
	}
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
			ensure_installed = {
				'asm',
				'awk',
				'bash',
				'bibtex',
				'c',
				'cmake',
				'cpp',
				'css',
				'cuda',
				'diff',
				'doxygen',
				'gdscript',
				'git_config',
				'git_rebase',
				'gitattributes',
				'gitcommit',
				'gitignore',
				'glsl',
				'hlsl',
				'html',
				'java',
				'javadoc',
				'javascript',
				'jq',
				'json',
				'kdl',
				'kotlin',
				-- 'latex',
				'llvm',
				'lua',
				'luadoc',
				-- 'lua patterns',
				'make',
				'markdown',
				'markdown_inline',
				'menhir',
				'nasm',
				'nix',
				'ocaml',
				'ocaml_interface',
				-- 'ocamllex',
				'python',
				'qmldir',
				'qmljs',
				'r',
				'regex',
				'rust',
				'sql',
				'toml',
				'tsx',
				'typescript',
				'vim',
				'vimdoc',
				'yaml',
				'zig',
				'ziggy',
				'ziggy_schema',
			},
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
					on_attach(client, args.buf)
				end
			})
			local servers = {
				jdtls = {},
				clangd = {},
				ocamllsp = {},
				zls = {},

				basedpyright = {},
				ts_ls = {},
				denols = {},
				lua_ls = {},
				uiua = {},

				racket_langserver = {},
				r_language_server = {},

				nil_ls = {},
				qmlls = {},
			}
			for srv, opts in pairs(servers) do
				vim.lsp.config(srv, opts)
				vim.lsp.enable(srv)
			end
			vim.api.nvim_exec_autocmds('FileType', {})
		end,
	},
	{
		'mfussenegger/nvim-dap',
		event = 'VeryLazy',
		config = function()
			local dap = require('dap')
			dap.adapters.gdb = {
				type = 'executable',
				command = 'gdb',
				args = { '--interpreter=dap', '--eval-command', 'set print pretty on' }
			}
			dap.configurations.c = {
				{
					name = 'Launch',
					type = 'gdb',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					args = {},
					cwd = '${workspaceFolder}',
					stopAtBeginningOfMainSubprogram = false,
				},
			}
			dap.configurations.cpp = dap.configurations.c
		end,
		-- TODO
	},
	{
		'igorlfs/nvim-dap-view',
		event = 'VeryLazy',
		opts = {},
		-- TODO
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
	},
	{
		'Apeiros-46B/uiua.vim',
		event = 'VeryLazy',
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
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		ft = { 'markdown', 'Avante' },
		opts = util.opts_with_hl(
			{
				render_modes = { 'n', 'c', 't', 'i', 'v', 'V' },
				file_types = { "markdown", "Avante" },
				nested = false,
				anti_conceal = {
					ignore = {
						bullet = true,
						code_background = true,
						indent = true,
						quote = true,
						sign = true,
					},
				},
				heading = {
					enabled = false,
					position = 'inline',
					-- icons = { '─ ', '── ', '─── ', '──── ', '───── ', '────── ' },
					-- icons = { '─ ', '─ ' },
					-- sign = false,
					-- backgrounds = { 'RenderMarkdownHBg' },
					-- foregrounds = {
					-- 	'@markup.heading.1',
					-- 	'@markup.heading.2',
					-- 	'@markup.heading.3',
					-- 	'@markup.heading.4',
					-- 	'@markup.heading.5',
					-- 	'@markup.heading.6',
					-- },
				},
				-- code = { -- style 1
				-- 	width = 'block',
				-- 	border = 'thin',
				-- 	left_pad = 1,
				-- 	right_pad = 1,
				-- 	language_border = '▄',
				-- 	language_left = '█',
				-- 	language_right = '█',
				-- 	inline_pad = 1,
				-- 	highlight_language = '@comment',
				-- },
				code = { -- style 2
					width = 'full',
					border = 'thick',
					left_pad = 0,
					inline_pad = 1,
					highlight_language = '@comment',
				},
				bullet = {
					icons = { '·', '∘' },
				},
				checkbox = {
					unchecked = { icon = '[ ]' },
					checked   = { icon = '[󰄬]' },
					custom = {
						todo = {
							raw = '[-]',
							rendered = '[-]',
							highlight = 'RenderMarkdownTodo',
						},
					},
				},
				quote = {
					icon = '│',
					repeat_linebreak = true,
				},
				pipe_table = {
					cell = 'raw',
					border_enabled = false,
				},
				callout = {
					note      = md_callout('●', 'Note', 'Info'),
					tip       = md_callout('▼', 'Tip', 'Success'),
					important = md_callout('●', 'Important', 'Hint'),
					warning   = md_callout('▲', 'Warning', 'Warn'),
					caution   = md_callout('▼', 'Caution', 'Error'),
				},
				link = {
					-- TODO
					footnote = { icon = '' }
				},
				win_options = {
					breakindent = {
						default = vim.o.breakindent,
						rendered = true,
					},
				},
			},
			{
				RenderMarkdownCode = { bg = colors.bg_shade },
				RenderMarkdownCodeInline = { fg = colors.blue, bg = colors.bg1 },

				RenderMarkdownBullet = { fg = colors.fg3 },
				RenderMarkdownUnhecked = { fg = colors.fg3 },
				RenderMarkdownChecked = { fg = colors.aqua },
				RenderMarkdownTodo = { fg = colors.yellow },

				RenderMarkdownTableHead = { fg = colors.bg4 },
				RenderMarkdownTableRow  = { fg = colors.bg4 },

				RenderMarkdownInlineHighlight = { fg = colors.yellow, bg = colors.bg_yellow },
			}
		),
	},
}
