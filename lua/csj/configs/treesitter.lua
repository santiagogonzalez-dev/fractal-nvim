local status_ok, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

treesitter_configs.setup({
    -- ensure_installed = 'maintained',
    ensure_installed = {
        'comment',
        'css',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'markdown',
        'python',
        'svelte',
        'typescript',
        'vim',
    },
    sync_install = false,
    highlight = {
        enable = true,
        aditional_vim_regex_highlighting = true,
        disable = { 'latex' },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = true,
    },
    indent = {
        enable = true,
        disable = {
            'yaml',
            -- 'python',
        },
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
    },
    autopairs = { enable = true },
    autotag = {
        enable = true,
        filetypes = {
            'html',
            'xhtml',
            'xml',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'svelte',
            'vue',
            'markdown',
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'gnn',
            scope_incremental = 'gns',
            node_decremental = 'gnp',
        },
    },
})
