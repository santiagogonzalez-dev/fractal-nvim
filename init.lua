local utils = require('csj.utils')

pcall(require, 'impatient')

vim.opt.shadafile = 'NONE'
vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])

require('csj.disabled')
require('csj.autocommands')
require('csj.keymaps')
require('csj.netrw')
utils.setup_session() -- Setup the session and load other settings

vim.defer_fn(function()
    if not vim.opt.loadplugins then
        vim.cmd([[
            runtime! plugin/**/*.vim
            runtime! plugin/**/*.lua
        ]])
    end

    vim.opt.shadafile = ''
    vim.cmd([[
        rshada!
        doautocmd BufEnter
        syntax on
        filetype on
        filetype plugin indent on
    ]])

    require('csj.colors')

    local ok_plugins, _ = pcall(require, 'csj.plugins')
    if ok_plugins then
        require('csj.plugins.packer_compiled')
        for _, plugin in ipairs {
            'nvim-treesitter',
            'project.nvim',
            'telescope.nvim',
            'indent-blankline.nvim',
            'nvim-lspconfig',
            'nvim-cmp',
        } do
            vim.cmd('PackerLoad ' .. plugin)
        end
    end

    utils.is_git()
    require('csj.core')
    require('csj.filetype')
end, 3)
