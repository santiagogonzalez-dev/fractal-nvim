local M = {}
local components = require('csj.core.utils.components')
local utils = require('csj.core.utils')

function M.get()
  return table.concat {
    -- LEFT
    '',
    -- '',
    components.line_and_column_buffer(),
    components.filewritable(),
    '%#StatusLineBlue#', -- Reset hl groups
    components.search_count(),
    '%#StatusLine#', -- Reset hl groups

    -- CENTER
    '%=',
    components.filepath(),
    '%#StatusLineBlue#',
    components.filename(),
    '%#StatusLine#', -- Reset hl groups

    -- RIGHT
    '%=',
    components.vcs(),
  }
end

_G.statusline = M
vim.opt.laststatus = 3
vim.api.nvim_create_autocmd({ 'TabEnter', 'BufEnter', 'WinEnter' }, {
  callback = function()
    vim.opt.statusline = '%{%v:lua.statusline.get()%}' -- '%!v:lua.require("csj.modules.statusline").get()'
  end,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'FileType' }, {
  pattern = utils.IGNORE_FT,
  callback = function()
    vim.opt.laststatus = 0
    vim.opt.statusline = '%#StatusLineNC#' -- Disable statusline
  end,
})

return M
