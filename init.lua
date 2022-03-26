pcall(require, 'impatient') -- Load impatient.nvim
vim.g.did_load_filetypes = 0 -- Disable filetype.vim
vim.cmd([[
  syntax off
  filetype off
  filetype plugin indent off
]])
vim.g.do_filetype_lua = 1 -- Enable filetype.lua
vim.opt.shadafile = 'NONE'

-- Disable builtin plugins

vim.g.perl_provider = 0
-- vim.g.loaded_ruby_provider = 0
-- vim.g.python_provider = 0
-- vim.g.node_provider = 0

local plugins_list = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'man',
  'matchit',
  'matchparen',
  'netrw',
  'netrwFileHandlers',
  'netrwPlugin',
  'netrwSettings',
  'remote_plugins',
  'rrhelper',
  'spec',
  'tar',
  'tarPlugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for plugin in pairs(plugins_list) do
  vim.g['loaded_' .. plugin] = 1
end

pcall(require, 'csj.core.colors') -- Load colors
require('csj.core.autocmd') -- Autocommands

-- Async load
local async_load
async_load = vim.loop.new_async(vim.schedule_wrap(function()
  pcall(require, 'csj.plugins.packer_compiled') -- Compiled file for packer
  require('csj.core') -- Settings
  require('csj.plugins') -- Plugins
  require('csj.plugins.cmp') -- CMP
  require('csj.lsp') -- Language Server Protocol

  vim.opt.shadafile = ''
  vim.cmd([[
    rshada!
    filetype on
    filetype plugin indent on
    syntax on
    PackerLoad nvim-treesitter
  ]])
  async_load:close()
end))
async_load:send()

-- Deferred load
local function load_settings()
  vim.cmd([[
    PackerLoad gitsigns.nvim
    PackerLoad vim-hexokinase
    PackerLoad indent-blankline.nvim
    PackerLoad project.nvim
    PackerLoad telescope.nvim
  ]])
  _G.all_buffers_settings()
end

vim.api.nvim_create_autocmd('UIEnter', {
  group = '_first_load',
  once = true,
  callback = function()
    return vim.defer_fn(load_settings, 60)
  end,
})
