local utils = {}

-- Protected require, notifies if there's an error loading a module
---@return boolean|string|number @ Either nil or the value of require()
function utils.prequire(package)
  local status, lib = pcall(require, package)
  if status then
    return lib
  else
    vim.schedule(function()
      -- If you don't schedule this and you are using the notifications module
      -- the errors will still showup on the terminal
      vim.notify('Failed to require "' .. package .. '" from ' .. vim.log.levels.WARN)
      -- vim.notify('Failed to require "' .. package .. '" from ' .. debug.getinfo(2).source)
      -- This ^^ one will print the error in the terminal even when using the
      -- notification module
    end)
    return false
  end
end

-- Wrapper for setting highlights groups
---@param mode string|table
---@param table table
---@return nil
function utils.set_hl(mode, table)
  -- Highlights
  if type(mode) == 'table' then
    for _, groups in pairs(mode) do
      vim.api.nvim_set_hl(0, groups, table)
    end
  else
    vim.api.nvim_set_hl(0, mode, table)
  end
end

---@return boolean
function utils.not_interfere_on_float()
  -- Do not open floating windows if there's already one open
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      vim.notify('There is a floating window open already', vim.log.levels.WARN)
      return false
    end
  end

  return true
end

-- Wrapper for functions, it works like pcall
-- Varargs can't be used as an upvalue, so store them
-- in this table first.
---@param function_pointer function
---@param ... any
function utils.wrap(function_pointer, ...)
  local params = { ... }

  return function()
    function_pointer(unpack(params))
  end
end

---@param str string
---@return string|boolean @ Either an empty string or false
function utils.is_empty(str)
  return str == '' or str == nil
end

-- Check if the working directory is under git managment
---@return boolean
function utils.is_git()
  local is_git = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
  if is_git:match('true') then
    vim.cmd.doautocmd('User IsGit') -- vim.cmd.doautocmd { args = { 'User', 'IsGit' } }
    -- vim.cmd('doautocmd User IsGit')
    return true
  else
    return false
  end
end

-- Filetypes to ignore
---@return table
utils.IGNORE_FT = {
  'NetrwTreeListing',
  'TelescopePrompt',
  'gitcommit',
  'gitdiff',
  'help',
  'netrw',
  'packer',
  'startify',
}

-- If there's a filetype that I want to ignore return true, so you can do
-- something like:
-- if utils.avoid_filetype() then
--   return
-- end
---@return boolean @ Return false if the filetype of the buffer is matching the
---table utils.IGNORE_FT
function utils.avoid_filetype()
  if vim.tbl_contains(utils.IGNORE_FT, vim.bo.filetype) then
    return true
  else
    return false
  end
end

function utils.get_fg_hl(hl_group)
  return vim.api.nvim_get_hl_by_name(hl_group, true).foreground
end
function utils.get_bg_hl(hl_group)
  return vim.api.nvim_get_hl_by_name(hl_group, true).background
end

return utils
