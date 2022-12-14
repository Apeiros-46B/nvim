-- configuration for telescope fuzzy finder
-- {{{ imports
-- main
local telescope = require('telescope')

-- theme
local theme = require('core.theme')
local colors = theme.colors
-- }}}

-- {{{ setup
telescope.setup({
	defaults = {
        -- Prefixes
        prompt_prefix = '   ',
		selection_caret = '  ',
		entry_prefix = '   ',

        -- Border
		borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },

        -- Ascending sort
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
                ["<C-o>"] = function(prompt_bufnr) require("telescope.actions").select_default(prompt_bufnr) require("telescope.builtin").resume() end,
            },
        },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = false,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
	},
})

-- ignore files that are larger than a certain size
local previewers = require('telescope.previewers')
local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}

	filepath = vim.fn.expand(filepath)
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

telescope.load_extension('fzf')
-- }}}

-- {{{ custom highlights
local set_hl = vim.api.nvim_set_hl

local hl = {
    -- {{{ general
    TelescopeNormal    = { bg = colors.gray2                         },
    TelescopeSelection = { bg = colors.visual_bg, bold = true        },

    TelescopeMatching  = { fg = colors.purple,    bold = true        },
    TelescopeBorder    = { fg = colors.gray2,     bg = colors.gray2  },
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
