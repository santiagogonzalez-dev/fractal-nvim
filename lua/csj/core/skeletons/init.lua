-- Apply a skeleton(template) to new files from users templates:
-- If this module is being loaded, which is based on the table in
-- `./user/init.lua` it will read the skeleton(template) from the directory
-- `./user/skeleton` so drop all your templates in there with the correct
-- extension

local M = {}

---@return string
function M.return_read_command()
  return table.concat {
    'silent!',
    '0r',
    vim.fn.stdpath('config'),
    '/user/skeleton/skeleton',
    vim.fn.expand('%f'):match('^.+(%..+)$'),
  }
end

vim.api.nvim_create_autocmd('BufNewFile', {
  callback = function() vim.cmd(M.return_read_command()) end,
})

return M
