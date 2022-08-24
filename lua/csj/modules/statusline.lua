local M = {}
local components = require('csj.core.utils.components').formatted
local utils = require('csj.core.utils')

function M.active()
  vim.opt.laststatus = 3

  return table.concat {
    -- LEFT
    ' ',
    -- '',
    '%#StatusLine#',
    components.line_and_column_buffer(),
    components.filewritable(),
    '%#StatusLineBlue#', -- Reset hl groups
    components.search_count(),
    '%#StatusLine#', -- Reset hl groups

    -- CENTER
    '%=',
    components.filepath(),
    '%#StatusLineAccentBlue#',
    components.filename(),
    '%#StatusLine#', -- Reset hl groups

    -- RIGHT
    '%=',
    components.vcs(),
    '%#StatusLine#', -- Reset hl groups
    ' ',
  }
end

function M.winbar_active()
  return table.concat {
    '%=',
    '%#StatusLine#', -- Winbar doesn't define a default hl
    components.filepath(),
    '%#StatusLineAccentBlue#',
    components.filename(),
    '%#StatusLine#', -- Reset hl groups
  }
end

vim.api.nvim_create_autocmd({
  'UIEnter',
  'BufEnter',
  'WinEnter',
}, {
  callback = function()
    vim.opt.statusline = '%!v:lua.require("csj.modules.statusline").active()'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = utils.IGNORE_FT,
  callback = function()
    vim.opt.statusline = '%#EndOfBuffer#' -- Change color of the statusline
  end,
})

return M
