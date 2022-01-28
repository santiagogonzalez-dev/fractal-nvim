vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])
vim.o.shadafile = 'NONE'

-- Disable default plugins
vim.g.loaded_2html_plugin = 0
vim.g.loaded_getscript = 0
vim.g.loaded_getscriptPlugin = 0
vim.g.loaded_gzip = 0
vim.g.loaded_logipat = 0
vim.g.loaded_man = 0
vim.g.loaded_remote_plugins = 0
vim.g.loaded_rrhelper = 0
vim.g.loaded_shada_plugin = 0
vim.g.loaded_spec = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_tutor_mode_plugin = 0
vim.g.loaded_vimball = 0
vim.g.loaded_vimballPlugin = 0
vim.g.loaded_zip = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwFileHandlers = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_netrwSettings = 0

-- Enable opt-in plugins
vim.g.do_filetype_lua = 1 -- Enable filetype detection in lua

require('packer_compiled')
require('csj.plugins')
require('csj.autocmd')
require('csj.settings')
require('csj.functions')
require('csj.colors')

vim.defer_fn(function()
    vim.o.shadafile = ''

    require('csj.configs.cmp')
    require('csj.lsp')
    require('csj.keymaps').general_keybinds()

    vim.cmd([[
        PackerLoad impatient.nvim
        rshada!
        doautocmd BufRead
        filetype on
        filetype plugin indent on
        doautocmd VimEnter
        syntax on
        silent! bufdo e
    ]])
end, 0)
