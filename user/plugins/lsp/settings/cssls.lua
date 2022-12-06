return {
   single_file_support = true,
   -- cmd = { 'vscode-css-language-server', '--stdio' },
   -- cmd = { 'css-languageserver', '--stdio' },
   settings = {
      css = {
         validate = true,
      },
      less = {
         validate = true,
      },
      scss = {
         validate = true,
      },
   },

   filetypes = {
      "svelte",
      "css",
   },
}
