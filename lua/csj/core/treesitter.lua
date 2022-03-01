local status_ok, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
   return
end

treesitter_configs.setup({
   ensure_installed = 'maintained',
   sync_install = false,
   highlight = {
      enable = true,
      aditional_vim_regex_highlighting = true,
      disable = { 'latex' },
   },
   context_commentstring = {
      enable = true,
      enable_autocmd = false,
   },
   indent = {
      enable = true,
      disable = {
         'yaml',
         'python',
      },
   },
   autopairs = { enable = true },
   autotag = {
      enable = true,
      filetypes = {
         'css',
         'html',
         'javascript',
         'javascriptreact',
         'markdown',
         'svelte',
         'typescript',
         'typescriptreact',
         'vue',
         'xhtml',
         'xml',
      },
   },
   incremental_selection = {
      enable = true,
      keymaps = {
         init_selection = 'gnn',
         node_incremental = 'gnn',
         node_decremental = 'gnp',
         scope_incremental = 'gns',
      },
   },
   rainbow = {
      enable = true,
      colors = {
         '#31748f',
         '#908caa',
         '#c4a7e7',
         '#f6c177',
         '#9ccfd8',
         '#eb6f92',
         '#ebbcba',
      },
      extended_mode = true,
   },
})
