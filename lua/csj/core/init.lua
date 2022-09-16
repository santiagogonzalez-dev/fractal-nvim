-- Default settings.
require 'csj.core.general'
require 'csj.core.autocmds'

do
   local utils = require 'csj.utils'
   local notify_on_error = require('csj.modules.notifications').notify_send
   local config_path = vim.fn.stdpath 'config' -- "${XDG_CONFIG_HOME}/nvim"

   local user_settings_table = string.format('%s%s', config_path, '/user/settings.json')
   if not utils.readable(user_settings_table) then
      notify_on_error 'CSJNeovim is not able to locate `settings.json`.'
   else
      local ok, user = utils.get_json(user_settings_table) -- Get user prefs.
      if not ok then
         notify_on_error 'CSJNeovim is not able to read `settings.json` properly.'
      else
         local start = require 'csj.utils.start'

         start.colorscheme(user.colorscheme) -- Apply colorscheme.
         start.conditionals(user.conditionals) -- Conditions for requiring.
         start.modules(user.modules) -- Load modules specified by the user.
         start.session(user.restore) -- Restore position, folds and searches.
         start.opts(user.opts) -- Set global settings defined by the user.
      end
   end

   local user_init = string.format('%s%s', config_path, '/user/init.lua')
   if not utils.readable(user_init) then
      notify_on_error 'CSJNeovim is not able to find an `init.lua` for user.'
   else
      -- Add `./user` to lua path, do this before calling user's `init.lua`.
      package.path = table.concat {
         package.path,
         ';',
         config_path,
         '/user/?.lua;',
         config_path,
         '/user/?/init.lua;',
      }

      dofile(user_init) -- User's `init.lua`.
   end
end
