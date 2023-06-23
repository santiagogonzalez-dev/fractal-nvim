local M = {}

---@param mapping string
function M.setup(mapping)
   if type(mapping) ~= 'string' then return end

   vim.keymap.set('n', mapping, function()
      -- If there's only one buffer left, ask the user:
      -- 1. Keep current buffer
      -- 2. Unload all buffers
      -- 3. Quit neovim altogether
      vim.ui.select({
         'Keep current',
         'Unload all buffers',
         'Quit neovim',
      }, {
         prompt = 'Quit actions',
         format_item = function(item) return '󰒇 ' .. item end,
      }, function(choice)
         if choice == 'Keep current' then
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
               if vim.api.nvim_buf_is_valid(buf) then
                  if buf ~= vim.api.nvim_get_current_buf() then
                     vim.api.nvim_buf_delete(buf, {})
                  end
               end
            end
         elseif choice == 'Unload all buffers' then
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
               vim.api.nvim_buf_delete(buf, {})
            end
         elseif choice == 'Quit neovim' then
            vim.cmd.q()
         end
      end)
   end)
end

return M
