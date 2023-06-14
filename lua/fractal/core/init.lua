vim.loader.enable()

local ROOT = vim.fn.stdpath 'config' -- "${XDG_CONFIG_HOME}/nvim"
local get_json = require('fractal.utils').get_json

require 'fractal.core.general'
require 'fractal.core.general.autocmds'

package.path = package.path
   .. ';'
   .. ROOT
   .. '/user/?.lua;'
   .. ROOT
   .. '/user/?/init.lua;'

dofile(ROOT .. '/user/init.lua')

local fractal_config = get_json(ROOT .. '/user/fractal.json')
require('fractal.core.configuration').setup(fractal_config)
