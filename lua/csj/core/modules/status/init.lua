local M = {}
local component = require('csj.core.modules.status.components')
local utils = require('csj.core.utils')

function M.active()
  vim.opt.laststatus = 3

  return table.concat {
    -- LEFT
    '',
    '%#Conditional#',
    component.lineinfo(),
    component.filewritable(),
    ' ', -- Icons from ^^ get cut so add a space in here
    '%#StatusLine#', -- Reset hl groups

    -- CENTER
    '%=',
    component.filepath(),
    '%#StatusLineAccentBlue#',
    component.filename(),
    '%#StatusLine#', -- Reset hl groups

    -- RIGHT
    '%=',
    component.vcs(),
    '%#StatusLine#', -- Reset hl groups
    ' ',
  }
end

function M.winbar_active()
  return table.concat {
    '%=',
    '%#StatusLine#', -- Winbar doesn't define a default hl
    component.filepath(),
    '%#StatusLineAccentBlue#',
    component.filename(),
    '%#StatusLine#', -- Reset hl groups
  }
end

vim.opt.statusline = '%!v:lua.require("csj.core.modules.status").active()'

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  callback = function()
    vim.opt.statusline = '%!v:lua.require("csj.core.modules.status").active()'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = utils.IGNORE_FT,
  callback = function()
    vim.opt.statusline = '%#EndOfBuffer#' -- Change color of the statusline
  end,
})

return M
