-- https://github.com/tamton-aquib/keys.nvim

local M = {}
-- local utils = require 'csj.utils'
local _kg_ns = vim.api.nvim_create_namespace 'keypresses_global'

M.typed_letters = {}

local spec_table = {
   [9] = ' ',
   [13] = '<CR>',
   [27] = '<ESC>',
   [32] = '␣',
   [127] = ' ',
}

local function traduce(key)
   local b = key:byte()
   for k, v in pairs(spec_table) do
      if b == k then return v end
   end
   if b <= 126 and b >= 33 then return key end
end

-- Traduce the key and insert it on the table of used keys.
---@param key_code integer|string
function M.register_keys(key_code)
   local key = traduce(key_code)

   if key then
      if #M.typed_letters >= 6 then table.remove(M.typed_letters, 1) end

      table.insert(M.typed_letters, key)
   end
end

function M.start_registering()
   vim.on_key(function(key_code) M.register_keys(key_code) end, _kg_ns)
end
M.start_registering()

return M
