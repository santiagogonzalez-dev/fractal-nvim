local status_ok, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

treesitter_configs.setup({
    ensure_installed = 'maintained',
    sync_install = false,
    highlight = {
        enable = true,
        aditional_vim_regex_highlighting = true,
        disable = { 'latex' },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    indent = {
        enable = true,
        disable = {
            'yaml',
            'lua',
            'python',
        },
    },
    autopairs = { enable = true },
    autotag = {
        enable = true,
        filetypes = {
            'css',
            'html',
            'javascript',
            'javascriptreact',
            'markdown',
            'svelte',
            'typescript',
            'typescriptreact',
            'vue',
            'xhtml',
            'xml',
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'gnn',
            node_decremental = 'gnp',
            scope_incremental = 'gns',
        },
    },
    rainbow = {
        enable = true,
        colors = {
            '#908caa',
            '#eb6f92',
            '#f6c177',
            '#31748f',
            '#9ccfd8',
            '#c4a7e7',
        },
        extended_mode = true,
    },
})
