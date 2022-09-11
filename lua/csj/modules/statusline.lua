local M = {}
local components = require 'csj.utils.components'

-- TODO(santigo-zero): Generate hl groups
-- do
--    local ns = vim.api.nvim_create_namespace 'namespace_name'
--    vim.api.nvim_set_hl(ns, 'Normal', { link = '#000000' })
--    vim.api.nvim_win_set_hl_ns(0, ns)
-- end

function M.get()
   return table.concat {
      -- LEFT
      ' ',
      -- '',
      components.line_and_column_buffer(),
      components.filewritable(),
      '%#StatusLineBlue#', -- Reset hl groups
      ' ',
      components.search_count(),
      '%#StatusLine#', -- Reset hl groups

      -- CENTER
      '%=',
      components.filepath(),
      '%#StatusLineBlue#',
      components.filename(),
      -- components.filename_icon(),
      '%#StatusLine#', -- Reset hl groups

      -- RIGHT
      '%=',
      '%#StatusLineBlue#',
      components.modified_buffer(),
      '%#StatusLine#', -- Reset hl groups
      components.vcs(),
      ' ',
   }
end

vim.opt.laststatus = 3
vim.api.nvim_create_autocmd({ 'TabEnter', 'BufEnter', 'WinEnter' }, {
   callback = function()
      vim.opt.statusline = '%{%v:lua.require("csj.modules.statusline").get()%}'
   end,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'FileType' }, {
   pattern = {
      'NetrwTreeListing',
      'TelescopePrompt',
      'gitcommit',
      'gitdiff',
      'help',
      'packer',
      'startify',
      'netrw',
   },
   callback = function()
      vim.opt.statusline = '%#StatusLineNC#' -- Disable statusline
   end,
})

return M
