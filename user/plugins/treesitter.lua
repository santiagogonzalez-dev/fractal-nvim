local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
   return
end

-- Enable bundled treesitter parsers, this also turns off `syntax`.
-- https://github.com/neovim/neovim/issues/14090#issuecomment-1237820552
vim.g.ts_highlight_lua = true

treesitter.setup({
   ensure_installed = 'all',
   auto_install = true,
   sync_install = false,
   highlight = {
      enable = true,
      aditional_vim_regex_highlighting = false,
      disable = {
         function(_, bufnr)
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            local file_size =
               vim.api.nvim_call_function('getfsize', { buf_name })
            return file_size > 256 * 1024
         end,
         'latex',
      },
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
   autopairs = {
      enable = true,
   },
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
         init_selection = 'gnn', -- Start the selection by nodes
         node_incremental = 'gnn', -- Increment to the node with higher order
         node_decremental = 'gnp', -- Decrement to the node with lower order
         scope_incremental = 'gns', -- Select the entire group  of nodes including the braces
      },
   },
})
