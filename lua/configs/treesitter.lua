require('nvim-treesitter.configs').setup({
    -- ensure_installed = {'lua', 'python', 'java', 'bash', 'javascript'},
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
        disable = { 'latex' }
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true
    },
})
