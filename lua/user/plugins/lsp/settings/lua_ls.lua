return {
	single_file_support = true,
	settings = {
		Lua = {
			format = {
				enable = false, -- This is also disabled in the null-ls config
			},
			hint = {
				enable = true,
				arrayIndex = "Auto", -- 'Enable', 'Auto', 'Disable'
				await = true,
				paramName = "Disable", --'All', 'SameLine', 'Disable'
				paramType = true,
				semicolon = "Disable", -- 'All', 'SameLine', 'Disable'
				setType = true,
			},
			diagnostics = {
				globals = {
					"vim",
					"map", -- See my own implementation of map at `fractal.core.general`
				},
			},
			completion = {
				keywordSnippet = "Both",
				callSnippet = "Both",
			},
			runtime = {
				version = "LuaJIT",
				special = {
					reload = "require",
				},
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
					[vim.fn.stdpath("config") .. "/user"] = true,
					["/home/st/.local/share/nvim/mason/packages/lua-lan guage-server/libexec/meta/5393ac01"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
