vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])
vim.o.shadafile = 'NONE'

vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_man = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spec = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_perl_provider = 1
vim.g.loaded_python_provider = 1
vim.g.loaded_ruby_provider = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

require('csj.settings')
require('csj.keymaps')
require('csj.plugins')
require('csj.autocmd')
require('csj.functions')
require('csj.colorscheme')
require('csj.configs.cmp')
require('csj.lsp')

vim.defer_fn(function()
    vim.o.shadafile = ''
    vim.cmd([[
        rshada!
        doautocmd BufRead
        syntax on
        filetype on
        filetype plugin indent on
        doautocmd VimEnter
        silent! bufdo e
    ]])
end, 0)
