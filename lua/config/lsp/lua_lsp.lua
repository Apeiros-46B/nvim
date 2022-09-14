return function(on_attach)
    require('lspconfig').sumneko_lua.setup({
	    -- cmd = { sumneko_binary, '-E', sumneko_install_path .. '/main.lua' },
	    settings = {
		    Lua = {
			    runtime = {
				    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				    version = 'LuaJIT',
				    -- Setup your lua path
				    -- path = runtime_path,
			    },
			    diagnostics = {
				    -- Get the language server to recognize the `vim` global and `awesome`-related globals
				    globals = { 'vim', 'root', 'client', 'awesome' },
			    },
			    workspace = {
				    -- Make the server aware of Neovim runtime files
				    library = vim.api.nvim_get_runtime_file('', true),
			    },
			    -- Do not send telemetry data containing a randomized but unique identifier
			    telemetry = {
				    enable = false,
			    },
		    },
	    },
        on_attach = on_attach
    })
end
