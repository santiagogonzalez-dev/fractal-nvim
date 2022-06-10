local status, lspconfig = pcall(require, 'lspconfig')
if not status then
   return -- Return if there is any problem with lspconfig
end

local SERVERS = {
   'bashls',
   'cssls',
   'html',
   'pyright',
   'sumneko_lua',
   'tsserver',
   -- 'cssmodules_ls',
   -- 'emmet_ls',
}

for _, server in pairs(SERVERS) do
   local opts = {
      on_attach = require('csj.lsp.handlers').on_attach,
      capabilities = require('csj.lsp.handlers').capabilities,
   }

   local has_opts, custom_opts = pcall(require, string.format('%s.%s', 'csj.lsp.settings', server))
   if has_opts then
      opts = vim.tbl_deep_extend('force', custom_opts, opts)
   end

   lspconfig[server].setup(opts)
end

require('csj.lsp.handlers').setup()
require('csj.lsp.top_right_lsp_diagnostics')

require('packer').loader('null-ls.nvim')
require('csj.lsp.null-ls')

vim.cmd('LspStart')
