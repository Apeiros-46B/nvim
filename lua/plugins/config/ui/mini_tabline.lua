-- configuration of tabline module for mini.nvim
-- {{{ imports
local tabline = require('mini.tabline')
-- }}}

-- {{{ setup
tabline.setup({
    -- Whether to show file icons (requires 'kyazdani42/nvim-web-devicons')
    show_icons = true,

    -- Whether to set Vim's settings for tabline (make it always shown and
    -- allow hidden buffers)
    set_vim_settings = true,

    -- Where to show tabpage section in case of multiple vim tabpages.
    -- One of 'left', 'right', 'none'.
    tabpage_section = 'left',
})
-- }}}

-- {{{ custom highlight
local theme = require('theme')
local colors = theme.colors

local set_hl = vim.api.nvim_set_hl

local hl = {
    MiniTablineTabpagesection             = { bg = colors.green, fg = colors.gray1, bold = true                },
    MiniTablineCurrent                    = { bg = colors.green, fg = colors.gray1, bold = true                },
    MiniTablineModifiedCurrent            = { bg = colors.green, fg = colors.gray1, bold = true, italic = true },
    MiniTablineVisible                    = { bg = colors.gray4, fg = colors.gray8, bold = true,               },
    MiniTablineModifiedVisible            = { bg = colors.gray4, fg = colors.gray8, bold = true, italic = true },
    MiniTablineHidden                     = { bg = colors.gray4, fg = colors.gray8,                            },
    MiniTablineModifiedHidden             = { bg = colors.gray4, fg = colors.gray8,              italic = true },
    MiniTablineFill                       = { bg = colors.gray3,                                               },
}

for k, v in pairs(hl) do set_hl(0, k, v) end
-- }}}
