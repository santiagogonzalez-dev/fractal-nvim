-- Apply a skeleton(template) to new files from users templates

local M = {}

---@return string
function M.return_read_command()
  return table.concat {
    'silent!',
    '0r',
    vim.fn.stdpath('config'),
    '/lua/user/skeleton/skeleton',
    vim.fn.expand('%f'):match('^.+(%..+)$'),
  }
end

vim.api.nvim_create_autocmd('BufNewFile', {
  callback = function()
    vim.cmd(M.return_read_command())
  end,
})

return M
