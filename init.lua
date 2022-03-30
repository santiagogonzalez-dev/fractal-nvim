pcall(require, 'impatient')
vim.opt.shadafile = 'NONE'
vim.cmd([[
  syntax off
  filetype off
  filetype plugin indent off
]])

-- Async execution
local async_load
async_load = vim.loop.new_async(vim.schedule_wrap(function()
  -- Disable builtins
  vim.g.loaded_2html_plugin    = 0
  vim.g.loaded_getscript       = 0
  vim.g.loaded_getscriptPlugin = 0
  vim.g.loaded_gzip            = 0
  vim.g.loaded_logipat         = 0
  vim.g.loaded_man             = 0
  vim.g.loaded_matchit         = 0
  vim.g.loaded_matchparen      = 0
  vim.g.loaded_perl_provider   = 0
  vim.g.loaded_rrhelper        = 0
  vim.g.loaded_spec            = 0
  vim.g.loaded_tar             = 0
  vim.g.loaded_tarPlugin       = 0
  vim.g.loaded_vimball         = 0
  vim.g.loaded_vimballPlugin   = 0
  vim.g.loaded_zip             = 0
  vim.g.loaded_zipPlugin       = 0
  vim.g.did_load_filetypes     = 0 -- Disable filetype.vim
  vim.g.do_filetype_lua        = 1 -- Enable filetype.lua

  -- Plugins
  do
    local ok, _ = pcall(require, 'csj.plugins')
    local ok_comp, _ = pcall(require, 'csj.plugins.packer_compiled')
    if not ok and not ok_comp then
      vim.notify('Check plugins settings', vim.log.levels.WARN)
    end
  end

  require('csj.core')
  require('csj.colors')

  vim.cmd([[
    filetype on
    filetype plugin indent on
    syntax on
    PackerLoad nvim-treesitter
    PackerLoad gitsigns.nvim
    PackerLoad project.nvim
    PackerLoad vim-hexokinase
    PackerLoad indent-blankline.nvim
    PackerLoad telescope.nvim
    PackerLoad nvim-lspconfig
    PackerLoad nvim-cmp
  ]])

  return async_load:close()
end))
async_load:send()

require('csj.core.autocmd')
require('csj.core.utils').restore_sessions()

-- Deferred load
local function load_settings()
  vim.api.nvim_create_autocmd('BufWinEnter', {
    group = '_save_sessions',
    desc = 'Persistent configs for all buffers',
    callback = function()
      _G.all_buffers_settings()
    end,
  })
  require('virt-column') -- Moded version of Lukas Reineke's virt-column.nvim
  _G.all_buffers_settings()
end

vim.api.nvim_create_autocmd('UIEnter', {
  group = '_first_load',
  once = true,
  callback = function()
    return vim.defer_fn(load_settings, 60)
  end,
})
