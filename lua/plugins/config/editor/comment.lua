-- configuration for nvim-comment plugin
-- {{{ setup
require('nvim_comment').setup({
    marker_padding = true,
    comment_empty = false,
    create_mappings = false,
    hook = nil,
})
-- }}}

-- {{{ override comment command in norg files
local api = vim.api
local exec = api.nvim_exec
local au = api.nvim_create_autocmd
local cc = api.nvim_create_user_command

local function create()
    cc('CommentToggle', function(tbl)
        -- {{{ +one-line comment+
        if tbl.range == 0 then
            -- one-line comment +like this+

            -- {{{ check if commented
            local current_line = api.nvim_get_current_line()
            local comment_expr = vim.regex([[^\s*+.*+\s*$]])

            if comment_expr:match_str(current_line) then
            -- }}}
            -- {{{ comment or uncomment
                -- there is already a comment, so uncomment the line
                exec([[exec 's/\(^\s*\)+\(.*\)+\(\s*$\)/\1\2\3' | noh]], false)
            else
                -- there isn't a comment, so comment the line
                exec([[exec 's/\(^\s*\)\(.*\)\(\s*$\)/\1+\2+\3' | noh]], false)
            end
            -- }}}
        -- }}}
        -- {{{ @comment multiline comment @end
        elseif tbl.range == 2 then
            -- multiline comment
            -- @comment
            -- like this
            -- @end

            -- {{{ check if commented
            local commented0 = false
            local commented1 = false

            local comment_expr = vim.regex([[^\s*@comment\s*$]])
            local end_expr     = vim.regex([[^\s*@end\s*$]]    )

            exec(tostring(tbl.line2),     false); commented0 = (end_expr    :match_str(api.nvim_get_current_line()) and                 true )
            exec(tostring(tbl.line1),     false); commented0 = (comment_expr:match_str(api.nvim_get_current_line()) and (commented0 and true))
            exec(tostring(tbl.line2 + 1), false); commented1 = (end_expr    :match_str(api.nvim_get_current_line()) and                 true )
            exec(tostring(tbl.line1 - 1), false); commented1 = (comment_expr:match_str(api.nvim_get_current_line()) and (commented1 and true))
            -- }}}
            -- {{{ comment or uncomment
            if commented0 then -- uncomment
                -- last
                exec(tostring(tbl.line2), false)
                api.nvim_set_current_line(''); exec([[exec "normal i\<BS>\<Esc>"]], false)

                -- first
                exec(tostring(tbl.line1), false)
                api.nvim_set_current_line(''); exec([[exec "normal i\<BS>\<Esc>"]], false)
            elseif commented1 then -- uncomment
                -- last
                exec(tostring(tbl.line2 + 1), false)
                api.nvim_set_current_line(''); exec([[exec "normal i\<BS>\<Esc>"]], false)

                -- first
                exec(tostring(tbl.line1 - 1), false)
                api.nvim_set_current_line(''); exec([[exec "normal i\<BS>\<Esc>"]], false)
            else -- comment
                -- last
                exec(tostring(tbl.line2),       false)
                exec([[exec "normal o\<Esc>"]], false)

                api.nvim_set_current_line('@end')

                -- first
                exec(tostring(tbl.line1),       false)
                exec([[exec "normal O\<Esc>"]], false)

                api.nvim_set_current_line('@comment')
            end
            -- }}}
        end
        -- }}}
    end, { range = true, nargs = 0 })
end

au({ 'Filetype' }, { pattern = 'norg', callback = create })

if vim.bo.filetype == 'norg' then create() end
-- }}}
