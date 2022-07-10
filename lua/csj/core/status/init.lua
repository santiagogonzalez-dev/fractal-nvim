local M = {}
local component = require('csj.core.status.components')
local utils = require('csj.utils')

function M.active()
  vim.opt.laststatus = 3

  return table.concat {
    component.lineinfo(),
    '%#StatusLine#',
    ' ',
    component.filepath(),
    component.filename(),
    -- ' ',
    -- component.location_treesitter()
    ' ',
    component.filewritable(),
    '%=%', -- Put component in the right side
    component.vcs(),
  }
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  callback = function()
    vim.opt.statusline = '%!v:lua.require("csj.core.status").active()'
    -- vim.opt_local.winbar = '%!v:lua.require("csj.core.status.components").location_treesitter()'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = utils.IGNORE_FT,
  callback = function()
    vim.opt.statusline = '%#EndOfBuffer#' -- Change color of the statusline
  end,
})

return M
