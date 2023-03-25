local M = {
   -- DESCRIPTION: This module dictates how the statusline is going to behave,
   -- if you set it up with `hide-completely` you'll not see it, `basic` gives
   -- you a basic statusline.
}

local data = require 'fractal.utils.data'

-- TODO(santigo-zero): Generate hl groups
-- do
--    local ns = vim.api.nvim_create_namespace 'namespace_name'
--    vim.api.nvim_set_hl(ns, 'Normal', { link = '#000000' })
--    vim.api.nvim_win_set_hl_ns(0, ns)
-- end

function M.get()
   return table.concat({
      data.position_with_icons(),
      data.buffer_status(),
      '%=',
      data.current_keys(),
      '%#StatusLineBlue#', -- Reset hl groups
      ' ',
      -- data.search_count(),
      '%#StatusLine#', -- Reset hl groups
      '%=',
      -- data.filepath(),
      '%#StatusLineBlue#',
      data.filename(),
      '%#StatusLine#', -- Reset hl groups
      '%=',
      '%#StatusLineBlue#',
      data.modified_buffer(),
      '%#StatusLine#', -- Reset hl groups
      data.vcs(),
   })
end

function M.hide_completely()
   local expr = vim.api.nvim_win_get_width(0)
   local sign = vim.opt.fillchars:get().horiz or '─'
   return vim.fn['repeat'](expr, sign)
end

function M.setup(mode)
   vim.opt.cmdheight = 0
   if mode == 'hide-completely' then
      -- vim.api.nvim_set_hl(0, 'StatusLine', { link = 'Normal' })
      -- vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'Normal' })
      vim.opt.statusline =
         '%{%v:lua.require("fractal.modules.status").hide_completely()%}'
      vim.opt.laststatus = 0
      vim.opt.ruler = false
      vim.api.nvim_set_hl(0, 'EndOfBuffer', { link = 'Normal' })
   elseif mode == 'basic' then
      vim.opt.laststatus = 3
      vim.opt.statusline = '%{%v:lua.require("fractal.modules.status").get()%}'
      vim.api.nvim_create_autocmd({
         'TabEnter',
         'BufEnter',
         'WinEnter',
      }, {
         callback = function()
            vim.opt.statusline =
               '%{%v:lua.require("fractal.modules.status").get()%}'
         end,
      })

      vim.api.nvim_create_autocmd({
         'WinEnter',
         'FileType',
      }, {
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
