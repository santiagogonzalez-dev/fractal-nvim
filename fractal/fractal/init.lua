require("fractal.general")

local ROOT = vim.fn.stdpath("config") -- "${XDG_CONFIG_HOME}/nvim"
local get_json = require("fractal.utils").get_json
local setup = require("fractal.configuration").setup

local fractal_config = get_json(ROOT .. "/fractal.json")
if fractal_config then setup(fractal_config) end
