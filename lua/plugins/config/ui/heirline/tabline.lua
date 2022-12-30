-- TODO: buftabline made with heirline
return function(conds, utils, sp, sep, sepl, sepr, align)
    align = vim.fn.copy(align)
    align.hl = { bg = 'gray3' }
    local components = { buflist = {}, tablist = {} }

    -- {{{ buflist
    -- {{{ icon
    components.buflist.icon = {
        condition = function(self)
            return not self._show_picker
        end,

        init = function(self)
            if self.is_term then
                self.icon = 'ﲵ'
            else
                local extension = vim.fn.fnamemodify(self.filename, ':e')
                self.icon = require('nvim-web-devicons').get_icon(self.filename, extension, { default = true })
            end
        end,

        provider = function(self)
            return self.icon
        end,

        sp,
    }
    -- }}}

    -- {{{ name
    components.buflist.name = {
        provider = function(self)
            local filename = self.filename
            filename = filename == '' and '[unnamed]' or vim.fn.fnamemodify(filename, ':t')
            return filename
        end,
    }
    -- }}}

    -- {{{ flags
    components.buflist.flags = {
        -- {{{ modified
        {
            condition = function(self)
                return vim.api.nvim_buf_get_option(self.bufnr, 'modified')
            end,

            provider = '+',

            hl = { bold = true },

            sp,
        },
        -- }}}

        -- {{{ read-only
        {
            condition = function(self)
                local mod  = vim.api.nvim_buf_get_option(self.bufnr, 'modifiable')
                local ro   = vim.api.nvim_buf_get_option(self.bufnr, 'readonly')

                return not self.is_term and (not mod or ro)
            end,

            provider = '',

            sp,
        },
        -- }}}
    }
    -- }}}

    -- {{{ picker
    components.buflist.picker = {
        condition = function(self)
            return self._show_picker
        end,

        init = function(self)
            local bufname = vim.api.nvim_buf_get_name(self.bufnr)
            bufname = vim.fn.fnamemodify(bufname, ':t')
            local label = bufname:sub(1, 1)
            local i = 2
            while self._picker_labels[label] do
                if i > #bufname then
                    break
                end
                label = bufname:sub(i, i)
                i = i + 1
            end
            self._picker_labels[label] = self.bufnr
            self.label = label
        end,

        provider = function(self)
            return self.label
        end,

        hl = function(self)
            if self.is_active then
                return { bg = 'green', fg = 'gray1', bold = true, italic = true }
            else
                return { bg = 'gray4', fg = 'green', bold = true, italic = true}
            end
        end,

        sp,
    }

    vim.keymap.set('n', '<leader>bp', function()
        local tabline = require('heirline').tabline
        local buflist = tabline._buflist[1]
        buflist._picker_labels = {}
        buflist._show_picker = true
        vim.cmd.redrawtabline()
        local char = vim.fn.getcharstr()
        if char == '\27' then
            buflist._show_picker = false
            vim.cmd.redrawtabline()
            return
        end
        local bufnr = buflist._picker_labels[char]
        if bufnr then
            vim.api.nvim_win_set_buf(0, bufnr)
        end
        buflist._show_picker = false
        vim.cmd.redrawtabline()
    end)
    -- }}}

    components.buflist.buffer = {
        init = function(self)
            local name = vim.api.nvim_buf_get_name(self.bufnr)

            -- fix illegal characters in jdtls buffers
            if string.find(name, '^jdt://') then
                self.filename = string.match(name, '%%3C(.+).class$'):gsub('%(', '.')
            else
                self.filename = name
            end
            self.is_term  = vim.api.nvim_buf_get_option(self.bufnr, 'buftype') == 'terminal'
        end,

        -- {{{ highlight
        hl = function(self)
            if self.is_active and self.is_visible then
                return { bg = 'green', fg = 'gray1', bold = true  }
            elseif self.is_visible then
                return { bg = 'gray4', fg = 'gray8', bold = true  }
            else
                return { bg = 'gray4', fg = 'gray8', bold = false }
            end
        end,
        -- }}}

        -- {{{ switch/close on click
        on_click = {
            callback = function(_, minwid, _, button)
                if (button == 'm') then
                    vim.api.nvim_buf_delete(minwid, { force = false })
                else
                    vim.api.nvim_win_set_buf(0, minwid)
                end
                -- force redraw
                vim.cmd.redrawtabline()
            end,

            minwid = function(self)
                return self.bufnr
            end,

            name = 'heirline_tabline_buffer_callback',
        },
        -- }}}

        sp,
        components.buflist.icon,
        components.buflist.picker,
        components.buflist.name,
        sp,
        components.buflist.flags,
    }
    -- }}}

    --> return finished buftabline
    vim.o.showtabline = 2
    vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

    return {
        utils.make_buflist(components.buflist.buffer),
        align,
    }
end
