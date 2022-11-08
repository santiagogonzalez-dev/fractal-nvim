local utils = {}
local notify_send = require("fractal.modules.notifications").notify_send

-- Protected require, notifies if there's an error loading a module
---@return boolean|string|number @ Either nil or the value of require()
function utils.prequire(package)
   local ok, lib = pcall(require, package)
   if not ok then return false end
   return lib
end

-- Do not open floating windows if there's already one open
---@return boolean @ Returns false if there's a floating window open.
function utils.not_interfere_on_float()
   for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
         vim.notify(
            "There is a floating window open already",
            vim.log.levels.WARN
         )
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
   return str == "" or str == nil
end

-- Check if the working directory is under git managment
---@return boolean
function utils.is_git()
   local is_git =
      vim.api.nvim_exec("!git rev-parse --is-inside-work-tree", true)

   if is_git:match "true" then
      vim.cmd.doautocmd "User IsGit"
      return true
   else
      return false
   end
end

-- Checks if an element `element` is present in table `T`.
---@param T table
---@param element any
---@return boolean
function utils.present_in_table_kv(element, T)
   if T[element] ~= nil then
      return true
   else
      return false
   end
end

function utils.present_in_table(element, T)
   for _, value in pairs(T) do
      if value == element then return true end
   end
   return false
end

-- If there's a filetype that you want to ignore put it in this table and call
-- the function `utils.avoid_filetype()`, returns true if the filetype of the
-- buffer is undesirable.
utils.AVOID_FILETYPES = {
   "NetrwTreeListing",
   "TelescopePrompt",
   "gitcommit",
   "gitdiff",
   "help",
   "packer",
   "startify",
   "qf",
   "quickfix",
}

-- If the filetype of the buffer is in the list `utils.AVOID_FILETYPES` this
-- function will return true.
---@return boolean
function utils.avoid_filetype()
   return utils.present_in_table(vim.bo.filetype, utils.AVOID_FILETYPES)
end

-- Highlight utils.
-- TODO(santigo-zero): Move this to a standalone file.
function utils.get_fg_hl(hl_group)
   return vim.api.nvim_get_hl_by_name(hl_group, true).foreground
end
function utils.get_bg_hl(hl_group)
   return vim.api.nvim_get_hl_by_name(hl_group, true).background
end

-- Find and return a json in a lua table, if it doesn't find it or it's broken
-- it will return false.
---@param path string
---@return table|false
function utils.get_json(path)
   local find = utils.readable(path)
   if not find then return false end

   local ok, LIB =
      pcall(vim.json.decode, table.concat(vim.fn.readfile(path), "\n"))
   return ok and LIB or false
end

-- Check if a plugin is installed.
-- utils.is_installed('opt/packer.nvim') utils.is_installed('start/packer.nvim')
---@return boolean
function utils.is_installed(plugin_name)
   local plugin_path = string.format(
      "%s/site/pack/packer/%s",
      vim.fn.stdpath "data",
      plugin_name
   )
   -- print(plugin_path)
   return vim.fn.isdirectory(plugin_path) ~= 0
end

-- Determines the indentation of a given string.
---@param indented_string string
---@return integer
function utils.string_indentation(indented_string)
   return #indented_string - #string.match(indented_string, "^%s*(.*)")
end

-- This function takes the value of each elements in a table and returns the
-- total sum of all this values.
---@param T table @ This list should be like { first = 1, second = 2 }
---@return integer @ And the total sum of all the elements is going to be 3
function utils.sum_elements(T)
   local total_elements = 0

   for _, value in pairs(T) do
      total_elements = total_elements + value
   end

   return total_elements
end

-- Wrapper around `vim.fn.filereadable`.
---@param filename string
---@param as_string? boolean
---@return boolean|string
function utils.readable(filename, as_string)
   if not as_string then return true and vim.fn.filereadable(filename) == 1 end

   if vim.fn.filereadable(filename) == 1 then
      return "readable"
   else
      return "nonexistent or is a directory"
   end
end

-- Wrapper around `vim.fn.filewritable`.
---@param filename string
---@param as_string? boolean
---@return integer|string
function utils.writable(filename, as_string)
   local result = vim.fn.filewritable(filename)
   if not as_string then return result end

   if result == 1 then
      return "writable"
   elseif result == 2 then
      return "writable directory"
   elseif result == 0 then
      return "inexistent or is not writable"
   else
      return ""
   end
end

local timer = vim.loop.new_timer()
function utils.blink_crosshair()
   local cnt, blink_times = 0, 8
   timer:start(
      0,
      100,
      vim.schedule_wrap(function()
         vim.cmd "set cursorcolumn! cursorline!"
         cnt = cnt + 1
         if cnt == blink_times then timer:stop() end
      end)
   )
end

return utils
