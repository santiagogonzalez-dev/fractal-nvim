local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
    return
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require('csj.lsp.handlers').on_attach,
        capabilities = require('csj.lsp.handlers').capabilities,
    }

    -- json
    if server.name == 'jsonls' then
        local jsonls_opts = require('csj.lsp.settings.jsonls')
        opts = vim.tbl_deep_extend('force', jsonls_opts, opts)
    end

    -- lua
    if server.name == 'sumneko_lua' then
        local sumneko_opts = require('csj.lsp.settings.sumneko_lua')
        opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
    end

    -- python
    if server.name == 'pyright' then
        local pyright_opts = require('csj.lsp.settings.pyright')
        opts = vim.tbl_deep_extend('force', pyright_opts, opts)
    end

    -- typescript, javascript, typescriptreact, javascriptreact
    if server.name == 'tsserver' then
        local tsserver_opts = require('csj.lsp.settings.tsserver')
        opts = vim.tbl_deep_extend('force', tsserver_opts, opts)
    end

    -- sql
    if server.name == 'sqls' then
        local sqls_opts = require('csj.lsp.settings.sqls')
        opts = vim.tbl_deep_extend('force', sqls_opts, opts)
    end

    -- emmet_ls
    if server.name == 'emmet_ls' then
        local emmet_opts = require('csj.lsp.settings.emmet')
        opts = vim.tbl_deep_extend('force', emmet_opts, opts)
    end

    -- markdown
    if server.name == 'zeta_note' then
        local zeta_opts = require('csj.lsp.settings.zeta')
        opts = vim.tbl_deep_extend('force', zeta_opts, opts)
    end

    server:setup(opts)
end)
