---@diagnostic disable: param-type-mismatch
-- load plugins

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
local theme

local function call(module)
    return function()
        local ret = require(module)

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
            events = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
            augroup_name = 'FileOpenLazy' .. plugin,
            plugin = plugin,
            condition = function()
                local file = vim.fn.expand '%'
                return file ~= 'NvimTree_1' and file ~= ''
            end,
            reason = 'BufRead'
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

-- {{{ plugin specs
local specs =  {
    -- {{{ base
    {
        'sainnhe/everforest',
        -- old palette >> new
        commit = 'd855af5',
        pin = true,
        init = function()
            theme = require('plugins.theme')
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
        config = call('plugins.config.completion.cmp'),
    },
    -- }}}

    -- {{{ cmp sources loaded later
    {
        'hrsh7th/cmp-nvim-lsp',
        event = 'LspAttach',
    },
    {
        'uga-rosa/cmp-dictionary',
        ft = { 'norg', 'markdown' },
        config = call('plugins.config.completion.cmp_dictionary'),
    },
    -- }}}

    -- {{{ ultisnips
    {
        'SirVer/ultisnips',
        ft = 'snippets',
        event = 'InsertEnter',
        config = call('plugins.config.completion.ultisnips'),
    },
    -- }}}
    -- }}}

    -- {{{ [editor] plugins related to core editor functionality
    -- {{{ essential editing features
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = call('plugins.config.editor.autopairs'),
    },
    {
        'terrortylor/nvim-comment',
        keys = {
            key('<C-c>', '<cmd>CommentToggle<CR>', 'n'),
            key('<C-c>', ':CommentToggle<CR>'    , 'v'),
        },
        cmd = 'CommentToggle',
        config = call('plugins.config.editor.comment'),
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
        config = call('plugins.config.editor.surround'),
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
            key('<leader>hk', ':HopWordBC<CR>'         , 'n', { silent = false }),
            key('<leader>hj', ':HopWordAC<CR>'         , 'n', { silent = false }),
            key('<leader>hl', ':HopWordMW<CR>'         , 'n', { silent = false }),
            key('<leader>hc', ':HopChar1<CR>'          , 'n', { silent = false }),
            key('<leader>hC', ':HopChar2<CR>'          , 'n', { silent = false }),
            key('<leader>hg', ':HopPattern<CR>'        , 'n', { silent = false }),
            key('<leader>hn', ':HopLineStart<CR>'      , 'n', { silent = false }),
            key('<leader>hf', ':HopWordCurrentLine<CR>', 'n', { silent = false }),
            -- }}}
        },
        config = call('plugins.config.editor.hop'),
    },
    -- }}}

    -- {{{ other editing-related embellishments
    {
        'jghauser/mkdir.nvim',
        lazy = false,
    },
    {
        'cshuaimin/ssr.nvim',
        keys = {
            key('<leader>s', '<cmd>lua require("ssr").open()<CR>', 'n'),
        },
        config = call('plugins.config.editor.ssr'),
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
        config = call('plugins.config.editor.dial'),
    },
    -- }}}
    -- }}}

    -- {{{ [git] plugins related to git
    {
        'lewis6991/gitsigns.nvim',
        init = gitloader('gitsigns.nvim'),
        config = call('plugins.config.git.gitsigns'),
    },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        init = gitloader('vim-fugitive'),
        keys = {
            key('<leader>gg', '<cmd>Git<CR>'       , 'n'),
            key('<leader>gB', '<cmd>Git blame<CR>' , 'n'),
            key('<leader>gc', '<cmd>Git commit<CR>', 'n'),
        },
    },
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
        init = fileloader('mason.nvim'),
        config = call('plugins.config.lsp.mason'),
    },

    -- dap
    {
        'mfussenegger/nvim-dap',
        init = fileloader('nvim-dap'),
    },
    -- }}}

    -- {{{ other lsp-related plugins
    {
        'folke/lsp-colors.nvim',
        event = 'LspAttach',
    },
    {
        'onsails/lspkind-nvim',
        event = 'LspAttach',
        config = call('plugins.config.lsp.lspkind'),
    },
    {
        'glepnir/lspsaga.nvim',
        event = 'LspAttach',
        cmd = 'Lspsaga',
        keys = {
            -- {{{ lspsaga keys
            key('<leader>lf', '<cmd>Lspsaga lsp_finder<CR>'               , 'n'),
            key('<leader>lp', '<cmd>Lspsaga hover_doc<CR>'                , 'n'),
            key('<leader>lr', '<cmd>Lspsaga rename<CR>'                   , 'n'),
            key('<leader>ld', '<cmd>Lspsaga peek_definition<CR>'          , 'n'),
            key('<M-CR>'    , '<cmd>Lspsaga code_action<CR>'              , 'n'),
            key('<M-d>'     , '<cmd>Lspsaga open_floaterm<CR>'            , 'n'),
            key('<M-d>'     , '<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>', 't'),
            -- }}}
        },
        config = call('plugins.config.lsp.lspsaga'),
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
        config = call('plugins.config.lsp.trouble'),
    },
    'SmiteshP/nvim-navic',
    {
        'zbirenbaum/neodim',
        event = 'LspAttach',
        keys = {
            key('<leader>Tn', '<cmd>NavicToggle<CR>', 'n'),
        },
        config = call('plugins.config.lsp.neodim'),
    },
    -- }}}
    -- }}}

    -- {{{ [langs] language support
    -- the following two are setup with mason
    'simrat39/rust-tools.nvim', -- rust

    -- java
    {
        'mfussenegger/nvim-jdtls',
        keys = {
            -- {{{ jdtls keys
            key('<leader>jb',  '<cmd>vs | terminal<CR>imvn clean package -T 4<CR>'   , 'n'),
            key('<leader>jo',  '<cmd>lua require("jdtls").organize_imports()<CR>'    , 'n'),
            key('<leader>jev', '<cmd>lua require("jdtls").extract_variable()<CR>'    , 'n'),
            key('<leader>jev', '<cmd>lua require("jdtls").extract_variable(true)<CR>', 'v'),
            key('<leader>jec', '<cmd>lua require("jdtls").exttract_constant()<CR>'   , 'n'),
            key('<leader>jec', '<cmd>lua require("jdtls").extract_constant(true)<CR>', 'v'),
            key('<leader>jem', '<cmd>lua require("jdtls").extract_method(true)<CR>'  , 'v'),
            -- }}}
        },
    },

    -- haxe
    {
        'jdonaldson/vaxe',
        ft = 'haxe'
    },

    -- {{{ neorg
    {
        'nvim-neorg/neorg',
        build = ':Neorg sync-parsers',
        dependencies = {
            'nvim-neorg/neorg-telescope'
        },
        ft = 'norg',
        keys = {
            key('<leader>nc', '<cmd>Neorg toggle-concealer<CR>'                           , 'n'),
            key('<leader>nC', '<cmd>Neorg toggle-concealer<CR>:Neorg toggle-concealer<CR>', 'n'),
        },
        config = call('plugins.config.lang.neorg'),
    },
    -- }}}
    -- }}}

    -- {{{ [syntax] mostly treesitter and syntax support/highlighting-related plugins
    -- {{{ treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        init = fileloader('nvim-treesitter'),
        config = call('plugins.config.syntax.treesitter'),
    },
    -- }}}

    -- {{{ other
    {
        'RRethy/vim-illuminate',
        init = fileloader('vim-illuminate'),
        config = call('plugins.config.syntax.illuminate'),
    },
    {
        'folke/todo-comments.nvim',
        init = fileloader('todo-comments.nvim'),
        config = call('plugins.config.syntax.todo_comments'),
    },
    -- }}}
    -- }}}

    -- {{{ [ui] plugins that enhance the user interface
    {
        'kyazdani42/nvim-web-devicons',
        config = call('plugins.config.ui.devicons'),
    },

    -- dashboard/greeter
    {
        'goolord/alpha-nvim',
        lazy = false,
        config = call('plugins.config.ui.alpha')
    },

    -- cmdline and notification ui enhancements
    'folke/noice.nvim',

    -- statusline, tabline, and winbar
    {
        'rebelot/heirline.nvim',
        lazy = false,
        config = call('plugins.config.ui.heirline')
    },

    -- {{{ not needed for now
    {
        'noib3/nvim-cokeline',
        enabled = false,
    },
    {
        'nvim-lualine/lualine.nvim',
        enabled = false,
        -- lazy = false,
        keys = {
            key('<leader>Tw', '<cmd>WordCountToggle<CR>', 'n'),
        },
        config = call('plugins.config.ui.lualine'),
    },
    -- }}}

    -- scrollbar
    {
        'Apeiros-46B/nvim-scrlbkun',
        init = fileloader('nvim-scrlbkun'),
        config = call('plugins.config.ui.scrlbkun'),
    },

    -- keybind help
    {
        'folke/which-key.nvim',
        lazy = false,
        config = call('plugins.config.ui.which_key'),
    },
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
            key('<leader>bp', '<cmd>Telescope buffers<CR>', 'n'),

            key('<leader>fb', '<cmd>Telescope marks<CR>'     , 'n'),
            key('<leader>ff', '<cmd>Telescope find_files<CR>', 'n'),
            key('<leader>fr', '<cmd>Telescope oldfiles<CR>'  , 'n'),
            key('<leader>fw', '<cmd>Telescope live_grep<CR>' , 'n'),

            key('<leader>gfc', '<cmd>Telescope git_commits<CR>' , 'n'),
            key('<leader>gfb', '<cmd>Telescope git_branches<CR>', 'n'),
        },

        config = call('plugins.config.util.telescope'),
    },

    -- extensions
    {
        url = 'https://code.sitosis.com/rudism/telescope-dict.nvim.git',
        keys = {
            key('<leader>fs', '<cmd>lua require("telescope").extensions.dict.synonyms()<CR>', 'n')
        },
    },
    -- }}}

    -- {{{ other important utilities
    {
        'kyazdani42/nvim-tree.lua',
        cmd = {
            'NvimTreeFocus',
            'NvimTreeToggle',
            'NvimTreeOpen',
        },
        keys = {
            key('<C-n>', '<cmd>NvimTreeToggle<CR>', 'n'),
        },
        config = call('plugins.config.util.nvimtree'),
    },
    {
        'echasnovski/mini.nvim',
        keys = {
            key('<leader>Fs', '<cmd>lua MiniTrailspace.trim()<CR>', 'n') -- trim trailing spaces
        },
        init = fileloader('mini.nvim'),
        config = function()
            require('plugins.config.ui.mini_tabline')(theme)
            require('plugins.config.editor.mini_trailspace')(theme)
        end,
    },
    -- }}}

    -- {{{ non-essentialsutilities
    {
        'uga-rosa/ccc.nvim',
        init = fileloader('ccc.nvim'),
        keys = {
            key('<leader>c',  '<cmd>CccPick<CR>',              'n'),
            key('<leader>Tc', '<cmd>CccHighlighterToggle<CR>', 'n')
        },
        cmd = {
            'CccPick',
            'CccConvert',
            'CccHighlighterToggle',
            'CccHighlighterEnable',
            'CccHighlighterDisable',
        },
        config = call('plugins.config.util.ccc')
    },
    {
        'NFrid/due.nvim',
        ft = 'norg',
        config = call('plugins.config.util.due'),
    },
    {
        -- 'Apeiros-46B/qalc.nvim',
        dir = '/home/apeiros/code/projects/qalc.nvim/',
        keys = {
            key('<leader>q', '<cmd>vs | Qalc<CR>', 'n'), -- open qalc in vertical split
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
        config = call('plugins.config.util.qalc'),
    },
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
    concurrency = nil,
    -- }}}

    -- {{{ installation
    git = {
        log = { '--since=3 days ago' },
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
        icons = {
            cmd     = 'ﲵ',
            config  = '',
            event   = '',
            ft      = '',
            init    = '',
            keys    = '',
            plugin  = '',
            runtime = '',
            source  = '',
            start   = '',
            task    = '',
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
                'netrw',
                'netrwPlugin',
                'netrwSettings',
                'netrwFileHandlers',
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

-- {{{ custom highlights
-- set before setup because installation of plugins looks nice this way
do
    local theme = require('plugins.theme')
    local colors = theme.colors
    local set_hl = vim.api.nvim_set_hl

    local hl = {
        -- normal & buttons
        LazyNormal         = { bg = colors.gray3, fg = colors.white              },
        LazyButton         = { bg = colors.gray4, fg = colors.white              },
        LazyButtonActive   = { bg = colors.teal,  fg = colors.gray1, bold = true },

        -- headers
        LazyH1             = { bg = colors.teal,  fg = colors.gray1, bold = true },
        LazyH2             = {                    fg = colors.white, bold = true },

        -- progress bar
        LazyProgressDone   = { fg = colors.teal  },
        LazyProgressTodo   = { fg = colors.gray8 },

        -- text
        LazyKey            = { fg = colors.blue                  },
        LazyValue          = { fg = colors.teal                  },
        LazyMuted          = { fg = colors.gray7                 },
        LazyCommit         = { fg = colors.purple                },
        LazySpecial        = { fg = colors.teal,   bold   = true },
        LazyError          = { fg = colors.red,    italic = true },

        -- handlers
        LazyHandlerCmd     = { fg = colors.teal   },
        LazyHandlerEvent   = { fg = colors.purple },
        LazyHandlerFt      = { fg = colors.green  },
        LazyHandlerKeys    = { fg = colors.red    },
        LazyHandlerPLugin  = { fg = colors.yellow },
        LazyHandlerRuntime = { fg = colors.orange },
        LazyHandlerSource  = { fg = colors.teal   },
        LazyHandlerStart   = { fg = colors.blue   },
    }

    for k, v in pairs(hl) do set_hl(0, k, v) end
end
-- }}}

-- setup
require('lazy').setup(specs, config)
