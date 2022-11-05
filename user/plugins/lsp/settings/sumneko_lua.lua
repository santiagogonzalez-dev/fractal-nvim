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
            setType = false,
         },
         diagnostics = { globals = { "vim" } },
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
               [vim.fn.expand "$VIMRUNTIME/lua"] = true,
               [vim.fn.stdpath "config" .. "/lua"] = true,
               [vim.fn.stdpath "config" .. "/user"] = true,
            },
         },
         telemetry = {
            enable = false,
         },
      },
   },
}
