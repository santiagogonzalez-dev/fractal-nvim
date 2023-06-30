vim.loader.enable()

local ROOT = vim.fn.stdpath('config') -- "${XDG_CONFIG_HOME}/nvim"
local get_json = require('fractal.utils').get_json
local setup = require('fractal.core.configuration').setup

require('fractal.core.general')
require('fractal.core.general.autocmds')

-- Include ./user files in the path
package.path = package.path
	.. ';'
	.. ROOT
	.. '/user/?.lua;'
	.. ROOT
	.. '/user/?/init.lua;'

dofile(ROOT .. '/user/init.lua') -- Require ./user/init.lua

local fractal_config = get_json(ROOT .. '/user/fractal.json')
setup(fractal_config)
