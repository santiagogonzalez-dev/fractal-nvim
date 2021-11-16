vim.cmd([[
	syntax off
	filetype off
	filetype plugin indent off
]])

local rtp = vim.opt.runtimepath:get()
vim.opt.runtimepath = ''
vim.o.shadafile = 'NONE'

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
vim.g.loaded_zip = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_perl_provider = false
vim.g.loaded_python_provider = false
vim.g.loaded_ruby_provider = false
-- vim.g.loaded_netrw = false
-- vim.g.loaded_netrwFileHandlers = false
-- vim.g.loaded_netrwPlugin = false
-- vim.g.loaded_netrwSettings = false
-- vim.g.matchit = false
-- vim.g.matchparen = false

vim.opt.runtimepath = rtp
vim.o.shadafile = ''

vim.g.mapleader = ' '
vim.g.localleader = ' '
require('settings')
require('plugins')
require('lsp.init')

vim.defer_fn(function()
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
