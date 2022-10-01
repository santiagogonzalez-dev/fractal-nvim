local utils = require('csj.utils')

-- Default settings.
require('csj.core.general')
require('csj.core.autocmds')

-- "${XDG_CONFIG_HOME}/nvim" basically where this repo is going to be cloned.
local CONF = vim.fn.stdpath('config')
local settings = string.format('%s%s', CONF, '/user/settings.json')
local user_init = string.format('%s%s', CONF, '/user/init.lua')

utils.eval(
   utils.readable(settings),
   'CSJNeovim is not able to locate `settings.json`.',
   function()
      local ok, USER = pcall(utils.get_json, settings) -- Get user settings.
      if not ok then
         return false
      else
         local start = require('csj.utils.start')

         start.colorscheme(USER.colorscheme) -- Apply colorscheme.
         start.conditionals(USER.conditionals) -- Conditions for requiring.
         start.modules(USER.modules) -- Load modules specified by the user.
         start.session(USER.restore) -- Restore position, folds and searches.
         start.opts(USER.opts) -- Set global settings defined by the user.
      end
      return true
   end
)

utils.eval(
   utils.readable(user_init),
   'CSJNeovim is not able to find an `init.lua` for user.',
   function()
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
      return true
   end
)
