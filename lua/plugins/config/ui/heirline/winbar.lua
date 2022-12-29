-- TODO: winbar made with heirline
return function(conds, utils, sp, sep, sepl, sepr, align)
    return {
        condition = function()
            return vim.bo.filetype ~= 'alpha'
        end,
    }
end
