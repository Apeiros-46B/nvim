-- configuration for telescope fuzzy finder
return function(theme)
    -- {{{ imports
    local colors    = theme.colors
    local telescope = require('telescope')
    local actions   = require('telescope.actions')
    -- }}}

    -- {{{ setup
    telescope.setup({
    	defaults = {
            -- prefixes
            prompt_prefix   = '   ',
    		selection_caret = '  ',
    		entry_prefix    = '   ',
            multi_icon      = '*',

            -- ascending sort
    		sorting_strategy = 'ascending',

            -- Layout
            layout_strategy = 'horizontal',
            layout_config = {
                horizontal = {
                    -- Put the search box at the top
                    prompt_position = 'top',
                },
            },
            mappings = {
                i = {
                    ['<C-o>'] = function(prompt_bufnr)
                        actions.select_default(prompt_bufnr)
                        require('telescope.builtin').resume()
                    end,

                    -- scroll preview with ctrl j and ctrl k
                    ['<C-j>'] = actions.preview_scrolling_down,
                    ['<C-k>'] = actions.preview_scrolling_up,

                    -- close with ctrl d
                    ['<C-d>'] = actions.close,

                    ['<Esc>'] = function(_)
                        -- go to normal mode
                        vim.api.nvim_input('<C-\\><C-n>')

                        -- disable line numbers in normal mode
                        vim.defer_fn(function()
                            vim.wo.number = false
                            vim.wo.relativenumber = false
                        end, 0)
                    end,
                },
                n = {
                    -- scroll preview with ctrl j and ctrl k
                    ['<C-j>'] = actions.preview_scrolling_down,
                    ['<C-k>'] = actions.preview_scrolling_up,

                    -- close with ctrl d
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
                require('telescope.themes').get_cursor()

                -- pseudo code / specification for writing custom displays, like the one
                -- for 'codeactions'
                -- specific_opts = {
                --   [kind] = {
                --     make_indexed = function(items) -> indexed_items, width,
                --     make_displayer = function(widths) -> displayer
                --     make_display = function(displayer) -> function(e)
                --     make_ordinal = function(e) -> string
                --   },
                --   -- for example to disable the custom builtin 'codeactions' display
                --      do the following
                --   codeactions = false,
                -- }
            }
    	},
    })

    -- {{{ ignore files that are larger than a certain size
    local previewers = require('telescope.previewers')
    local new_maker = function(filepath, bufnr, opts)
    	opts = opts or {}

    	filepath = vim.fn.expand(filepath)

        ---@diagnostic disable-next-line: redundant-parameter
    	vim.loop.fs_stat(filepath, function(_, stat)
    		if not stat then
    			return
    		end
    		if stat.size > 100000 then
    			return
    		else
    			previewers.buffer_previewer_maker(filepath, bufnr, opts)
    		end
    	end)
    end

    telescope.setup({
    	defaults = {
    		buffer_previewer_maker = new_maker,
    	},
    })
    -- }}}

    telescope.load_extension('fzf')
    -- }}}

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        -- {{{ general
        TelescopeNormal         = { bg = colors.gray2,     fg = colors.gray7               },
        TelescopeSelection      = { bg = colors.visual_bg, fg = colors.white,  bold = true },

        TelescopeMultiIcon      = { bg = colors.gray2,     fg = colors.purple              },
        TelescopeMultiSelection = { bg = colors.gray2,     fg = colors.white               },

        TelescopeMatching       = {                        fg = colors.purple, bold = true },
        TelescopeBorder         = { bg = colors.gray2,     fg = colors.gray2               },
        -- }}}

        -- {{{ prompt
        TelescopePromptNormal  = { bg = colors.gray3                     },

        TelescopePromptBorder  = { fg = colors.gray3, bg = colors.gray3  },
        TelescopePromptCounter = { fg = colors.gray8, bg = colors.gray3  },
        TelescopePromptTitle   = { fg = colors.gray1, bg = colors.purple },
        -- }}}

        -- {{{ preview
        TelescopePreviewTitle  = { fg = colors.gray1, bg = colors.purple },
        -- }}}

        -- {{{ results
        TelescopeResultsTitle  = { fg = colors.gray2, bg = colors.gray2  },
        -- }}}
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}
end
