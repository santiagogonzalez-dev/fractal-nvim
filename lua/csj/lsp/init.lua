local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
    return
end
local root_pattern = require('lspconfig/util').root_pattern

require('csj.lsp.lsp-installer') -- Languages configured with lsp-installer
require('csj.lsp.handlers').setup()

-- Other language servers
lspconfig.zeta_note.setup({
    on_attach = require('csj.lsp.handlers').on_attach,
    capabilities = require('csj.lsp.handlers').capabilities,
    cmd = { 'zeta-note' },
    root_dir = root_pattern('.git', 'slip_box.db', '0.md'),
})
