local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local methods = null_ls.methods

null_ls.setup({
    debug = false,
    sources = {
        code_actions.gitsigns,
        formatting.stylua,
        formatting.prettier.with({
            prefer_local = 'node_modules/.bin',
            command = 'prettier',
            filetypes = {
                'javascript',
                'javascriptreact',
                'typescript',
                'typescriptreact',
                'vue',
                'css',
                'scss',
                'less',
                'html',
                'json',
                'yaml',
                'markdown',
                'graphql',
            },
            extra_args = {
                '--no-semi',
                '--single-quote',
                '--jsx-single-quote',
                '--tab-width',
                '4',
            },
        }),
        formatting.black.with({
            extra_args = {
                '--fast',
                '--quiet',
                '--skip-string-normalization',
                '--line-length',
                '120',
            },
        }),
        diagnostics.shellcheck.with({
            -- method = methods.DIAGNOSTICS_ON_SAVE,
        }),
        diagnostics.eslint.with({
            -- method = methods.DIAGNOSTICS_ON_SAVE,
        }),
        diagnostics.flake8.with({
            -- method = methods.DIAGNOSTICS_ON_SAVE,
            extra_args = { '--max-line-length', '120' },
        }),
    },
})
