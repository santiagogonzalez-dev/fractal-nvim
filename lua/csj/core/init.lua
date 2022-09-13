-- Default settings
require 'csj.core.general'
require 'csj.core.autocmds'

do
   local utils = require 'csj.utils'
   local config_path = vim.fn.stdpath 'config' -- "${XDG_CONFIG_HOME}/nvim"
   local user_settings = string.format('%s%s', config_path, '/user/settings.json')
   if utils.readable(user_settings) then
      local user = require('csj.utils').get_json(user_settings) -- User table
      local start = require 'csj.utils.start'
      start.colorscheme(user.colorscheme) -- Apply colorscheme.
      start.conditionals(user.conditionals) -- Conditionals to load plugins and modules.
      start.modules(user.modules) -- Load modules specified by the user.
      start.session(user.restore) -- Restore cursor and view.
      start.opts(user.opts) -- Set some settings.
   else
      vim.notify 'CSJNeovim is not able to find settings.json'
   end

   local user_init = string.format('%s%s', config_path, '/user/init.lua')
   if utils.readable(user_init) then
      -- Add `./user` to lua path, do this before calling user's init.lua
      package.path = table.concat {
         package.path,
         ';',
         config_path,
         '/user/?.lua;',
         config_path,
         '/user/?/init.lua;',
      }

      dofile(user_init) -- User's init.lua
   else
      vim.notify 'CSJNeovim is not able to find an init.lua for user'
   end
end
