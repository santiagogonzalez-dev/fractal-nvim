vim.loader.enable()

local ROOT = vim.fn.stdpath 'config' -- "${XDG_CONFIG_HOME}/nvim"

require 'fractal.core.general'
require 'fractal.core.general.autocmds'

package.path = table.concat({
   package.path,
   ';',
   ROOT,
   '/user/?.lua;',
   ROOT,
   '/user/?/init.lua;',
})

local user_init = string.format('%s%s', ROOT, '/user/init.lua')
dofile(user_init)

local settings = string.format('%s%s', ROOT, '/user/fractal.json')
local config = require('fractal.utils').get_json(settings)
require('fractal.core.configuration').setup(config)
