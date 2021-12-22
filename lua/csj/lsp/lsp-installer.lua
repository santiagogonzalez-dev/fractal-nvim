local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
    return
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require('csj.lsp.handlers').on_attach,
        capabilities = require('csj.lsp.handlers').capabilities,
    }

    if server.name == 'jsonls' then
        local jsonls_opts = require('csj.lsp.settings.jsonls')
        opts = vim.tbl_deep_extend('force', jsonls_opts, opts)
    end

    if server.name == 'sumneko_lua' then
        local sumneko_opts = require('csj.lsp.settings.sumneko_lua')
        opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
    end

    if server.name == 'jdtls' then
        local jdtls_opts = require('csj.lsp.settings.jdtls')
        opts = vim.tbl_deep_extend('force', jdtls_opts, opts)
    end

    if server.name == 'pyright' then
        local pyright_opts = require('csj.lsp.settings.pyright')
        opts = vim.tbl_deep_extend('force', pyright_opts, opts)
    end

    server:setup(opts)
end)
