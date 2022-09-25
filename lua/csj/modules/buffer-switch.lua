local M = {}
-- local utils = require('csj.utils')

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

---@param user_config table
---@return boolean
function M.setup(user_config)
   return false
   -- if type(user_config) ~= 'table' then
   --    vim.notify('The user configuration for buffer-switch is not a table')
   --    return false
   -- end

   -- local mappings = vim.tbl_deep_extend('keep', user_config, M.default_conf)
   -- vim.keymap.set('n', mappings.buffer_next, M.buffer_next)
   -- vim.keymap.set('n', mappings.buffer_prev, M.buffer_prev)
   -- return true
end

return M
