local M = {}
local utils = require('csj.utils')

-- TODO(santigo-zero): FIXME before using
-- Maybe use output from `:buffers` to populate quickfix list

-- setqflist(map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), '{"bufnr": v:val}'))
-- [{'bufnr': 1}, {'bufnr': 2}]
-- echo filter(range(1, bufnr('$')), 'buflisted(v:val)')

M.buffers = {}

M.default_conf = {
   buffer_next = '<A-]>',
   buffer_prev = '<A-[>',
   buffer_recent = '<A-Tab>',
}

function M.buffer_next() return false end

function M.buffer_prev() return false end

-- Check that the buffer is valid before commiting it to the M.buffer table
---@param bufnr string
---return unknown
function M.validate_buffer(bufnr)
   local buf = {
      id = bufnr,
      name = vim.api.nvim_buf_get_name(bufnr),
      ft = vim.bo.filetype,
   }

   -- Clean the table if the buffer doesn't have a name or it's being detected
   -- that the filetype of it is not valid.
   -- if buf.name == '' or utils.present_in_table(utils.AVOID_FILETYPES, buf.ft) then
   if buf.name == '' or utils.avoid_filetype() then
      -- M.buffers[bufnr] = nil
      -- table.insert(M.buffers, buf)
      return false
   else
      -- if M.buffers[bufnr] == nil then
      -- M.buffers[bufnr] = buf
      table.insert(M.buffers, buf)
      -- end
   end

   -- return M.buffers[bufnr]
end

function M.setup(user_table_mappings)
   if type(user_table_mappings) ~= 'table' then
      vim.notify('Error loading buffer-switch module')
      return false
   end

   local mappings =
      vim.tbl_deep_extend('keep', user_table_mappings, M.default_conf)
   vim.keymap.set('n', mappings.buffer_next, M.buffer_next)
   vim.keymap.set('n', mappings.buffer_prev, M.buffer_prev)
   return true
end

-- If the user calls the module `"buffer-switch": true,` we'll use the defaults
-- In the other hand if the user passes a table the setup will be called
-- directoly by the loader in `core`
M.setup(M.default_conf)

-- Validate opened buffers at startup
vim.api.nvim_create_autocmd('UIEnter', {
   desc = 'Validate opened buffers at startup',
   callback = function()
      local first_buffers = vim.api.nvim_list_bufs()
      for bufnr, _ in pairs(first_buffers) do
         M.validate_buffer(bufnr)
      end

      -- Check each buffer that the user opens
      vim.api.nvim_create_autocmd('BufWinEnter', {
         callback = function() M.validate_buffer(vim.api.nvim_get_current_buf()) end,
      })
   end,
})

-- local M = {}

-- M.toggle_qf = function()
--   local qf_exists = false
--   for _, win in pairs(vim.fn.getwininfo()) do
--     if win["quickfix"] == 1 then
--       qf_exists = true
--     end
--   end
--   if qf_exists == true then
--     vim.cmd "cclose"
--     return
--   end
--   if not vim.tbl_isempty(vim.fn.getqflist()) then
--     vim.cmd "copen"
--   end
-- end

-- return M

return M
