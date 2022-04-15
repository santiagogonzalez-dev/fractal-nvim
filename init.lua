pcall(require, 'impatient')
vim.opt.shadafile = 'NONE'
vim.cmd('syntax off')

-- Async execution
local async_load
async_load = vim.loop.new_async(vim.schedule_wrap(function()
  -- Plugins
  local ok, _ = pcall(require, 'csj.plugins')
  if ok then
    require('csj.plugins.packer_compiled')
  end

  for _, plugins in ipairs {
    'nvim-treesitter',
    'gitsigns.nvim',
    'project.nvim',
    'vim-hexokinase',
    'telescope-ui-select.nvim',
    'telescope.nvim',
    'indent-blankline.nvim',
    'nvim-lspconfig',
    'nvim-cmp',
  } do
    vim.cmd('PackerLoad ' .. plugins)
  end

  return async_load:close()
end))
async_load:send()

require('csj.colors') -- Highlight groups modifications
require('csj.core') -- Core

-- Setup the session and load other settings
require('csj.core.utils').setup_session(function()
  return _G.all_buffers_settings()
end)
