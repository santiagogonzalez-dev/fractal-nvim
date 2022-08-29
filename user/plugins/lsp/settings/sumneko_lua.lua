return {
   settings = {
      Lua = {
         format = {
            enable = false, -- This is also disabled in the null-ls config
         },
         hint = {
            enable = true,
            arrayIndex = 'Disable', -- 'Enable', 'Auto', 'Disable'
            await = true,
            paramName = 'Disable', --'All', 'SameLine', 'Disable'
            paramType = false,
            semicolon = 'Disable', -- 'All', 'SameLine', 'Disable'
            setType = true,
         },
         diagnostics = { globals = { 'vim' } },
         completion = {
            keywordSnippet = 'Replace',
            callSnippet = 'Replace',
         },
         runtime = {
            version = 'LuaJIT',
            special = {
               reload = 'require',
            },
         },
         workspace = {
            library = {
               [vim.fn.expand '$VIMRUNTIME/lua'] = true,
               [vim.fn.stdpath 'config' .. '/lua'] = true,
               [vim.fn.stdpath 'config' .. '/user'] = true,
            },
         },
      },
   },
}
