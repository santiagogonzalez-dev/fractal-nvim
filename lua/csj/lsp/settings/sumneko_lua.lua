return {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      completion = {
        keywordSnippet = 'Replace',
        callSnippet = 'Replace',
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
      },
    },
  },
}
