local utils = require('fractal.utils')
local check, get_json, readable = utils.check, utils.get_json, utils.readable
local ROOT = vim.fn.stdpath('config') -- "${XDG_CONFIG_HOME}/nvim"
local fract = require('fractal.core.configuration')
local user_init = string.format('%s%s', ROOT, '/user/init.lua')

-- Basic settings.
require('fractal.core.general')
require('fractal.core.general.autocmds')

check({
   eval = get_json(string.format('%s%s', ROOT, '/user/settings.json')),
   on_fail_msg = 'Not able to locate `settings.json`.',
   callback = function(CFG)
      fract.colorscheme(CFG.colorscheme) -- Apply colorscheme.
      fract.conditionals(CFG.conditionals) -- Conditions for requiring.
      fract.modules(CFG.modules) -- Load modules specified by the user.
      fract.session(CFG.restore) -- Restore position, folds and searches.
      fract.opts(CFG.opts) -- Set global settings defined by the user.
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

check({
   eval = readable(user_init),
   on_fail_msg = 'Not able to find an `init.lua` for user.',
   callback = dofile(user_init),
})
