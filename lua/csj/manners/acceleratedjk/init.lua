local M = {}

local driver = nil
local conf_module = require('csj.manners.acceleratedjk.config')

local create_driver = function(config)
   return require('csj.manners.acceleratedjk.time_driven'):new(config)
end

M.reset_key_count = function()
   driver:reset_key_count()
end

M.move_to = function(movement)
   driver:move_to(movement)
end

M.init = function(opts)
   local config = conf_module.merge_config(opts)
   driver = create_driver(config)

   vim.keymap.set('n', 'j', function()
      return require('csj.manners.acceleratedjk').move_to('gj')
   end)

   vim.keymap.set('n', 'k', function()
      return require('csj.manners.acceleratedjk').move_to('gk')
   end)
end

return M
