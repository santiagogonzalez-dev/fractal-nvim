require("fractal.core.general")

local ROOT = vim.fn.stdpath("config") -- "${XDG_CONFIG_HOME}/nvim"
local get_json = require("fractal.utils").get_json
local setup = require("fractal.core.configuration").setup

-- Include ./user files in the path
package.path = table.concat({
	package.path,
	";",
	ROOT,
	"/user/?.lua;",
	ROOT,
	"/user/?/init.lua;",
})

dofile(ROOT .. "/user/init.lua") -- Require ./user/init.lua

local fractal_config = get_json(ROOT .. "/user/fractal.json")
if fractal_config then setup(fractal_config) end
