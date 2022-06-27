local M = {}
local utils = require('csj.utils')

function M.init()
   -- TODO(santigo-zero): The . mark isn't going to be set on a buffer we have never entered, so don't set the extmark
   -- Other ideas -> use virtualtext, like a ticket '.    笠  mark
   local dot_mark = vim.api.nvim_create_namespace('dot_mark_ns')
   function M.show_dot_mark_on_gutter()
      local mark = vim.api.nvim_buf_get_mark(0, '.') -- Get the position of the . mark
      if mark[1] == 0 and mark[2] == 0 then
         return
      end

      local get_hl = vim.api.nvim_get_hl_by_name
      utils.set_hl('ShowDotMarkOnGutter', { fg = get_hl('CursorLineNr', true).foreground, bg = get_hl('Normal', true).background })
      vim.g.dot_mark = vim.api.nvim_buf_set_extmark(0, dot_mark, mark[1] - 1, 0, { sign_text = '', sign_hl_group = 'ShowDotMarkOnGutter' })
      return vim.g.dot_mark
   end

   function M.remove_dot()
      if vim.g.dot_mark then
         return pcall(vim.api.nvim_buf_del_extmark, 0, dot_mark, vim.g.dot_mark)
      end
   end

   local dot_mark_group = vim.api.nvim_create_augroup('dot_mark_group', {})
   vim.api.nvim_create_autocmd('InsertLeave', {
      group = dot_mark_group,
      callback = function()
         M.remove_dot()
         return M.show_dot_mark_on_gutter()
      end,
   })

   vim.api.nvim_create_autocmd('InsertEnter', {
      group = dot_mark_group,
      callback = function()
         return M.remove_dot()
      end,
   })

   vim.api.nvim_create_autocmd('CursorHold', {
      group = dot_mark_group,
      once = true,
      callback = function()
         M.remove_dot()
         return M.show_dot_mark_on_gutter()
      end,
   })

   vim.api.nvim_create_autocmd('BufModifiedSet', {
      group = dot_mark_group,
      callback = function()
         -- We check the mode because BufModifiedSet gets triggered on insert and we don't want that
         if vim.api.nvim_get_mode().mode == 'n' then
            M.remove_dot()
            return M.show_dot_mark_on_gutter()
         end
      end,
   })
end

return M
