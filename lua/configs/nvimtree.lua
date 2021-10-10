require('nvim-tree').setup({
    on_config_done = nil,
    setup = {
        open_on_setup = 0,
        auto_close = 1,
        open_on_tab = 0,
        update_focused_file = {
            enable = 1,
        },
        lsp_diagnostics = 1,
        view = {
            width = 30,
            side = "left",
            auto_resize = false,
            mappings = {
                custom_only = false,
            },
        },
    },
    show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
        tree_width = 30,
    },
    ignore = { ".git", "node_modules", ".cache" },
    quit_on_open = 0,
    hide_dotfiles = 1,
    git_hl = 1,
    root_folder_modifier = ":t",
    allow_resize = 1,
    auto_ignore_ft = { "startify", "dashboard" },
    icons = {
        default = "",
        symlink = "",
        git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
        },
        folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
        },
    },
})

-- Keymappings
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
