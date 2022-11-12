local utils = require "fractal.utils"
local ROOT = vim.fn.stdpath "config" -- "${XDG_CONFIG_HOME}/nvim"
local fract = require "fractal.core.configuration"

-- General settings and other global commands like map.
require "fractal.core.general"
require "fractal.core.general.autocmds"

local settings = string.format("%s%s", ROOT, "/user/fractal.json")
require("fractal.core.configuration").setup(settings)

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
fract.check({
   eval = utils.readable(user_init),
   on_fail_msg = "Not able to find an `init.lua` for user.",
   callback = dofile(user_init),
})
