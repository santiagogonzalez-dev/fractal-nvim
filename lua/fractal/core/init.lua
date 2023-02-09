local ROOT = vim.fn.stdpath "config" -- "${XDG_CONFIG_HOME}/nvim"

require "fractal.core.general"

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
dofile(user_init)

pcall(require, 'impatient')

local settings = string.format("%s%s", ROOT, "/user/fractal.json")
require("fractal.core.configuration").setup(settings)
