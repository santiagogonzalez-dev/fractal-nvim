require('nvim-treesitter.configs').setup {
    ensure_installed = {"lua", "python", "java", "bash", "javascript"},
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true
    },
}
