local util = require('util')
local colors = require('colors').palette

return {
  {
		'jghauser/mkdir.nvim',
		event = 'VeryLazy',
	},
	{
		'akinsho/toggleterm.nvim',
		cmd = { 'ToggleTerm' },
		keys = {
			{ '<M-d>', '<cmd>ToggleTerm<CR>',            mode = 'n' },
			{ '<M-d>', '<C-\\><C-n><cmd>ToggleTerm<CR>', mode = 't' },
		},
		opts = {
			direction = 'float',
			shade_terminals = false,
			float_opts = {
				border = 'solid',
				winblend = 0,
			},
			highlights = {
				NormalFloat = { guibg = colors.bg1   },
				FloatBorder = { link = 'NormalFloat' },
			},
			on_open = function(_)
				vim.defer_fn(function() vim.cmd('startinsert') end, 5)
			end
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		keys = {
			{ '<leader>fb',      '<cmd>Telescope buffers<CR>',                       mode = 'n' },
			{ '<leader>fd',      '<cmd>Telescope diagnostics<CR>',                   mode = 'n' },
			{ '<leader>ff',      '<cmd>Telescope find_files<CR>',                    mode = 'n' },
			{ '<leader>fg',      '<cmd>Telescope git_files<CR>',                     mode = 'n' },
			{ '<leader>fh',      '<cmd>Telescope help_tags<CR>',                     mode = 'n' },
			{ '<leader>fj',      '<cmd>Telescope jumplist<CR>',                      mode = 'n' },
			{ '<leader>fl',      '<cmd>Telescope reloader<CR>',                      mode = 'n' },
			{ '<leader>fo',      '<cmd>Telescope vim_options<CR>',                   mode = 'n' },
			{ '<leader>fp',      '<cmd>Telescope builtin<CR>',                       mode = 'n' },
			{ '<leader>fr',      '<cmd>Telescope oldfiles<CR>',                      mode = 'n' },
			{ '<leader>fR',      '<cmd>Telescope resume<CR>',                        mode = 'n' },
			{ '<leader>fw',      '<cmd>Telescope live_grep<CR>',                     mode = 'n' },
			{ "<leader>f'",      '<cmd>Telescope marks<CR>',                         mode = 'n' },
			{ '<leader>f"',      '<cmd>Telescope registers<CR>',                     mode = 'n' },
			{ '<leader>f/',      '<cmd>Telescope search_history<CR>',                mode = 'n' },
			{ '<leader>gfc',     '<cmd>Telescope git_commits<CR>',                   mode = 'n' },
			{ '<leader>gfb',     '<cmd>Telescope git_branches<CR>',                  mode = 'n' },
			{ '<leader>lfd',     '<cmd>Telescope lsp_definitions<CR>',               mode = 'n' },
			{ '<leader>lft',     '<cmd>Telescope lsp_type_definitions<CR>',          mode = 'n' },
			{ '<leader>lfr',     '<cmd>Telescope lsp_references<CR>',                mode = 'n' },
			{ '<leader>lfi',     '<cmd>Telescope lsp_implementations<CR>',           mode = 'n' },
			{ '<leader>lfc',     '<cmd>Telescope lsp_incoming_calls<CR>',            mode = 'n' },
			{ '<leader>lfC',     '<cmd>Telescope lsp_outgoing_calls<CR>',            mode = 'n' },
			{ '<leader>lfs',     '<cmd>Telescope lsp_document_symbols<CR>',          mode = 'n' },
			{ '<leader>lfw',     '<cmd>Telescope lsp_workspace_symbols<CR>',         mode = 'n' },
			{ '<leader>lf<C-s>', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', mode = 'n' },
		},
		opts = function()
			local actions = require('telescope.actions')
			util.hl {
				TelescopeNormal         = { bg = colors.bg1, fg = colors.fg3 },
				TelescopeBorder         = { bg = colors.bg1, fg = colors.bg1 },
				TelescopeResultsTitle   = { bg = colors.bg1, fg = colors.bg1 },

				TelescopePromptNormal   = { bg = colors.bg2                     },
				TelescopePromptBorder   = { bg = colors.bg2,    fg = colors.bg2 },
				TelescopePromptTitle    = { bg = colors.purple, fg = colors.bg0 },
				TelescopePromptCounter  = {                     fg = colors.fg3 },

				TelescopePreviewTitle   = { bg = colors.purple, fg = colors.bg0 },

				TelescopeSelection      = { bg = colors.bg_accent, fg = colors.fg0, bold = true },

				TelescopeMultiIcon      = { fg = colors.purple            },
				TelescopeMultiSelection = { fg = colors.fg0               },
				TelescopeMatching       = { fg = colors.aqua, bold = true },
			}
			return {
				defaults = {
					prompt_prefix   = ' ',
					selection_caret = ' ',
					entry_prefix    = ' ',
					multi_icon      = '*',

					sorting_strategy = 'ascending',
					layout_strategy  = 'flex',
					layout_config    = {
						prompt_position = 'top',
						flex = {
							flip_columns = 130,
							vertical = {
								mirror = true,
							},
						},
					},
					mappings = {
						i = {
							['<C-o>'] = function(prompt_bufnr)
								actions.select_default(prompt_bufnr)
								require('telescope.builtin').resume()
							end,
							['<C-n>'] = actions.move_selection_next,
							['<C-p>'] = actions.move_selection_previous,
							['<C-j>'] = actions.preview_scrolling_down,
							['<C-k>'] = actions.preview_scrolling_up,
							['<C-d>'] = actions.close,
							['<Esc>'] = function(_)
								vim.api.nvim_input('<C-\\><C-n>')
								vim.schedule(function()
									vim.wo.number = false
									vim.wo.relativenumber = false
								end)
							end,
						},
						n = {
							['<C-j>'] = actions.preview_scrolling_down,
							['<C-k>'] = actions.preview_scrolling_up,
							['<C-d>'] = actions.close,
						}
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = false,
						override_file_sorter = true,
						case_mode = 'smart_case',
					},
					['ui-select'] = {
						require('telescope.themes').get_dropdown({}),
					}
				},
			}
		end,
		config = function(_, opts)
			local telescope = require('telescope')
			telescope.setup(opts)
		end
	},
	{
		'nvim-tree/nvim-tree.lua',
		cmd = {
			'NvimTreeFocus',
			'NvimTreeToggle',
			'NvimTreeOpen',
		},
		keys = { { '<M-n>', '<cmd>NvimTreeToggle<CR>', mode = 'n' } },
		opts = util.opts_with_hl(
			{
				hijack_cursor = true,
				reload_on_bufenter = true,
				sync_root_with_cwd = true,
				modified = { enable = true },
				view = { signcolumn = 'no' },
				renderer = {
					add_trailing = true,
					group_empty = true,
					special_files = {
						'Makefile',
						'CMakeLists.txt',
						'Cargo.toml',
						'build.zig',
						'pom.xml',
						'flake.nix',
						'shell.nix',
						'README.md',
						'README.org',
						'README',
						'LICENSE',
					},
					indent_markers = { enable = true },

					highlight_git          = 'none',
					highlight_modified     = 'icon',
					highlight_hidden       = 'all',
					highlight_clipboard    = 'all',
					highlight_opened_files = 'name',
					icons = {
						bookmarks_placement = 'after',
						git_placement       = 'right_align',

						show = {
							file         = false,
							folder_arrow = false,
						},
						glyphs = {
							modified = '*',
							symlink  = '󰌹',
							bookmark = '',
							folder = {
								default      = '',
								open         = '',
								empty        = '',
								empty_open   = '',
								symlink      = '',
								symlink_open = '',
							},
							git = {
								unstaged  = '~',
								staged    = '󰄬',
								unmerged  = '',
								renamed   = '',
								untracked = '',
								deleted   = '',
								ignored   = '',
							},
						},
						symlink_arrow = '  ',
					}
				},
				filters = {
					custom = {
						'^\\.git$',
						'^\\.direnv$',
					},
				},
				live_filter = {
					prefix = ' ',
					always_show_folders = false,
				},
				actions = {
					change_dir = { global = true },
				},
				ui = {
					confirm = { default_yes = true },
				},
			},
			{
				NvimTreeNormal       = { bg = colors.bg_shade                              },
				NvimTreeEndOfBuffer  = { bg = colors.bg_shade                              },
				NvimTreeWindowPicker = { bg = colors.bg_blue, fg = colors.fg0, bold = true },
				NvimTreeIndentMarker = { fg = colors.bg5                                   },

				NvimTreeCursorLine = { bg = colors.bg1 },

				NvimTreeRootFolder        = { fg = colors.fg3                 },
				NvimTreeFolderIcon        = { fg = colors.fg3                 },
				NvimTreeFolderName        = { fg = colors.blue                },
				NvimTreeEmptyFolderName   = { fg = colors.blue                },
				NvimTreeOpenedFolderName  = { fg = colors.blue                },
				NvimTreeSymlinkFolderName = { fg = colors.aqua,   bold = true },
				NvimTreeSymlink           = { fg = colors.aqua,   bold = true },
				NvimTreeExecFile          = { fg = colors.green,  bold = true },
				NvimTreeSpecialFile       = { fg = colors.purple              },

				NvimTreeModifiedFile   = { fg = colors.red       },
				NvimTreeHiddenIcon     = { fg = colors.fg3       },
				NvimTreeGitDeletedIcon = { fg = colors.red       },
				NvimTreeGitDirtyIcon   = { fg = colors.blue      },
				NvimTreeGitIgnoredIcon = { fg = colors.fg3       },
				NvimTreeGitMergeIcon   = { fg = colors.purple    },
				NvimTreeGitNewIcon     = { fg = colors.green     },
				NvimTreeGitRenamedIcon = { fg = colors.aqua      },
				NvimTreeGitStagedIcon  = { fg = colors.green     },

				NvimTreeOpenedHL = { bold = true },
				NvimTreeCutHL    = { bg = colors.bg_red,    fg = colors.fg0 },
				NvimTreeCopiedHL = { bg = colors.bg_purple, fg = colors.fg0 },
			}
		),
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		event = 'VeryLazy',
		config = function(_, _)
			require('telescope').load_extension('fzf')
		end,
	},
	{
		'nosduco/remote-sshfs.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
		event = 'VeryLazy',
		keys = {
			{ '<leader>rc',  '<cmd>RemoteSSHFSConnect<CR>',    mode = 'n' },
			{ '<leader>rd',  '<cmd>RemoteSSHFSDisconnect<CR>', mode = 'n' },
			{ '<leader>rff', '<cmd>RemoteSSHFSFindFiles<CR>',  mode = 'n' },
			{ '<leader>rfw', '<cmd>RemoteSSHFSLiveGrep<CR>',   mode = 'n' },
		},
		opts = {
			connections = {
				ssh_configs = { vim.fn.expand('$HOME') .. '/.ssh/config' },
			},
		},
		config = function(_, opts)
			require('remote-sshfs').setup(opts)
			require('telescope').load_extension('remote-sshfs')
		end,
	},
	{
		'Apeiros-46B/qalc.nvim',
		cmd = { 'Qalc' },
	},
}
