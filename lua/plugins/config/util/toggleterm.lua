-- configuration for toggleterm.nvim plugin
return function(theme)
    local colors = theme.colors

    require('toggleterm').setup({
        direction = 'float',
        on_open = function(t)
            -- for some reason, from second open and onwards, it does not open in term mode
            -- this fixes that
            vim.defer_fn(function ()
                if t.__state.mode == 'n' then
                    vim.cmd('startinsert')
                end
            end, 10)
        end,
        highlights = {
            NormalFloat = {
                guibg = colors.gray2,
            },
            FloatBorder = {
                link = 'NormalFloat',
            }
        },
        shade_terminals = false,
        float_opts = {
            border = 'solid',
            winblend = 0,
        },
    })
end
