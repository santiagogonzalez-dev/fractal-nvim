pcall(require, 'impatient')
vim.opt.shadafile = 'NONE'

-- Async execution
local async_load
async_load = vim.loop.new_async(vim.schedule_wrap(function()
  -- Plugins
  local ok, _ = pcall(require, 'csj.plugins')
  if ok then
    require('csj.plugins.packer_compiled')
  end

  vim.cmd([[
    PackerLoad nvim-treesitter
    PackerLoad gitsigns.nvim
    PackerLoad project.nvim
    PackerLoad vim-hexokinase
    PackerLoad telescope.nvim
    PackerLoad nvim-lspconfig
    PackerLoad nvim-cmp
  ]])

  return async_load:close()
end))
async_load:send()

-- Core
require('csj.core')
