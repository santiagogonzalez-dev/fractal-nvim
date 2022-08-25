-- Apply a skeleton(template) to new files from users templates
-- TODO(santigo-zero): https://github.com/glepnir/template.nvim

local M = {}

---@param extension string
---@return string @ This function returns a path
function M.find_fullpath(extension)
  return string.format('%s%s%s', vim.fn.stdpath('config'), '/lua/user/skeletons/skeleton', extension)
end

function M.define_extension()
  local buffer_extension = vim.fn.expand('%f'):match('^.+(%..+)$')

  if buffer_extension == nil then
    buffer_extension = string.format('.%s', vim.bo.filetype)
  end

  return buffer_extension
end

function M.file_exists(fullpath)
  return vim.fn.filereadable(fullpath) == 1
end
-- TODO(santigo-zero): Manage skeletons not existing, and detecting filetype
vim.api.nvim_create_autocmd('BufNewFile', {
  callback = function()
    local get_full_path = M.find_fullpath(M.define_extension())

    -- If the skeleton template exists then
    if M.file_exists(get_full_path) then
      vim.cmd('0r' .. get_full_path) -- Read the file
      vim.fn.deletebufline(vim.api.nvim_get_current_buf(), vim.fn.line('$')) -- And delete the empty line
    end
  end,
})

-- Manually check and trigger skeleton, this is done because I'm lazyloading,
-- uncomment if you are not doing any optimizations since neovim does this
-- already.
if vim.fn.filereadable(vim.fn.expand(vim.api.nvim_eval_statusline('%F', {}).str)) == 0 then
  vim.api.nvim_exec_autocmds('BufNewFile', {})
end

return M
