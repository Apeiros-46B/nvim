---@diagnostic disable: param-type-mismatch
-- load plugins

local theme

-- {{{ helpers
-- {{{ create keymaps
-- create a full mapping
local function key(lhs, rhs, mode, additional_opts)
    local opts = { lhs, rhs, mode = mode, desc = nil, noremap = true, silent = true }

    if additional_opts then
        opts = vim.tbl_extend('force', opts, additional_opts)
    end

    return opts
end

-- create a simple mapping, for lazy-loading only (won't actually be applied)
local function lkey(mode, lhs)
    return { lhs, mode = mode }
end
-- }}}

-- {{{ call a config
local function cfg(module)
    return function()
        local ret = require('plugins.config.' .. module)

        if type(ret) == 'function' then
            ret(theme)
        end
    end
end
-- }}}

-- {{{ NvChad's lazy loading helpers (slightly modified for lazy.nvim)
-- {{{ main loader function
local function loader(tbl)
    vim.api.nvim_create_autocmd(tbl.events, {
        group = vim.api.nvim_create_augroup(tbl.augroup_name, {}),
        callback = function()
            if tbl.condition() then
                vim.api.nvim_del_augroup_by_name(tbl.augroup_name)

                -- don't defer for treesitter because it will show slow highlighting
                if tbl.plugin ~= 'nvim-treesitter' then
                    vim.defer_fn(function()
                        require('lazy.core.loader').load(tbl.plugin, { event = tbl.reason })
                        if tbl.plugin == 'nvim-lspconfig' then
                            vim.cmd([[silent! do FileType]])
                        end
                    end, 0)
                else
                    require('lazy.core.loader').load(tbl.plugin, { event = tbl.reason })
                end
            end
        end,
    })
end
-- }}}

-- {{{ load plugins only if there's a file opened in the buffer
local function fileloader(plugin)
    return function()
        loader({
            events = { 'BufEnter', 'BufWinEnter', 'BufNewFile', 'BufRead' },
            augroup_name = 'FileOpenLazy' .. plugin,
            plugin = plugin,
            condition = function()
                local file = vim.api.nvim_buf_get_name(0)
                return file ~= 'NvimTree_1' and file ~= ''
            end,
            reason = 'BufEnter'
        })
    end
end
-- }}}

-- {{{ load files only if cwd is in a git repo
local function gitloader(plugin)
    return function()
        vim.api.nvim_create_autocmd({ 'VimEnter' }, {
            group = vim.api.nvim_create_augroup('GitBufEnterLazy' .. plugin, { clear = true }),
            callback = function()
                vim.fn.system('git -C ' .. vim.fn.getcwd(0) .. ' rev-parse')
                if vim.v.shell_error == 0 then
                    vim.api.nvim_del_augroup_by_name('GitBufEnterLazy' .. plugin)
                    vim.schedule(function()
                        require('lazy.core.loader').load(plugin, { event = 'GitBufEnter' })
                    end)
                end
            end,
        })
    end
end
-- }}}
-- }}}
-- }}}

-- {{{ custom highlights
local function highlights()
    local colors = theme.colors
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        -- {{{ main ui elements
        LazyH1            = { bg = colors.teal,  fg = colors.gray1, bold = true },
        LazyH2            = {                    fg = colors.white, bold = true },

        LazyNormal        = { bg = colors.gray2, fg = colors.white              },
        LazyButton        = { bg = colors.gray3, fg = colors.white              },
        LazyButtonActive  = { bg = colors.teal,  fg = colors.gray1, bold = true },

        LazySpecial       = { fg = colors.teal, bold = true },
        -- }}}

        -- {{{ commit
        LazyCommit        = { fg = colors.purple                },
        LazyCommitIssue   = { fg = colors.blue,   italic = true },
        LazyCommitScope   = { fg = colors.white,  bold   = true },
        LazyCommitType    = { fg = colors.red,    bold   = true },
        -- }}}

        -- {{{ properties
        LazyProp          = { fg = colors.gray7,  italic    = true },
        LazyValue         = { fg = colors.green                    },

        LazyComment       = { fg = colors.gray7,  italic    = true },
        LazyDir           = { fg = colors.blue,   bold      = true },
        LazyUrl           = { fg = colors.teal,   underline = true },
        -- }}}

        -- {{{ reasons/handlers
        LazyReasonCmd     = { fg = colors.teal   },
        LazyReasonEvent   = { fg = colors.purple },
        LazyReasonFt      = { fg = colors.green  },
        LazyReasonKeys    = { fg = colors.red    },
        LazyReasonPlugin  = { fg = colors.yellow },
        LazyReasonRuntime = { fg = colors.orange },
        LazyReasonSource  = { fg = colors.teal   },
        LazyReasonStart   = { fg = colors.blue   },
        -- }}}

        -- {{{ misc
        LazyNoCond        = { fg = colors.yellow },
        LazyTaskError     = { fg = colors.red    },
        LazyTaskOutput    = { fg = colors.gray7  },
        LazyProgressDone  = { fg = colors.teal   },
        LazyProgressTodo  = { fg = colors.gray7  },
        -- }}}
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
end
-- }}}

-- {{{ plugin specs
local specs =  {
    -- {{{ base
    {
        'sainnhe/everforest',
        -- old palette >> new
        commit = 'd855af5',
        pin = true,
        lazy = false,
        priority = 1000,
        config = function()
            theme = require('plugins.theme')
            highlights()
        end,
    },
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    -- }}}

    -- {{{ [completion] plugins related to completion
    -- {{{ cmp
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- lsp, dictionary aren't needed for core cmp to function; they can load later
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'quangnguyen30192/cmp-nvim-ultisnips',
        },
        event = 'InsertEnter',
        config = cfg('completion.cmp'),
    },
    -- }}}

    -- {{{ cmp sources loaded later
    {
        'hrsh7th/cmp-nvim-lsp',
        event = 'LspAttach',
    },
    -- }}}

    -- {{{ ultisnips
    {
        'SirVer/ultisnips',
        ft = 'snippets',
        event = 'InsertEnter',
        config = cfg('completion.ultisnips'),
    },
    -- }}}
    -- }}}

    -- {{{ [editor] plugins related to core editor functionality
    -- {{{ essential editing features
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = cfg('editor.autopairs'),
    },
    {
        'windwp/nvim-ts-autotag',
        event = 'InsertEnter',
        opts = {},
    },
    {
        'terrortylor/nvim-comment',
        keys = {
            key('<C-c>', '<cmd>CommentToggle<CR>', 'n'),
            key('<C-c>', ':CommentToggle<CR>'    , 'v'),
        },
        cmd = 'CommentToggle',
        config = cfg('editor.comment'),
    },
    {
        'kylechui/nvim-surround',
        keys = {
            -- {{{ surround keys
            -- actual bindings are set in the config file
            lkey('i', '<C-g>s'), -- insert
            lkey('i', '<C-g>S'), -- insert line
            lkey('n', 'ys'    ), -- normal
            lkey('n', 'yS'    ), -- normal line
            lkey('v', 'S'     ), -- visual
            lkey('v', 'gS'    ), -- visual line
            lkey('n', 'ds'    ), -- delete
            lkey('n', 'cs'    ), -- change
            -- }}}
        },
        config = cfg('editor.surround'),
    },
    -- }}}

    -- {{{ navigation
    {
        'phaazon/hop.nvim',
        cmd = {
            -- {{{ hop commands
            'HopAnywhere',
            'HopAnywhereAC',
            'HopAnywhereBC',
            'HopAnywhereCurrentLine',
            'HopAnywhereCurrentLineAC',
            'HopAnywhereCurrentLineBC',
            'HopAnywhereMW',
            'HopChar1',
            'HopChar1AC',
            'HopChar1BC',
            'HopChar1CurrentLine',
            'HopChar1CurrentLineAC',
            'HopChar1CurrentLineBC',
            'HopChar1MW',
            'HopChar2',
            'HopChar2AC',
            'HopChar2BC',
            'HopChar2CurrentLine',
            'HopChar2CurrentLineAC',
            'HopChar2CurrentLineBC',
            'HopChar2MW',
            'HopLine',
            'HopLineAC',
            'HopLineBC',
            'HopLineMW',
            'HopLineStart',
            'HopLineStartAC',
            'HopLineStartBC',
            'HopLineStartMW',
            'HopPattern',
            'HopPatternAC',
            'HopPatternBC',
            'HopPatternCurrentLine',
            'HopPatternCurrentLineAC',
            'HopPatternCurrentLineBC',
            'HopPatternMW',
            'HopVertical',
            'HopVerticalAC',
            'HopVerticalBC',
            'HopVerticalMW',
            'HopWord',
            'HopWordAC',
            'HopWordBC',
            'HopWordCurrentLine',
            'HopWordCurrentLineAC',
            'HopWordCurrentLineBC',
            'HopWordMW',
            -- }}}
        },
        keys = {
            -- {{{ hop keys
            key('<leader>hh', ':HopWord<CR>'           , 'n', { silent = false }),
            key('<leader>hj', ':HopWordAC<CR>'         , 'n', { silent = false }),
            key('<leader>hk', ':HopWordBC<CR>'         , 'n', { silent = false }),
            key('<leader>hl', ':HopWordMW<CR>'         , 'n', { silent = false }),
            key('<leader>hc', ':HopChar1<CR>'          , 'n', { silent = false }),
            key('<leader>hC', ':HopChar2<CR>'          , 'n', { silent = false }),
            key('<leader>hg', ':HopPattern<CR>'        , 'n', { silent = false }),
            key('<leader>hn', ':HopLineStart<CR>'      , 'n', { silent = false }),
            key('<leader>hf', ':HopWordCurrentLine<CR>', 'n', { silent = false }),
            key('\\',         ':HopChar2<CR>'          , 'n', { silent = false }),
            key('|',          ':HopChar1<CR>'          , 'n', { silent = false }),
            key('\\',         ':HopChar2<CR>'          , 'o', { silent = false }),
            key('|',          ':HopChar1<CR>'          , 'o', { silent = false }),
            -- }}}
        },
        config = cfg('editor.hop'),
    },
    -- }}}

    -- {{{ other editing-related embellishments
    {
        'cshuaimin/ssr.nvim',
        keys = {
            key('<leader>FS', '<cmd>lua require("ssr").open()<CR>', 'n'),
        },
        config = cfg('editor.ssr'),
    },
    {
        'monaqa/dial.nvim',
        keys = {
            -- actual bindings are set in the config file
            lkey({ 'n', 'v' }, '<C-a>'),
            lkey({ 'n', 'v' }, '<C-x>'),
            lkey('v', 'g<C-a>'),
            lkey('v', 'g<C-x>'),
        },
        config = cfg('editor.dial'),
    },
    -- }}}
    -- }}}

    -- {{{ [git] plugins related to git
    -- {{{ gitsigns
    {
        'lewis6991/gitsigns.nvim',
        init = gitloader('gitsigns.nvim'),
        keys = {
            key(']c', '<cmd>lua require"gitsigns.actions".next_hunk()<CR>', 'n'),
            key('[c', '<cmd>lua require"gitsigns.actions".prev_hunk()<CR>', 'n'),

            key('<leader>gs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', 'n'),
            key('<leader>gs', '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'v'),
            key('<leader>gu', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', 'n'),
            key('<leader>gr', '<cmd>lua require"gitsigns".reset_hunk()<CR>', 'n'),
            key('<leader>gr', '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'v'),
            key('<leader>gR', '<cmd>lua require"gitsigns".reset_buffer()<CR>', 'n'),
            key('<leader>gp', '<cmd>lua require"gitsigns".preview_hunk()<CR>', 'n'),
            key('<leader>gb', '<cmd>Gitsigns blame_line<CR>', 'n'),
            key('<leader>gS', '<cmd>lua require"gitsigns".stage_buffer()<CR>', 'n'),
            key('<leader>gU', '<cmd>lua require"gitsigns".reset_buffer_index()<CR>', 'n'),

            key('ih', ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>', 'o'),
            key('ih', ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>', 'x'),
        },
        config = cfg('git.gitsigns'),
    },
    -- }}}

    -- {{{ fugitive
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        init = gitloader('vim-fugitive'),
        keys = {
            key('<leader>gg', '<cmd>Git<CR>'       , 'n'),
            key('<leader>ga', '<cmd>Git add .<CR>' , 'n'),
            key('<leader>gB', '<cmd>Git blame<CR>' , 'n'),
            key('<leader>gc', '<cmd>Git commit<CR>', 'n'),
        },
    },
    -- }}}
    -- }}}

    -- {{{ [lsp] plugins related to lsp, dap, or linters
    -- {{{ base
    -- mason
    {
        'williamboman/mason.nvim',
        dependencies = {
            -- lspconfig
            {
                'williamboman/mason-lspconfig.nvim',
                dependencies = {
                    {
                        'neovim/nvim-lspconfig',
                        dependencies = {
                            'folke/neodev.nvim', -- configured in mason config file to ensure load order (must be setup before lspconfig)
                        },
                    },
                },
            },
            -- null-ls
            {
                'jay-babu/mason-null-ls.nvim',
                dependencies = { 'jose-elias-alvarez/null-ls.nvim' },
            },
        },
        cmd = 'Mason',
        init = function()
            fileloader('mason.nvim')()

            -- start lsp on InsertEnter
            -- hacky fix for lsp not starting
            local lsp_ins_start
            lsp_ins_start = vim.api.nvim_create_autocmd('InsertEnter', {
                pattern = '*',
                callback = function()
                    -- this breaks syntax highlighting in specifically lua
                    -- luals also starts fine without this
                    if vim.bo.filetype ~= 'lua' then
                        -- HACK: start LSP on InsertEnter
                        vim.cmd('do FileType')
                    end

                    if vim.bo.filetype ~= 'TelescopePrompt' then
                        -- remove after first run
                        vim.api.nvim_del_autocmd(lsp_ins_start)
                    end
                end,
            })
        end,
        config = cfg('lsp.mason'),
    },

    -- dap
    {
        'mfussenegger/nvim-dap',
        init = fileloader('nvim-dap'),
    },
    -- }}}

    -- {{{ language support
    -- rust
    {
        'mrcjkb/rustaceanvim',
        lazy = false,
        keys = {
            -- {{{ rust keys
            key('<leader>ra',  '<cmd>RustLsp codeAction<CR>',   'n'),
            key('<leader>rc',  '<cmd>RustLsp openCargo<CR>',    'n'),
            key('<leader>rd',  '<cmd>RustLsp debuggables<CR>',  'n'),
            key('<leader>re',  '<cmd>RustLsp expand<CR>',       'n'),
            key('<leader>rE',  '<cmd>RustLsp expandMacro<CR>',  'n'),
            key('<leader>rj',  '<cmd>RustLsp moveItemDown<CR>', 'n'),
            key('<leader>rJ',  '<cmd>RustLsp joinLines<CR>',    'n'),
            key('<leader>rk',  '<cmd>RustLsp moveItemUp<CR>',   'n'),
            key('<leader>rp',  '<cmd>RustLsp parentModule<CR>', 'n'),
            key('<leader>rt',  '<cmd>RustLsp test<CR>',         'n'),
            key('<leader>rT',  '<cmd>RustLsp test!<CR>',        'n'),
            key('<leader>rf',  '<cmd>RustFmt<CR>',              'n'),
            -- }}}
        },
        init = cfg('lsp.rustacean'),
    },

    -- java
    -- configured in lsp.lspconfig
    {
        'mfussenegger/nvim-jdtls',
        keys = {
            -- {{{ jdtls keys
            key('<leader>Jm',  '<cmd>ToggleTerm<CR>mvn<CR>'                          , 'n'),
            key('<leader>Jo',  '<cmd>lua require("jdtls").organize_imports()<CR>'    , 'n'),
            key('<leader>Jev', '<cmd>lua require("jdtls").extract_variable()<CR>'    , 'n'),
            key('<leader>Jev', '<cmd>lua require("jdtls").extract_variable(true)<CR>', 'v'),
            key('<leader>Jec', '<cmd>lua require("jdtls").extract_constant()<CR>'    , 'n'),
            key('<leader>Jec', '<cmd>lua require("jdtls").extract_constant(true)<CR>', 'v'),
            key('<leader>Jem', '<cmd>lua require("jdtls").extract_method(true)<CR>'  , 'v'),
            -- }}}
        },
    },
    -- }}}

    -- {{{ other lsp-related plugins
    {
        'onsails/lspkind-nvim',
        event = 'LspAttach',
        config = cfg('lsp.lspkind'),
    },
    {
        'glepnir/lspsaga.nvim',
        enabled = false,
        event = 'LspAttach',
        cmd = 'Lspsaga',
        keys = {
            -- {{{ lspsaga keys
            -- key('<leader>lf', '<cmd>Lspsaga lsp_finder<CR>'            , 'n'),
            -- key('<leader>lp', '<cmd>Lspsaga hover_doc<CR>'             , 'n'),
            -- key('<leader>ld', '<cmd>Lspsaga peek_definition<CR>'       , 'n'),
            -- key('<M-CR>'    , '<cmd>lua vim.lsp.buf.code_action()<CR>' , 'n'),
            -- key('<M-d>'     , '<cmd>Lspsaga term_toggle<CR>'           , 'n'),
            -- key('<M-d>'     , '<C-\\><C-n><cmd>Lspsaga term_toggle<CR>', 't'),
            -- }}}
        },
        config = cfg('lsp.lspsaga'),
    },
    {
        'smjonas/inc-rename.nvim',
        event = 'LspAttach',
        cmd = 'IncRename',
        keys = {
            key('<leader>lr', ':IncRename ', 'n'),
        },
        opts = {},
    },
    {
        'folke/trouble.nvim',
        event = 'LspAttach',
        cmd = {
            'Trouble',
            'TroubleClose',
            'TroubleRefresh',
            'TroubleToggle',
        },
        keys = {
            key('<leader>lt', '<cmd>TroubleToggle<CR>', 'n'),
        },
        config = cfg('lsp.trouble'),
    },
    {
        'SmiteshP/nvim-navic',
        cmd = {
            'NavicToggle',
        },
        keys = {
            key('<leader>Tn', '<cmd>NavicToggle<CR>', 'n'),
        },
        config = cfg('lsp.navic'),
    },
    {
        'SmiteshP/nvim-navbuddy',
        cmd = {
            'Navbuddy',
        },
        keys = {
            key('<leader>ln', '<cmd>Navbuddy<CR>', 'n'),
        },
        config = cfg('lsp.navbuddy'),
    },
    {
        url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        branch = 'main',
        event = 'LspAttach',
        keys = {
            key(
                '<leader>ll',
                function()
                    -- needed to wrap it in a function so nvim doesn't immediately
                    -- call `require` (thus loading it) upon sourcing this file
                    require('lsp_lines').toggle()
                end,
                'n'
            ),
        },
        config = cfg('lsp.lines'),
    },
    -- }}}
    -- }}}

    -- {{{ [syntax] mostly treesitter and syntax support/highlighting-related plugins
    -- {{{ treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        init = fileloader('nvim-treesitter'),
        config = cfg('syntax.treesitter'),
        dependencies = {
            'RRethy/nvim-treesitter-endwise'
        }
    },
    -- }}}

    -- {{{ other
    {
        'RRethy/vim-illuminate',
        init = fileloader('vim-illuminate'),
        config = cfg('syntax.illuminate'),
    },
    {
        'folke/todo-comments.nvim',
        init = fileloader('todo-comments.nvim'),
        config = cfg('syntax.todo_comments'),
    },
    {
        'norcalli/nvim-colorizer.lua',
        init = fileloader('nvim-colorizer.lua'),
        opts = {},
        keys = {
            key('<leader>Tc', '<cmd>ColorizerToggle<CR>', 'n'),
        },
    },
    -- }}}
    -- }}}

    -- {{{ [ui] plugins that enhance the user interface
    -- {{{ utils
    {
        'kyazdani42/nvim-web-devicons',
        config = cfg('ui.devicons'),
    },
    -- }}}

    -- {{{ statusline, tabline, and winbar
    {
        'rebelot/heirline.nvim',
        lazy = false,
        config = cfg('ui.heirline')
    },
    -- }}}

    -- {{{ greeter
    {
        'goolord/alpha-nvim',
        lazy = false,
        config = cfg('ui.alpha')
    },
    -- }}}

    -- {{{ scrollbar
    {
        'Apeiros-46B/nvim-scrlbkun',
        init = fileloader('nvim-scrlbkun'),
        config = cfg('ui.scrlbkun'),
    },
    -- }}}

    -- {{{ keybind help
    {
        'folke/which-key.nvim',
        lazy = false,
        config = cfg('ui.which_key'),
    },
    -- }}}

    -- {{{ others
    {
        'folke/noice.nvim',
        -- enabled = false,
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        event = 'VeryLazy',
        config = cfg('ui.noice')
    },

    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
    },

    {
        'nvim-telescope/telescope-ui-select.nvim',
        event = 'VeryLazy',
        config = cfg('ui.telescope_ui_select'),
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        init = fileloader('indent-blankline.nvim'),
        config = cfg('ui.indent')
    },
    -- }}}
    -- }}}

    -- {{{ [util] other utilities
    -- {{{ telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            -- fzf native
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        cmd = 'Telescope',
        keys = {
            key('<leader>fb', '<cmd>Telescope buffers<CR>'       , 'n'),
            key('<leader>fd', '<cmd>Telescope diagnostics<CR>'   , 'n'),
            key('<leader>ff', '<cmd>Telescope find_files<CR>'    , 'n'),
            key('<leader>fg', '<cmd>Telescope git_files<CR>'     , 'n'),
            key('<leader>fh', '<cmd>Telescope help_tags<CR>'     , 'n'),
            key('<leader>fj', '<cmd>Telescope jumplist<CR>'      , 'n'),
            key('<leader>fl', '<cmd>Telescope reloader<CR>'      , 'n'),
            key('<leader>fo', '<cmd>Telescope vim_options<CR>'   , 'n'),
            key('<leader>fp', '<cmd>Telescope builtin<CR>'       , 'n'),
            key('<leader>fr', '<cmd>Telescope oldfiles<CR>'      , 'n'),
            key('<leader>fR', '<cmd>Telescope resume<CR>'        , 'n'),
            key('<leader>fw', '<cmd>Telescope live_grep<CR>'     , 'n'),
            key("<leader>f'", '<cmd>Telescope marks<CR>'         , 'n'),
            key('<leader>f"', '<cmd>Telescope registers<CR>'     , 'n'),
            key('<leader>f/', '<cmd>Telescope search_history<CR>', 'n'),

            key('<leader>gfc', '<cmd>Telescope git_commits<CR>' , 'n'),
            key('<leader>gfb', '<cmd>Telescope git_branches<CR>', 'n'),

            key('<leader>lfd',     '<cmd>Telescope lsp_definitions<CR>'              , 'n'),
            key('<leader>lft',     '<cmd>Telescope lsp_type_definitions<CR>'         , 'n'),
            key('<leader>lfr',     '<cmd>Telescope lsp_references<CR>'               , 'n'),
            key('<leader>lfi',     '<cmd>Telescope lsp_implementations<CR>'          , 'n'),
            key('<leader>lfc',     '<cmd>Telescope lsp_incoming_calls<CR>'           , 'n'),
            key('<leader>lfC',     '<cmd>Telescope lsp_outgoing_calls<CR>'           , 'n'),
            key('<leader>lfs',     '<cmd>Telescope lsp_document_symbols<CR>'         , 'n'),
            key('<leader>lfw',     '<cmd>Telescope lsp_workspace_symbols<CR>'        , 'n'),
            key('<leader>lf<C-s>', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'n'),
        },
        config = cfg('util.telescope'),
    },
    -- }}}

    -- {{{ toggleterm
    {
        'akinsho/toggleterm.nvim',
        cmd = {
            'ToggleTerm',
            'ToggleTermToggleAll',
            'TermExec',
            'TermSelect',
            'ToggleTermSendCurrentLine',
            'ToggleTermSendVisualLines',
            'ToggleTermSendVisualSelection',
            'ToggleTermSetName',
        },
        keys = {
            key('<M-d>', '<cmd>ToggleTerm<CR>', 'n'),
            key('<M-d>', '<C-\\><C-n><cmd>ToggleTerm<CR> ', 't'),
            key(
                '<M-t>',
                function()
                    local cmd = ':ToggleTermSendVisual'
                    local mode = vim.api.nvim_get_mode().mode

                    if mode == 'v' or mode == 'vs' then
                        cmd = cmd .. 'Selection'
                    elseif mode == 'V' or mode == 'Vs' then
                        cmd = cmd .. 'Lines'
                    else
                        return
                    end

                    vim.api.nvim_input(cmd .. ' ')
                    vim.schedule(function()
                        -- hack to redraw noice.nvim ui
                        vim.api.nvim_input(" <bs>")
                    end)
                end,
                'v'
            ),
        },
        config = cfg('util.toggleterm'),
    },
    -- }}}

    -- {{{ other
    {
        'kyazdani42/nvim-tree.lua',
        cmd = {
            'NvimTreeFocus',
            'NvimTreeToggle',
            'NvimTreeOpen',
        },
        keys = {
            key('<M-n>', '<cmd>NvimTreeToggle<CR>', 'n'),
        },
        config = cfg('util.nvimtree'),
    },
    {
        'echasnovski/mini.nvim',
        event = 'VeryLazy',
        keys = {
            key('<leader>Fs', '<cmd>lua MiniTrailspace.trim()<CR>', 'n')
        },
        init = fileloader('mini.nvim'),
        config = cfg('editor.mini_trailspace'),
    },
    {
        'ervandew/regex',
        cmd = 'Regex',
    },
    {
        'jghauser/mkdir.nvim',
        lazy = false,
    },
    {
        -- 'Apeiros-46B/qalc.nvim',
	    dir = '/home/apeiros/code/projects/qalc.nvim/',
        keys = {
            key('<leader>qn', '<cmd>vs | Qalc<CR>', 'n'), -- open qalc in vertical split
            key('<leader>qy', '<cmd>QalcYank<CR>', 'n'),  -- yank result
        },
        cmd = {
            'Qalc',
            'QalcAttach',
        },
        init = function()
            -- lazy loading for specific file extension
            vim.api.nvim_create_autocmd({ 'BufEnter' }, {
                pattern = { '*.qalc' }, command = 'QalcAttach'
            })
        end,
        config = cfg('util.qalc'),
    },
    {
        'jbyuki/venn.nvim',
        cmd = { 'VBox' },
        keys = {
            key('<leader>v', ':VBox<CR>', 'v'),
        },
        init = function()
            fileloader('venn.nvim')()

            -- set virtualedit and no wrap in files with .venn extension
            vim.api.nvim_create_autocmd('BufEnter', { pattern = '*.venn', command = 'setlocal nowrap ve=all ft=venn' })
        end,
    },
    {
        'jbyuki/instant.nvim',
        event = 'VeryLazy',
        config = function()
            vim.g.instant_username = 'apeiros'
        end
    }
    -- }}}
    -- }}}
}
-- }}}

-- {{{ lazy.nvim config
local config = {
    -- {{{ misc
    root = vim.fn.stdpath('data') .. '/lazy', -- installation root
    defaults = {
        lazy = true,
        version = '*', -- enable this to try installing the latest stable versions of plugins
    },
    lockfile = vim.fn.stdpath('config') .. '/lock.json',
    concurrency = 5,
    -- }}}

    -- {{{ installation
    git = {
        log = { '-10' },
        timeout = 120, -- seconds
        url_format = 'https://github.com/%s.git',
    },
    dev = { -- local plugins
        path = '~/projects',
        patterns = {},
    },
    install = {
        missing = true,
        colorscheme = { 'everforest' },
    },
    -- }}}

    -- {{{ ui
    ui = {
        size = { width = 0.8, height = 0.8 },
        border = 'none',
        backdrop = 100,
        icons = {
            loaded     = '+',
            not_loaded = '',
            cmd        = '󰞷',
            config     = '󰊕',
            event      = '',
            ft         = '󰈙',
            init       = '',
            keys       = '󰌋',
            plugin     = '󰏓',
            runtime    = '󰆧',
            source     = '',
            start      = '',
            task       = '󰄬',
            lazy       = '   ',

            list = {
                '->',
                '->',
                '->',
                '->',
            },
        },
        throttle = 20, -- how frequently should the ui process render events
    },
    -- }}}

    -- {{{ checker & change detection
    checker = {
        enabled = false,
        concurrency = nil,
        notify = true,
        frequency = 3600,
    },
    change_detection = {
        enabled = true,
        notify = true,
    },
    -- }}}

    -- {{{ performance
    performance = {
        cache = {
            enabled = true,
            path = vim.fn.stdpath('cache') .. '/lazy/cache',
            disable_events = { 'VimEnter', 'BufReadPre' },
        },
        reset_packpath = true,
        rtp = {
            reset = true,
            paths = {},
            disabled_plugins = {
                'tohtml',
                'getscript',
                'getscriptPlugin',
                'logipat',
                'man',
                'matchit',
                -- netrw is enabled for nvimtree hijack
                -- 'netrw',
                -- 'netrwPlugin',
                -- 'netrwSettings',
                -- 'netrwFileHandlers',
                'rplugin',
                'rrhelper',
                'spellfile',
                'tutor',
                'vimball',
                'vimballPlugin',
            },
        },
    },
    -- }}}

    -- {{{ readme doc generation
    readme = {
        root = vim.fn.stdpath('state') .. '/lazy/readme',
        files = { 'README.md' },
        skip_if_doc_exists = true,
    },
    -- }}}
}
-- }}}

-- setup
require('lazy').setup(specs, config)
