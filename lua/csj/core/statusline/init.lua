local M = {}
local component = require('csj.core.statusline.components')
local utils = require('csj.utils')

function M.active()
  vim.opt.laststatus = 3

  return table.concat {
    '%#StatusLineAccent#',
    component.lineinfo(),
    '%#StatusLine#',
    ' ',
    component.filepath(),
    '%#StatusLineAccentBlue#',
    component.filename(),
    '%#StatusLine#',
    ' ',
    component.filewritable(),
    '%=%', -- Put component in the right side
    component.vcs(),
  }
end

function M.inactive()
  return '%#InactiveNC#'
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  callback = function()
    vim.opt.statusline = '%!v:lua.require("csj.core.statusline").active()'
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType', 'WinEnter' }, {
  pattern = utils.IGNORE_FT,
  callback = function()
    vim.opt.statusline = '%!v:lua.require("csj.core.statusline").inactive()'
  end,
})

return M
