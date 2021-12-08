vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1

require'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = true,
    auto_close          = true,
    open_on_tab         = true,
    hijack_cursor       = true,
    update_cwd          = true,
    update_to_buf_dir   = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    update_focused_file = {
        enable      = true,
        update_cwd  = true,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    filters = {
        dotfiles = false,
        custom = {}
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 33,
        height = 33,
        hide_root_folder = false,
        side = 'right',
        auto_resize = false,
        mappings = {
            custom_only = false,
            list = {}
        },
        number = true,
        relativenumber = true
    },
}

require('nvim-tree.events').on_nvim_tree_ready(function()
    vim.cmd 'NvimTreeRefresh'
end)

-- Keymappings
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
