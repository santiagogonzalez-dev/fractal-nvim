local status, lspconfig = pcall(require, 'lspconfig')
if not status then
   return -- Return if there is any problem with lspconfig
end

local packer = require('plugins.packer').packer()

packer.loader 'mason.nvim'
packer.loader 'mason-lspconfig.nvim'

local SERVERS = {
   'bashls',
   'cssls',
   'cssmodules_ls',
   'emmet_ls',
   'gopls',
   'hls',
   'html',
   'jdtls',
   'jsonls',
   'pyright',
   'sumneko_lua',
   'tsserver',
}

require('mason-lspconfig').setup {
   ensure_installed = SERVERS,
   automatic_installation = false,
}

require('mason').setup()

for _, server in pairs(SERVERS) do
   local opts = {
      on_attach = require('plugins.lsp.handlers').on_attach,
      capabilities = require('plugins.lsp.handlers').capabilities,
   }

   local has_opts, custom_opts =
      pcall(require, string.format('%s.%s', 'plugins.lsp.settings', server))
   if has_opts then opts = vim.tbl_deep_extend('force', custom_opts, opts) end

   lspconfig[server].setup(opts)
end

require('plugins.lsp.handlers').setup()

packer.loader 'null-ls.nvim'
require 'plugins.lsp.null-ls'
