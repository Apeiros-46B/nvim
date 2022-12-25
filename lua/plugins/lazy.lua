-- load plugins

-- {{{ helpers
-- {{{ create keymaps
-- create a full mapping
local function key(lhs, rhs, mode, desc, additional_opts)
    local opts = { lhs, rhs, mode = mode, desc = desc, noremap = true, silent = true }

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

-- {{{ NvChad's lazy loading helpers (slightly modified for lazy.nvim)
-- {{{ main loader function
local function load(tbl)
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
local function load_on_file(plugin)
    load({
        events = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
        augroup_name = 'BeLazyOnFileOpen' .. plugin,
        plugin = plugin,
        condition = function()
            local file = vim.fn.expand '%'
            return file ~= 'NvimTree_1' and file ~= '[packer]' and file ~= 'Starter' and file ~= ''
        end,
        reason = 'FileOpenLoader'
    })
end
-- }}}

-- {{{ load files only if cwd is a git repo
local function load_on_git(plugin)
    vim.api.nvim_create_autocmd({ 'BufRead' }, {
        group = vim.api.nvim_create_augroup('GitLazyLoad' .. plugin, { clear = true }),
        callback = function()
            vim.fn.system('git -C ' .. vim.fn.expand '%:p:h' .. ' rev-parse')
            if vim.v.shell_error == 0 then
                vim.api.nvim_del_augroup_by_name('GitLazyLoad' .. plugin)
                vim.schedule(function()
                    require('lazy.core.loader').load(plugin, { event = 'GitLoader' })
                end)
            end
        end,
    })
end
-- }}}
-- }}}
-- }}}

-- {{{ plugin specs
local specs =  {
    -- {{{ base
    {
        'sainnhe/everforest',
        lazy = true,
        commit = 'd855af5',
        init = function()
            -- load theme here
            require('core.theme')
        end,
    },
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    -- }}}

    -- {{{ [completion] plugins related to completion
    -- {{{ cmp
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            require('plugins.config.completion.cmp')
        end,
        dependencies = {
            -- lsp, dictionary aren't needed for core cmp to function; they can load later
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'quangnguyen30192/cmp-nvim-ultisnips',
        }
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
        config = function()
            require('plugins.config.completion.cmp_dictionary')
        end,
    },
    -- }}}

    -- {{{ ultisnips
    {
        'SirVer/ultisnips',
        event = 'InsertEnter',
        config = function()
            require('plugins.config.completion.ultisnips')
        end,
    },
    -- }}}
    -- }}}

    -- {{{ [editor] plugins related to core editor functionality
    -- {{{ essential editing features
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('plugins.config.editor.autopairs')
        end,
    },
    {
        'terrortylor/nvim-comment',
        keys = {
            key('<C-c>', '<cmd>CommentToggle<CR>', 'n'),
            key('<C-c>', ':CommentToggle<CR>', 'v'),
        },
        cmd = 'CommentToggle',
        config = function()
            require('plugins.config.editor.comment')
        end,
    },
    {
        'kylechui/nvim-surround',
        keys = {
            -- {{{ surround keys
            lkey('i', '<C-g>s'), -- insert
            lkey('i', '<C-g>S'), -- insert line
            lkey('n', 'ys'),     -- normal
            lkey('n', 'yS'),     -- normal line
            lkey('v', 'S'),      -- visual
            lkey('v', 'gS'),     -- visual line
            lkey('n', 'ds'),     -- delete
            lkey('n', 'cs'),     -- change
            -- }}}
        },
        config = function()
            require('plugins.config.editor.surround')
        end,
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
        config = function()
            require('plugins.config.editor.hop')
        end,
    },
    -- }}}

    -- {{{ other editing-related embellishments
    {
        'jghauser/mkdir.nvim',
        lazy = false,
    },
    {
        'cshuaimin/ssr.nvim',
        config = function()
            require('plugins.config.editor.ssr')
        end,
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
        config = function()
            require('plugins.config.editor.dial')
        end,
    },
    -- }}}
    -- }}}

    -- {{{ [git] plugins related to git
    {
        'lewis6991/gitsigns.nvim',
        init = function()
            load_on_git('gitsigns.nvim')
        end,
        config = function()
            require('plugins.config.git.gitsigns')
        end,
    },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        init = function()
            load_on_git('vim-fugitive')
        end,
    },
    -- }}}

    -- {{{ [lsp] plugins related to lsp, dap, or linters
    -- {{{ base
    -- mason
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        dependencies = {
            -- {{{ lspconfig
            {
                'williamboman/mason-lspconfig.nvim',
                dependencies = {
                    {
                        'neovim/nvim-lspconfig',
                        init = function()
                            load_on_file('nvim-lspconfig')
                        end,
                    },
                }
            },
            -- }}}
            -- {{{ null-ls
            {
                'jay-babu/mason-null-ls.nvim',
                dependencies = {
                    {
                        'jose-elias-alvarez/null-ls.nvim',
                        init = function()
                            load_on_file('null-ls.nvim')
                        end,
                    },
                },
            },
            -- }}}
        },
        init = function()
            load_on_file('mason.nvim')
        end,
        config = function()
            require('plugins.config.lsp.mason')
        end,
    },

    -- dap
    {
        'mfussenegger/nvim-dap',
        init = function()
            load_on_file('nvim-dap')
        end,
    },

    -- enhancements for specific servers
    'simrat39/rust-tools.nvim',
    'mfussenegger/nvim-jdtls',
    -- }}}

    -- {{{ other lsp-related plugins
    {
        'folke/lsp-colors.nvim',
        event = 'LspAttach',
    },
    {
        'onsails/lspkind-nvim',
        event = 'LspAttach',
        config = function()
            require('plugins.config.lsp.lspkind')
        end,
    },
    {
        'glepnir/lspsaga.nvim',
        event = 'LspAttach',
        cmd = 'Lspsaga',
        config = function()
            require('plugins.config.lsp.lspsaga')
        end,
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
        config = function()
            require('plugins.config.lsp.trouble')
        end,
    },
    {
        'SmiteshP/nvim-navic',
        event = 'LspAttach',
        config = function()
            require('plugins.config.lsp.navic')
        end,
    },
    {
        'zbirenbaum/neodim',
        event = 'LspAttach',
        config = function()
            require('plugins.config.lsp.neodim')
        end,
    },
    -- }}}
    -- }}}

    -- {{{ [syntax] mostly treesitter and syntax support/highlighting-related plugins
    -- {{{ treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('plugins.config.syntax.treesitter')
        end,
        build = ':TSUpdate',
    },
    -- }}}

    -- {{{ neorg
    {
        'nvim-neorg/neorg',
        ft = 'norg',
        dependencies = {
            'nvim-neorg/neorg-telescope'
        },
        config = function()
            require('plugins.config.syntax.neorg')
        end,
        build = ':Neorg sync-parsers',
    },
    -- }}}

    -- {{{ other
    {
        'RRethy/vim-illuminate',
        init = function()
            load_on_file('vim-illuminate')
        end,
        config = function()
            require('plugins.config.syntax.illuminate')
        end,
    },
    {
        'folke/todo-comments.nvim',
        init = function()
            load_on_file('todo-comments.nvim')
        end,
        config = function()
            require('plugins.config.syntax.todo_comments')
        end,
    },
    -- }}}
    -- }}}

    -- {{{ [ui] plugins that enhance the user interface
    -- devicons
    {
        'kyazdani42/nvim-web-devicons',
        config = function()
            require('plugins.config.ui.devicons')
        end,
    },

    -- status line
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        config = function()
            require('plugins.config.ui.lualine')
        end,
    },

    -- scrollbar
    {
        'kensyo/nvim-scrlbkun',
        init = function()
            load_on_file('nvim-scrlbkun')
        end,
        config = function()
            require('plugins.config.ui.scrlbkun')
        end,
    },

    -- keybind help
    {
        'folke/which-key.nvim',
        lazy = false,
        config = function()
            require('plugins.config.ui.which_key')
        end,
    },
    -- }}}

    -- {{{ [util] other utilities
    -- {{{ telescope
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            -- fzf native
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        config = function()
            require('plugins.config.util.telescope')
        end,
    },

    -- extensions
    { url = 'https://code.sitosis.com/rudism/telescope-dict.nvim.git' },
    -- }}}

    -- {{{ major utilities
    {
        'kyazdani42/nvim-tree.lua',
        cmd = {
            'NvimTreeFocus',
            'NvimTreeToggle',
            'NvimTreeOpen',
        },
        keys = {
            key('<C-n>', '<cmd>NvimTreeToggle<CR>', 'n', 'Toggle NvimTree'),
        },
        config = function()
            require('plugins.config.util.nvimtree')
        end,
    },
    {
        'echasnovski/mini.nvim',
        lazy = false,
        config = function()
            require('plugins.config.ui.mini_tabline') -- TODO: replace with cokeline
            require('plugins.config.editor.mini_trailspace')
        end,
    },
    -- }}}

    -- {{{ small utilities
    {
        'NFrid/due.nvim',
        ft = 'norg',
        config = function()
            require('plugins.config.util.due')
        end,
    },
    {
        'itchyny/calendar.vim',
        cmd = 'Calendar',
        config = function()
            require('plugins.config.util.calendar')
        end,
    },
    {
        -- 'Apeiros-46B/qalc.nvim',
        dir = '/home/apeiros/code/projects/qalc.nvim/',
        keys = {
            key('<leader>m', '<cmd>vs | Qalc<CR>', 'n', 'Open qalc in a vertical split'), -- open qalc in vertical split
            key('<leader>M', '<cmd>sp | Qalc<CR>', 'n', 'Open qalc in a horizontal split'), -- open qalc in horizontal split
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
        config = function()
            require('plugins.config.util.qalc')
        end,
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
    lockfile = vim.fn.stdpath('config') .. '/lazy-lock.json',
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
                'netrw',
                'netrwPlugin',
                'netrwSettings',
                'netrwFileHandlers',
                -- I like the archive plugins
                -- 'gzip',
                -- 'zip',
                -- 'zipPlugin',
                -- 'tar',
                -- 'tarPlugin',
                'getscript',
                'getscriptPlugin',
                'vimball',
                'vimballPlugin',
                '2html_plugin',
                'logipat',
                'rrhelper',
                'spellfile_plugin',
                'matchit'
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

-- {{{ custom highlights
local theme = require('core.theme')
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
-- }}}
