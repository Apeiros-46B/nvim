-- configuration for alpha.nvim greeter
return function(theme)
    -- {{{ imports
    local colors = theme.colors
    local alpha  = require('alpha')
    -- }}}

    -- {{{ button helper function
    local function button(bind, txt, keybind)
        local new_bind = bind:gsub('%s', ''):gsub('SPC', '<leader>')

        local opts = {
            position = 'center',
            text = txt,
            shortcut = bind,
            cursor = 0,
            width = 24,
            align_shortcut = 'right',
            hl_shortcut = 'AlphaButtons',
            hl = 'AlphaItem',
        }

        if keybind then
            opts.keymap = { 'n', new_bind, keybind, { noremap = true, silent = true } }
        end

        return {
            type = 'button',
            val = txt,
            on_press = function()
                local key = vim.api.nvim_replace_termcodes(new_bind, true, false, true) or ''
                vim.api.nvim_feedkeys(key, 'normal', false)
            end,
            opts = opts,
        }
    end
    -- }}}

    -- {{{ setup
    -- header padding
    local marginTopPercent = 0.3
    local headerPadding = math.max(2, math.floor(vim.fn.winheight(0) * marginTopPercent))

    local options = {
        -- {{{ header
        header = {
            type = 'text',
            val = {
                '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
                '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
                '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
                '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
                '          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
                '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
                '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
                ' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
                ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
                '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
                '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
            },
            opts = {
                position = 'center',
                hl = 'AlphaHeader',
            },
        },

        headerPaddingTop = { type = 'padding', val = headerPadding },
        headerPaddingBottom = { type = 'padding', val = 3 },
        -- }}}

        -- {{{ buttons
        buttons = {
            type = 'group',
            val = {
                button(' SPC f f ', 'find file  ', ':Telescope find_files<CR>'),
                button(' SPC f r ', 'find recent', ':Telescope oldfiles<CR>'),
                button(' SPC f w ', 'find word  ', ':Telescope live_grep<CR>'),
            },
            opts = {
                spacing = 1,
            },
        },
        -- }}}
    }

    alpha.setup({
        layout = {
            options.headerPaddingTop,
            options.header,
            options.headerPaddingBottom,
            options.buttons,
        },
        opts = {},
    })
    -- }}}

    -- {{{ custom highlights
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        AlphaHeader  = { bg = colors.gray1, fg = colors.gray7 },
        AlphaItem    = { bg = colors.gray1, fg = colors.green },
        AlphaButtons = { bg = colors.gray2, fg = colors.gray7 },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
    -- }}}
end
