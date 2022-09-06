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
         -- the errors will still show up on the terminal
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

-- Simple wrapper to check if a str is empty
---@param str string
---@return string|boolean @ Either an empty string or false
function utils.is_empty(str)
   return str == '' or str == nil
end

-- Check if the working directory is under git managment
---@return boolean
function utils.is_git()
   local is_git = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
   if is_git:match 'true' then
      vim.cmd.doautocmd 'User IsGit'
      return true
   else
      return false
   end
end

-- Checks if an `element` is present in table `T`.
---@param T table
---@param element any
---@return boolean
function utils.present_in_table(T, element)
   if T[element] ~= nil then
      return true
   else
      return false
   end
end

-- If there's a filetype that you want to ignore put it in this table and call
-- the function `utils.avoid_filetype()`, returns true if the filetype of the
-- buffer is undesirable.
utils.AVOID_FILETYPES = {
   NetrwTreeListing = true,
   TelescopePrompt = true,
   gitcommit = true,
   gitdiff = true,
   help = true,
   packer = true,
   startify = true,
   qf = true,
   quickfix = true,
}

---@return boolean @ Fail if the ft is matching the table utils.AVOID_FILETYPES
function utils.avoid_filetype()
   return utils.present_in_table(utils.AVOID_FILETYPES, vim.bo.filetype)
end

-- Highlight utils.
function utils.get_fg_hl(hl_group)
   return vim.api.nvim_get_hl_by_name(hl_group, true).foreground
end
function utils.get_bg_hl(hl_group)
   return vim.api.nvim_get_hl_by_name(hl_group, true).background
end

-- Get json, converts the file to lua table.
function utils.get_json(path)
   return vim.json.decode(table.concat(vim.fn.readfile(path), '\n'))
end

-- Check if a plugin is installed.
-- utils.is_installed('opt/packer.nvim') utils.is_installed('start/packer.nvim')
---@return boolean
function utils.is_installed(plugin_name)
   local plugin_path = string.format('%s/site/pack/packer/%s', vim.fn.stdpath 'data', plugin_name)
   -- print(plugin_path)
   return vim.fn.isdirectory(plugin_path) ~= 0
end

-- Determines the indentation of a given string.
---@param indented_string string
---@return integer
function utils.string_indentation(indented_string)
   return #indented_string - #string.match(indented_string, '^%s*(.*)')
end

return utils
