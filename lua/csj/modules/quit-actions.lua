local M = {}

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
   if M.amount_of_buffers_by_buftype().normal <= 1 then
      vim.ui.select({ 'Close buffer', 'Quit neovim' }, {
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
   else
      return vim.cmd 'bp | sp | bn | bd'
   end
end

function M.setup(mapping)
   if type(mapping) ~= 'string' then
      return false
   end

   vim.schedule(function()
      vim.keymap.set('n', mapping, require('csj.modules.quit-actions').actions, { desc = 'Actions when quitting' })
   end)
   return true
end

return M
