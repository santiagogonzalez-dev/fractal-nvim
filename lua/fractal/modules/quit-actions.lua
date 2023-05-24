local M = {
   -- DESCRIPTION: This module provides some functions to delete buffers, when
   -- you call the setup with a key combination, like `<Leader>qq` and there's
   -- more than one normal buffer it will wipe all of them except the current
   -- buffer, if there's just one normal buffer it will ask the user for
   -- actions, like quitting neovim or just deleting the current buffer.
}
local utils = require 'fractal.utils'

M.del_normal_bufs_with_exception = function(current_buf)
   local buflist = vim.api.nvim_list_bufs()
   for _, buf in ipairs(buflist) do
      if vim.api.nvim_buf_is_valid(buf) then
         if
            buf ~= current_buf --[[ and vim.api.nvim_buf_get_option(buf, 'buflisted') ]]
         then
            vim.api.nvim_buf_delete(buf, {})
         end
      end
   end
end

-- Return the amount of buffers discriminated by buftype
---@return table
function M.amount_of_buffers_by_buftype()
   local count = {
      NvimTree = 0,
      acwrite = 0,
      help = 0,
      nofile = 0,
      normal = 0,
      nowrite = 0,
      prompt = 0,
      quickfix = 0,
      terminal = 0,
   }

   -- This for loops gets the list of buffers by id and loops through the list.
   for _, bufname in pairs(vim.api.nvim_list_bufs()) do
      -- Then checks if the buffer `bufname` is load.
      if vim.api.nvim_buf_is_loaded(bufname) then
         -- If it is then we get the buftype of the buffer
         local buf_type = vim.api.nvim_buf_get_option(bufname, 'buftype')

         -- The `buftype` of a normal buffer is '', so if `buf_type` is empty it
         -- means it's a `normal` buffer, else we keep whatever the type of the
         -- buffer is.
         buf_type = (buf_type ~= '' and buf_type or 'normal')

         -- And we up +1 that element on the list, this way we can know how many
         -- buffers of the same type there are loaded.
         count[buf_type] = count[buf_type] + 1
      end
   end

   return count
end

function M.actions()
   local bufs = M.amount_of_buffers_by_buftype()
   bufs['nofile'] = bufs['nofile'] - bufs['nofile'] -- Ignore nofile buffers

   if utils.sum_elements(bufs) > 1 then
      -- If there's more than 1 buffer(excluding `nofile` buffers) quit all of
      -- them but keep the current one.
      M.del_normal_bufs_with_exception(vim.api.nvim_get_current_buf())
   else
      -- If there's only one buffer ask the user to delete it and get an empty
      -- buffer or quit neovim altogether.
      vim.ui.select({ 'Close the current and only buffer', 'Quit neovim' }, {
         prompt = 'What do you want to do?',
         format_item = function(item)
            return string.format('%s%s', '-> ', item)
         end,
      }, function(_, choice)
         if choice == 1 then
            return vim.cmd.bd()
         elseif choice == 2 then
            return vim.cmd.q()
         end
      end)
   end
end

---@param mapping string
---@return boolean
function M.setup(mapping)
   if type(mapping) ~= 'string' then
      return false
   end

   vim.schedule(function()
      vim.keymap.set('n', mapping, M.actions, {
         desc = [[Mapping associated with CSJNeovim module: quit-actions.
                 Check the module at fractal.modules.quit-actions
                 for an in-depth description of the module.]],
      })
   end)
   return true
end

return M
