local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

require('csj.lsp.lsp-installer') -- Languages configured with lsp-installer
require('csj.lsp.handlers').setup()
require('csj.lsp.null-ls') -- Null-LS
