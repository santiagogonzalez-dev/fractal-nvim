local status, lspconfig = pcall(require, 'lspconfig')
if not status then
  return -- Return if there is any problem with lspconfig
end

require('packer').loader('mason.nvim')
require('packer').loader('mason-lspconfig.nvim')

local SERVERS = {
  'bashls',
  'cssls',
  'cssmodules_ls',
  'emmet_ls',
  'html',
  'jdtls',
  -- 'jsonls',
  'gopls',
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
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
  }

  local has_opts, custom_opts =
    pcall(require, string.format('%s.%s', 'user.lsp.settings', server))
  if has_opts then
    opts = vim.tbl_deep_extend('force', custom_opts, opts)
  end

  lspconfig[server].setup(opts)
end

require('user.lsp.handlers').setup()
-- require('user.lsp.top-right-lsp-diagnostics') -- Using lsp_lines.nvim for now

require('packer').loader('null-ls.nvim')
require('user.lsp.null-ls')

vim.cmd.LspStart()
