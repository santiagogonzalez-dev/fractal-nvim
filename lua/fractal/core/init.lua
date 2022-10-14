local utils = require('fractal.utils')
local ROOT = vim.fn.stdpath('config') -- "${XDG_CONFIG_HOME}/nvim"
local fctl = require('fractal.configuration')
local user_init = string.format('%s%s', ROOT, '/user/init.lua')

-- Basic settings.
require('fractal.core.general')
require('fractal.core.general.autocmds')

utils.check({
   eval = utils.get_json(string.format('%s%s', ROOT, '/user/settings.json')),
   on_fail_msg = 'Not able to locate `settings.json`.',
   callback = function(CFG)
      fctl.colorscheme(CFG.colorscheme) -- Apply colorscheme.
      fctl.conditionals(CFG.conditionals) -- Conditions for requiring.
      fctl.modules(CFG.modules) -- Load modules specified by the user.
      fctl.session(CFG.restore) -- Restore position, folds and searches.
      fctl.opts(CFG.opts) -- Set global settings defined by the user.
   end,
})

-- Add `./user` to lua path, do this before calling user's `init.lua`.
package.path = table.concat({
   package.path,
   ';',
   ROOT,
   '/user/?.lua;',
   ROOT,
   '/user/?/init.lua;',
})

utils.check({
   eval = utils.readable(user_init),
   on_fail_msg = 'Not able to find an `init.lua` for user.',
   callback = dofile(user_init),
})
