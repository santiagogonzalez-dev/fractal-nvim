local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
    return
end

require('csj.lsp.handlers').setup()
require('csj.lsp.top_right_lsp_diagnostics')
