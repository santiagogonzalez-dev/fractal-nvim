-- Default settings.
require('csj.core.general')
require('csj.core.autocmds')

do
   local utils = require('csj.utils')
   local desktop_notify = require('csj.modules.notifications').notify_send

   -- "${XDG_CONFIG_HOME}/nvim" basically where this repo is going to be cloned.
   local CONF = vim.fn.stdpath('config')

   local settings = string.format('%s%s', CONF, '/user/settings.json')
   if not utils.readable(settings) then
      desktop_notify('CSJNeovim is not able to locate `settings.json`.')
   else
      local ok, USER = pcall(utils.get_json, settings) -- Get user settings.
      if not ok then
         desktop_notify('CSJNeovim is not able to read `settings.json` properly.')
      else
         local start = require('csj.utils.start')

         start.colorscheme(USER.colorscheme) -- Apply colorscheme.
         start.conditionals(USER.conditionals) -- Conditions for requiring.
         start.modules(USER.modules) -- Load modules specified by the user.
         start.session(USER.restore) -- Restore position, folds and searches.
         start.opts(USER.opts) -- Set global settings defined by the user.
      end
   end

   local user_init = string.format('%s%s', CONF, '/user/init.lua')
   if not utils.readable(user_init) then
      desktop_notify('CSJNeovim is not able to find an `init.lua` for user.')
   else
      -- Add `./user` to lua path, do this before calling user's `init.lua`.
      package.path = table.concat({
         package.path,
         ';',
         CONF,
         '/user/?.lua;',
         CONF,
         '/user/?/init.lua;',
      })

      dofile(user_init) -- User's `init.lua`.
   end
end
