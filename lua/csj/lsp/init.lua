local status, lspconfig = pcall(require, 'lspconfig')
if not status then
  return -- Return if there is any problem with lspconfig
end

require('packer').loader('mason.nvim')
require('packer').loader('mason-lspconfig.nvim')

local SERVERS = {
  'bashls',
  'cssls',
  -- 'cssmodules_ls',
  'emmet_ls',
  'html',
  'jdtls',
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
    on_attach = require('csj.lsp.handlers').on_attach,
    capabilities = require('csj.lsp.handlers').capabilities,
  }

  local has_opts, custom_opts = pcall(require, string.format('%s.%s', 'csj.lsp.settings', server))
  if has_opts then opts = vim.tbl_deep_extend('force', custom_opts, opts) end

  lspconfig[server].setup(opts)
end

require('csj.lsp.handlers').setup()
-- require('csj.lsp.top_right_lsp_diagnostics') -- Using lsp_lines.nvim for now

require('packer').loader('null-ls.nvim')
require('csj.lsp.null-ls')

-- vim.api.nvim_cmd({ cmd = 'LspStart' }, {}) -- vim.cmd('LspStart')
