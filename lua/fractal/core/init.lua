local utils = require('fractal.utils')

-- Basic settings.
require('fractal.core.general')
require('fractal.core.general.autocmds')

local CONF = vim.fn.stdpath('config') -- "${XDG_CONFIG_HOME}/nvim"
local settings = string.format('%s%s', CONF, '/user/settings.json')
local user_init = string.format('%s%s', CONF, '/user/init.lua')

utils.check({
   eval = utils.readable(settings),
   on_fail_msg = 'Not able to locate `settings.json`.',
   callback = function()
      local ok, USER = pcall(utils.get_json, settings) -- Get user settings.
      if not ok then return false end

      local fctl = require('fractal.configuration')

      fctl.colorscheme(USER.colorscheme) -- Apply colorscheme.
      fctl.conditionals(USER.conditionals) -- Conditions for requiring.
      fctl.modules(USER.modules) -- Load modules specified by the user.
      fctl.session(USER.restore) -- Restore position, folds and searches.
      fctl.opts(USER.opts) -- Set global settings defined by the user.
      return true
   end,
})

utils.check({
   eval = utils.readable(user_init),
   on_fail_msg = 'Not able to find an `init.lua` for user.',
   callback = function()
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
   end,
})
