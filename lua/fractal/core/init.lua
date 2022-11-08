local utils = require "fractal.utils"
local check, get_json, readable = utils.check, utils.get_json, utils.readable
local ROOT = vim.fn.stdpath "config" -- "${XDG_CONFIG_HOME}/nvim"
local fract = require "fractal.core.configuration"

-- Basic settings.
require "fractal.core.general"
require "fractal.core.general.autocmds"

local fract_settings = string.format("%s%s", ROOT, "/user/fractal.json")
check({
   eval = get_json(fract_settings),
   on_fail_msg = "Not able to locate `fractal.json`.",
   callback = function(CFG)
      fract.colorscheme(CFG.colorscheme) -- Apply colorscheme.
      fract.conditionals(CFG.conditionals) -- Conditions for requiring.
      fract.modules(CFG.modules) -- Load modules specified by the user.
      fract.session(CFG.restore) -- Restore position, folds and searches.
   end,
})

-- Add `./user` to lua path, do this before calling user's `init.lua`.
package.path = table.concat({
   package.path,
   ";",
   ROOT,
   "/user/?.lua;",
   ROOT,
   "/user/?/init.lua;",
})

local user_init = string.format("%s%s", ROOT, "/user/init.lua")
check({
   eval = readable(user_init),
   on_fail_msg = "Not able to find an `init.lua` for user.",
   callback = dofile(user_init),
})
