require('nvim-treesitter.configs').setup({
    -- ensure_installed = {'lua', 'python', 'java', 'bash', 'javascript'},
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
        aditional_vim_regex_highlighting = true,
        disable = { 'latex' },
    },
    context_commentstring = {
        enable = false,
        config = { css = '// %s' },
    },
    indent = {
        enable = true,
        disable = { 'python' },
    },
    textsubjects = {
        enable = true,
        keymaps = {
            [','] = 'textsubjects-smart',
        },
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
    },
    autotag = {
        enable = { -- Only enable autotagging in this type of files
            'html',
            'css',
            'xml',
        },
    }, -- requires windwp/nvim-ts-autotag
})
