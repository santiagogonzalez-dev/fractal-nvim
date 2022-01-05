vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])
vim.o.shadafile = 'NONE'

-- Disable default plugins
vim.g.loaded_2html_plugin = false
vim.g.loaded_getscript = false
vim.g.loaded_getscriptPlugin = false
vim.g.loaded_gzip = false
vim.g.loaded_logipat = false
vim.g.loaded_man = false
vim.g.loaded_remote_plugins = false
vim.g.loaded_rrhelper = false
vim.g.loaded_shada_plugin = false
vim.g.loaded_spec = false
vim.g.loaded_tar = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_tutor_mode_plugin = false
vim.g.loaded_vimball = false
vim.g.loaded_vimballPlugin = false
vim.g.loaded_zip = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_perl_provider = false
vim.g.loaded_python_provider = false
vim.g.loaded_ruby_provider = false
vim.g.loaded_netrw = false
vim.g.loaded_netrwFileHandlers = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_netrwSettings = false

-- Enable opt-in plugins
vim.g.do_filetype_lua = true -- Enable filetype detection in lua

require('csj.settings')
require('csj.keymaps')
require('csj.plugins')
require('csj.autocmd')
require('csj.functions')
require('csj.configs.cmp')
require('csj.lsp')
require('csj.colors')

vim.defer_fn(function()
    vim.o.shadafile = ''
    vim.cmd([[
        rshada!
        doautocmd BufRead
        filetype on
        filetype plugin indent on
        doautocmd VimEnter
        silent! bufdo e
        syntax on
    ]])
end, 0)
