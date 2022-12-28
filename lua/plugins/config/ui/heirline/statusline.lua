-- statusline made with heirline
return function(theme)
    -- {{{ imports
    local heirline = require('heirline')
    -- local utils    = require('heirline.utils')
    local conds    = require('heirline.conditions')

    heirline.load_colors(theme.colors)
    -- }}}

    --> utils

    local sp    = { provider = '%1( %)'   }
    local sep   = { provider = '%3( ~ %)' }
    local sepl  = { provider = '%2( ~%)'  }
    local sepr  = { provider = '%2(~ %)'  }
    local align = { provider = '%='       }

    local components = {}

    --> complex

    -- {{{ vi mode
    components.vimode = {
        -- {{{ make o-pending work
        init = function(self)
            self.mode = vim.fn.mode(1)

            -- execute this only once, this is required if you want the ViMode
            -- component to be updated on operator pending mode
            if not self.once then
                vim.api.nvim_create_autocmd('ModeChanged', {
                    pattern = '*:*o',
                    command = 'redrawstatus'
                })
                self.once = true
            end
        end,
        -- }}}

        static = {
            -- {{{ mode names
            mode_names = {
                n         = 'NOR',
                no        = 'OPR',
                nov       = 'OPR',
                noV       = 'OPR',
                ['no\22'] = 'OPR',
                niI       = 'NRI',
                niR       = 'NRR',
                niV       = 'NRV',
                nt        = 'NOR',
                v         = 'VIS',
                vs        = 'VIS',
                V         = 'V-L',
                Vs        = 'V-L',
                ['\22']   = 'V-B',
                ['\22s']  = 'V-B',
                s         = 'SEL',
                S         = 'S-L',
                ['\19']   = 'S-B',
                i         = 'INS',
                ic        = 'INS',
                ix        = 'INS',
                R         = 'RPL',
                Rc        = 'RPL',
                Rx        = 'RPL',
                Rv        = 'VRP',
                Rvc       = 'VRP',
                Rvx       = 'VRP',
                c         = 'CMD',
                cv        = 'EXM', -- Ex *M*ode
                r         = 'RET',
                rm        = 'MOR',
                ['r?']    = 'CF?',
                ['!']     = 'SHL',
                t         = 'TER',
            },
            -- }}}
        },

        provider = function(self)
            return '%5( ' .. self.mode_names[self.mode] .. ' %)'
        end,

        update = { 'ModeChanged' },
    }
    -- }}}

    -- {{{ file info
    -- {{{ flags
    components.file_flags = {
        {
            condition = function()
                return vim.bo.modified
            end,
            provider = '🞙',

            sp,
        },
        {
            condition = function()
                return not vim.bo.modifiable or vim.bo.readonly
            end,
            provider = '',

            sp,
        },
    }
    -- }}}

    -- {{{ size
    components.file_size = {
        provider = function(self)
            -- {{{ human-readable size
            -- stackoverflow moment
            local suffix = { 'b', 'k', 'm', 'g', 't', 'p', 'e' }
            local fsize = vim.fn.getfsize(self.name)
            fsize = (fsize < 0 and 0) or fsize
            if fsize < 1024 then
                return fsize..suffix[1]
            end
            local i = math.floor((math.log(fsize) / math.log(1024)))
            -- }}}

            return string.format('%.2f%s', fsize / math.pow(1024, i), suffix[i + 1])
        end
    }
    -- }}}

    -- {{{ type & icon
    components.ft = {
        condition = function(self)
            return self.type ~= ''
        end,

        init = function(self)
            self.type = vim.bo.filetype
        end,

        sep,

        -- {{{ type
        {
            provider = function(self)
                return string.lower(self.type)
            end,
        },
        -- }}}

        sp,

        -- {{{ icon
        {
            init = function(self)
                local filename = self.name
                local extension = vim.fn.fnamemodify(filename, ':e')
                self.icon = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
            end,

            provider = function(self)
                return self.icon
            end,
        },
        -- }}}
    }
    -- }}}

    -- {{{ format
    components.file_format = {
        condition = function()
            return vim.bo.fileformat ~= 'unix'
        end,

        sep,

        {
            provider = function()
                local fmt = vim.bo.fileformat
                return fmt == 'dos' and 'd'
            end
        },
    }
    -- }}}

    components.file_info = {
        condition = function()
            return vim.api.nvim_buf_get_name(0) ~= ''
        end,

        init = function(self)
            self.name = vim.api.nvim_buf_get_name(0)
        end,

        sp,
        components.file_flags,
        components.file_size,
        components.ft,
        components.file_format,
        sp
    }
    -- }}}

    -- {{{ git
    components.git = {
        condition = function(self)
            return self.git_cond() -- defined in `c` object
        end,

        init = function(self)
            ---@diagnostic disable-next-line: undefined-field
            self.status_dict = vim.b.gitsigns_status_dict

            if self.status_dict ~= nil then
                self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
            else
                self.has_changes = false
            end

            self.head = vim.fn.FugitiveHead()
        end,

        on_click = {
            callback = function()
                vim.cmd('Git')
            end,
            name = 'heirline_git',
        },

        sp,

        -- {{{ git branch
        {
            provider = function(self)
                return ' ' .. self.head
            end,
        },
        -- }}}

        -- {{{ diff counts
        {
            condition = function(self)
                return self.has_changes
            end,

            provider = function(self)
                local count = self.status_dict.added or 0
                return count > 0 and ('%2( +%)' .. count)
            end,

            hl = { fg = 'green' },
        },
        {
            condition = function(self)
                return self.has_changes
            end,

            provider = function(self)
                local count = self.status_dict.changed or 0
                return count > 0 and ('%2( ~%)' .. count)
            end,

            hl = { fg = 'blue' },
        },
        {
            condition = function(self)
                return self.has_changes
            end,

            provider = function(self)
                local count = self.status_dict.removed or 0
                return count > 0 and ('%2( -%)' .. count)
            end,

            hl = { fg = 'red' },
        },
        -- }}}
    }
    -- }}}

    -- {{{ diagnostics
    components.diag = {
        condition = conds.has_diagnostics,

        static = {
            error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
            warn_icon  = vim.fn.sign_getdefined('DiagnosticSignWarn' )[1].text,
            info_icon  = vim.fn.sign_getdefined('DiagnosticSignInfo' )[1].text,
            hint_icon  = vim.fn.sign_getdefined('DiagnosticSignHint' )[1].text,
        },

        init = function(self)
            self.errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN  })
            self.hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT  })
            self.info     = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO  })
        end,

        on_click = {
            callback = function()
                require('trouble').toggle({ mode = 'document_diagnostics' })
            end,
            name = 'heirline_diagnostics',
        },

        update = { 'DiagnosticChanged', 'BufEnter' },

        {
            provider = function(self)
                return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
            end,
            hl = { fg = 'red' },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
            end,
            hl = { fg = 'yellow' },
        },
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. ' ')
            end,
            hl = { fg = 'green' },
        },
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints)
            end,
            hl = { fg = 'teal' },
        },
    }
    -- }}}

    -- {{{ cwd
    components.cwd = {
        provider = function()
            local icon = (vim.fn.haslocaldir(0) == 1 and 'l' or '') .. ' ' .. ' '

            local cwd = vim.fn.getcwd(0)
            cwd = vim.fn.fnamemodify(cwd, ':~')
            cwd = vim.fn.pathshorten(cwd, 2)

            local trail = cwd:sub(-1) == '/' and '' or '/'
            return icon .. cwd  .. trail
        end,
    }
    -- }}}

    -- {{{ file encoding
    components.file_enc = {
        sp,

        {
            provider = function()
                return (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
            end,
        },

        sp,
    }
    -- }}}

    -- {{{ search count
    components.search = {
        condition = function()
            return vim.v.hlsearch ~= 0
        end,

        sepr,

        {
            provider = function()
                local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
                local denominator = math.min(result.total, result.maxcount)

                return string.format('%d/%d%s%%1( %%)', result.current, denominator, denominator == 999 and '+' or '')
            end,
        }
    }
    -- }}}

    --> simple

    -- {{{ ruler
    components.ruler = { provider = '%4( %l%):%-3(%c %)' }
    -- }}}

    -- {{{ hostname
    components.hostname = {
        provider = function()
            return vim.fn.hostname()
        end
    }
    -- }}}

    -- {{{ date & time
    components.date = {
        provider = function()
            return os.date('%d/%m:%u')
        end
    }

    components.time = {
        provider = function()
            return os.date('%H:%M')
        end
    }
    -- }}}

    --> statusline definitions

    -- {{{ standard statusline
    -- {{{ [abc] left
    local a = {
        hl = function(self)
            return { bg = self:mode_color(), fg = 'gray1', bold = true }
        end,

        components.vimode,
    }

    local b = {
        hl = { bg = 'gray3', fg = 'gray8' },

        components.file_info,
    }

    local c = {
        static = {
            git_cond = function()
                local ok, head = pcall(vim.fn.FugitiveHead)
                return ok and head ~= ''
            end,
        },

        hl = { bg = 'gray2', fg = 'gray7' },

        components.git,
        {
            provider = function(self)
                if self.git_cond() and conds.has_diagnostics() then return sep.provider else return sp.provider end
            end,
        },
        components.diag,
    }
    -- }}}

    -- {{{ [xyz] right
    local x = {
        hl = { bg = 'gray2', fg = 'gray7' },

        components.cwd,
        sp,
    }

    local y = {
        hl = { bg = 'gray3', fg = 'gray8' },

        components.file_enc,
        components.search,
    }

    local z = {
        hl = function(self)
            return { bg = self:mode_color(), fg = 'gray1', bold = true }
        end,

        components.ruler,
    }
    -- }}}

    local standard = {
        a,
        b,
        c,

        align,

        x,
        y,
        z,
    }
    -- }}}

    -- {{{ ft-specific statuslines
    -- TODO: port all my custom lualine extensions
    -- {{{ helper section makers
    local make_a = function(tbl, defined_color)
        local hl

        if defined_color then
            hl = function(self)
                return { bg = self.color, fg = 'gray1', bold = true }
            end
        else
            hl = function(self)
                return { bg = self:mode_color(), fg = 'gray1', bold = true }
            end
        end

        return {
            hl = hl,
            tbl,
        }
    end

    local make_z = function(tbl, defined_color)
        local hl

        if defined_color then
            hl = function(self)
                return { bg = self.color, fg = 'gray1', bold = true }
            end
        else
            hl = function(self)
                return { bg = self:mode_color(), fg = 'gray1', bold = true }
            end
        end

        return {
            hl = hl,
            tbl,
        }
    end
    -- }}}

    -- {{{ dashboard-only statusline
    -- {{{ [abc] left
    local dashboard_a = make_a({ provider = '%5( DSH %)' }, false)

    local dashboard_b = {
        hl = { bg = 'gray3', fg = 'gray8' },

        components.cwd,
        sp,
    }

    local dashboard_c = {
        static = {
            git_cond = function()
                local ok, head = pcall(vim.fn.FugitiveHead)
                return ok and head ~= ''
            end,
        },

        hl = { bg = 'gray2', fg = 'gray7' },

        components.git,
        {
            provider = function(self)
                if self.git_cond() and conds.has_diagnostics() then return sep.provider else return sp.provider end
            end,
        },
        components.diag,
    }
    -- }}}

    -- {{{ [xyz] right
    local dashboard_x = {
        hl = { bg = 'gray2', fg = 'gray7' },

        components.hostname,
        sp,
    }

    local dashboard_y = {
        hl = { bg = 'gray3', fg = 'gray8' },

        sp,
        components.date,
        sp,
    }

    local dashboard_z = make_z({ sp, components.time, sp }, false)
    -- }}}

    local dashboard = {
        condition = function()
            -- only in alpha.nvim
            return conds.buffer_matches({ filetype = { 'alpha' } })
        end,

        dashboard_a,
        dashboard_b,
        dashboard_c,

        align,

        dashboard_x,
        dashboard_y,
        dashboard_z,
    }
    -- }}}
    -- }}}

    --> finish

    -- {{{ setup
    heirline.setup({
        static = {
            -- {{{ mode colors
            mode_colors = {
                n       = 'green' ,
                i       = 'blue',
                v       = 'purple',
                V       = 'purple',
                ['\22'] = 'purple',
                c       = 'teal',
                s       = 'purple',
                S       = 'purple',
                ['\19'] = 'purple',
                R       = 'red',
                r       = 'red',
                ['!']   = 'teal',
                t       = 'teal',
            },

            mode_color = function(self)
                local mode = conds.is_active() and vim.fn.mode() or 'n'
                return self.mode_colors[mode]
            end,
            -- }}}
        },

        fallthrough = false,

        dashboard, standard
    })
    -- }}}
end
