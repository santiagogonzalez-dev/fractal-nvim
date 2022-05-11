pcall(require, 'impatient')

require('csj.disabled')
vim.opt.shadafile = 'NONE'
vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])

local utils = require('csj.utils')
utils.setup_session() -- Setup the session and load other settings

require('csj.autocommands')
require('csj.colors')

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
        doautocmd ColorScheme
        syntax on
        filetype on
        filetype plugin indent on
    ]])

    local ok, _ = pcall(require, 'csj.plugins')
    if ok then
        pcall(require, 'csj.plugins.packer_compiled')

        vim.cmd([[
            PackerLoad nvim-treesitter
            PackerLoad project.nvim
            PackerLoad telescope.nvim
            PackerLoad indent-blankline.nvim
        ]])
    end

    utils.is_git()
    require('csj.netrw')
    require('csj.core')
    require('csj.filetype')
    require('csj.manners')
end, 0)
