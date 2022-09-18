local M = {}
local data = require 'csj.utils.data'

-- TODO(santigo-zero): Generate hl groups
-- do
--    local ns = vim.api.nvim_create_namespace 'namespace_name'
--    vim.api.nvim_set_hl(ns, 'Normal', { link = '#000000' })
--    vim.api.nvim_win_set_hl_ns(0, ns)
-- end

M.get = function()
   return table.concat {
      -- LEFT
      ' ',
      data.line_and_column_buffer(),
      data.filewritable(),
      '%=',
      data.current_keys(true),
      '%#StatusLineBlue#', -- Reset hl groups
      ' ',
      data.search_count(),
      '%#StatusLine#', -- Reset hl groups

      -- CENTER
      '%=',
      data.filepath(),
      '%#StatusLineBlue#',
      data.filename(),
      '%#StatusLine#', -- Reset hl groups

      -- RIGHT
      '%=',
      '%#StatusLineBlue#',
      data.modified_buffer(),
      '%#StatusLine#', -- Reset hl groups
      data.vcs(),
      ' ',
   }
end

M.hide_completely = function()
   local expr = vim.api.nvim_win_get_width(0)
   local sign = vim.opt.fillchars:get().horiz
   return vim.fn['repeat'](expr, sign)
end

function M.setup(mode)
   vim.opt.cmdheight = 0
   if mode == 'hide-completely' then
      vim.opt.laststatus = 0
      vim.opt.ruler = false
      vim.api.nvim_set_hl(0, 'StatusLine', { link = 'Normal' })
      -- vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'Normal' })
      vim.opt.statusline =
         '%{%v:lua.require("csj.modules.status").hide_completely()%}'
   elseif mode == 'basic' then
      vim.opt.laststatus = 3
      vim.api.nvim_create_autocmd({ 'TabEnter', 'BufEnter', 'WinEnter' }, {
         callback = function()
            vim.opt.statusline =
               '%{%v:lua.require("csj.modules.status").get()%}'
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
   end
end

return M
