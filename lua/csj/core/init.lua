-- Default settings.
require 'csj.core.general'
require 'csj.core.autocmds'

do
   local utils = require 'csj.utils'
   local config_path = vim.fn.stdpath 'config' -- "${XDG_CONFIG_HOME}/nvim"

   local user_settings_table = string.format('%s%s', config_path, '/user/settings.json')
   local ok, user = utils.get_json(user_settings_table) -- Get user prefs.
   if not ok then
      vim.notify 'CSJNeovim is not able to find settings.json'
   else
      local start = require 'csj.utils.start'

      start.colorscheme(user.colorscheme) -- Apply colorscheme.
      start.conditionals(user.conditionals) -- Conditionals to load plugins and modules.
      start.modules(user.modules) -- Load modules specified by the user.
      start.session(user.restore) -- Restore cursor position and view(folds, searches).
      start.opts(user.opts) -- Set global settings defined by the user.
   end

   local user_init = string.format('%s%s', config_path, '/user/init.lua')
   if not utils.readable(user_init) then
      vim.notify 'CSJNeovim is not able to find an init.lua for user'
   else
      -- Add `./user` to lua path, do this before calling user's init.lua.
      package.path = table.concat {
         package.path,
         ';',
         config_path,
         '/user/?.lua;',
         config_path,
         '/user/?/init.lua;',
      }

      dofile(user_init) -- User's init.lua.
   end
end
