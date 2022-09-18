local utils = {}

-- Protected require, notifies if there's an error loading a module
---@return boolean|string|number @ Either nil or the value of require()
utils.prequire = function(package)
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
utils.set_hl = function(mode, table)
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
utils.not_interfere_on_float = function()
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
utils.wrap = function(function_pointer, ...)
   local params = { ... }

   return function()
      function_pointer(unpack(params))
   end
end

-- Simple wrapper to check if a str is empty
---@param str string
---@return string|boolean @ Either an empty string or false
utils.is_empty = function(str)
   return str == '' or str == nil
end

-- Check if the working directory is under git managment
---@return boolean
utils.is_git = function()
   local is_git = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
   if is_git:match 'true' then
      vim.cmd.doautocmd 'User IsGit'
      return true
   else
      return false
   end
end

-- Checks if an elemen `element` is present in table `T`.
---@param T table
---@param element any
---@return boolean
utils.present_in_table = function(T, element)
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

---@return boolean @ If the filetype of the buffer is in the list
--`utils.AVOID_FILETYPES` this function will return true.
utils.avoid_filetype = function()
   return utils.present_in_table(utils.AVOID_FILETYPES, vim.bo.filetype)
end

-- Highlight utils.
utils.get_fg_hl = function(hl_group)
   return vim.api.nvim_get_hl_by_name(hl_group, true).foreground
end
utils.get_bg_hl = function(hl_group)
   return vim.api.nvim_get_hl_by_name(hl_group, true).background
end

-- Get json, converts the file to lua table.
utils.get_json = function(path)
   return pcall(vim.json.decode, table.concat(vim.fn.readfile(path), '\n'))
end

-- Check if a plugin is installed.
-- utils.is_installed('opt/packer.nvim') utils.is_installed('start/packer.nvim')
---@return boolean
utils.is_installed = function(plugin_name)
   local plugin_path = string.format('%s/site/pack/packer/%s', vim.fn.stdpath 'data', plugin_name)
   -- print(plugin_path)
   return vim.fn.isdirectory(plugin_path) ~= 0
end

-- Determines the indentation of a given string.
---@param indented_string string
---@return integer
utils.string_indentation = function(indented_string)
   return #indented_string - #string.match(indented_string, '^%s*(.*)')
end

-- This function takes the value of each elements in a table and returns the
-- total sum of all this values.
---@param T table @ This list should be like { first = 1, second = 2 }
---@return integer @ And the total sum of all the elements is going to be 3
utils.sum_elements = function(T)
   local total_elements = 0

   for _, value in pairs(T) do
      total_elements = total_elements + value
   end

   return total_elements
end

-- Return true if the file is exists or is readable, else return false.
---@param filename string
---@return boolean
utils.readable = function(filename)
   if vim.fn.filereadable(filename) == 0 then -- Skeletons.
      return false
   else
      return true
   end
end

return utils
