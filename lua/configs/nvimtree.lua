vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1

require('nvim-tree').setup({
    view = {
        side = 'right',
        width = 33,
        auto_resize = true,
    },
    auto_open = 1,
    auto_close = 1,
    follow = 1,
    disable_netrw = 0,
    open_on_setup = 1,
    open_on_tab = 1,
    update_cwd = 1,
    update_focused_file = {
        enable = 1,
        update_cwd = 1,
    },
    show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
        tree_width = 33,
    },
    gitignore = 1,
    ignore = { ".git", "node_modules", ".cache" },
    quit_on_open = 1,
    hide_dotfiles = 0,
    git_hl = 1,
    root_folder_modifier = ":t",
    allow_resize = 1,
    icons = {
        default = " ",
        symlink = " ",
        git = {
            unstaged = " ",
            staged = "S ",
            unmerged = " ",
            renamed = "➜ ",
            deleted = " ",
            untracked = "U ",
            ignored = "◌ ",
        },
        folder = {
            default = " ",
            open = " ",
            empty = " ",
            empty_open = " ",
            symlink = " ",
        },
    },
})

require('nvim-tree.events').on_nvim_tree_ready(function()
    vim.cmd 'NvimTreeRefresh'
end)

-- Keymappings
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
