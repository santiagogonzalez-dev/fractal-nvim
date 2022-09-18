local M = {}
local utils = require 'csj.utils'

-- DESCRIPTION: Makes the cursor behave almost like if you were using tabs
-- instead of spaces for indentation, so the cursor jumps instead of moving
-- character by character when you move with h and l.

function M.strict_h_motion()
   local cursor_position = vim.api.nvim_win_get_cursor(0)

   --    if utils.string_indentation(vim.api.nvim_get_current_line()) >= vim.opt.tabstop:get() then
   -- 		return vim.api.nvim_feedkeys('h', 'n', 'v:false')
   --    end

   if cursor_position[2] == 0 then
      -- The reason why we feed `h` in here is because you could be using
      -- vim.opt.whichwrap with h, making the line jump to the line above
      return vim.api.nvim_feedkeys('h', 'n', 'v:true')
   elseif cursor_position[2] <= utils.string_indentation(vim.api.nvim_get_current_line()) then
      -- Each time you press h at the start (^) of the line you'll move with the
      -- tabstop value
      local status, _ =
         pcall(vim.api.nvim_win_set_cursor, 0, { cursor_position[1], cursor_position[2] - vim.bo.tabstop })
      if not status then
         -- This will trigger if the file is using tabs for indentation instead
         -- of spaces
         vim.notify('Disabling strict cursor', vim.log.levels.INFO)
         vim.g.strict_cursor = false
         M.toggle()
      end
   else
      return vim.api.nvim_feedkeys('h', 'n', 'v:true')
   end
end

function M.strict_l_motion()
   local indentation = utils.string_indentation(vim.api.nvim_get_current_line())
   local cursor_position = vim.api.nvim_win_get_cursor(0)

   if cursor_position[2] < indentation then
      -- return vim.api.nvim_win_set_cursor(0, { cursor_position[1], cursor_position[2] + vim.bo.tabstop })
      return vim.api.nvim_win_set_cursor(0, { cursor_position[1], indentation })
   else
      return vim.api.nvim_feedkeys('l', 'n', 'v:true')
   end
end

function M.toggle()
   if vim.g.strict_cursor then
      vim.keymap.set('n', 'h', M.strict_h_motion, { desc = 'Indentation with spaces behaves like tabs' })
      vim.keymap.set('n', 'l', M.strict_l_motion, { desc = 'Indentation with spaces behaves like tabs' })
      vim.g.strict_cursor = false
      -- vim.notify('Strict cursor enabled', vim.log.levels.INFO)
   else
      vim.keymap.del('n', 'h')
      vim.keymap.del('n', 'l')
      vim.g.strict_cursor = true
      -- vim.notify('Strict cursor disabled', vim.log.levels.INFO)
   end
end

vim.g.strict_cursor = true
function M.setup(disables_mode)
   if type(disables_mode) ~= 'string' then return false end

   M.toggle()
   vim.keymap.set('n', disables_mode, function() M.toggle() end)
end

return M
