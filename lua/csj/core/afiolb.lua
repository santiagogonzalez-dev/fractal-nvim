---@param loaded_only boolean|nil
---@return table
local function count_bufs_by_type(loaded_only)
  loaded_only = (loaded_only == nil and true or loaded_only)
  local count = {
    normal = 0,
    acwrite = 0,
    help = 0,
    nofile = 0,
    nowrite = 0,
    quickfix = 0,
    terminal = 0,
    prompt = 0,
    Trouble = 0,
    NvimTree = 0,
  }
  for _, bufname in pairs(vim.api.nvim_list_bufs()) do
    if not loaded_only or vim.api.nvim_buf_is_loaded(bufname) then
      local buf_type = vim.api.nvim_buf_get_option(bufname, 'buftype')
      buf_type = buf_type ~= '' and buf_type or 'normal'
      count[buf_type] = count[buf_type] + 1
    end
  end
  return count
end

local function close_or_quit()
  if count_bufs_by_type().normal <= 1 then
    vim.ui.select({ 'Close buffer', 'Quit neovim' }, {
      prompt = 'What do you want to do?',
      format_item = function(item) return string.format('%s%s', '-> ', item) end,
    }, function(_, choice)
      if choice == 1 then
        return vim.cmd.bd()
        -- return vim.cmd('bd')
      elseif choice == 2 then
        return vim.cmd.q()
        -- return vim.cmd('q')
      end
    end)
  else
    return vim.cmd('bp | sp | bn | bd')
  end
end

vim.schedule(function()
  vim.keymap.set(
    'n',
    '<Leader>qq',
    function() return close_or_quit() end,
    { desc = 'Close the buffer without quitting neovim, or quit neovim' }
  )
end)
