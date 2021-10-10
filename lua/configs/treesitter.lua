require('nvim-treesitter.configs').setup {
    ensure_installed = {"lua", "python", "java", "bash", "javascript"},
    highlight = {
        enable = true,
        disable = { "latex" }
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true
    },
}
