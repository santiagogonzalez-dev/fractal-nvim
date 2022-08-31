-- Default settings
require 'csj.core.general'
require 'csj.core.autocmds'

-- Load everything related to user settings
local csjneovim = vim.fn.stdpath 'config' -- "${XDG_CONFIG_HOME}/nvim"

local user_settings = string.format('%s%s', csjneovim, '/user/settings.json')
local user = require('csj.utils').get_json(user_settings) -- User table
local start = require 'csj.utils.start'
start.colorscheme(user.colorscheme) -- Apply colorscheme.
start.conditionals(user.conditionals) -- Conditionals to load plugins and modules.
start.modules(user.modules) -- Load modules specified by the user.
start.session(user.restore) -- Restore cursor and view.
start.opts(user.opts) -- Set some settings.

-- Add `./user` to lua path, do this before calling user's init.lua
package.path = table.concat {
   package.path,
   ';',
   csjneovim,
   '/user/?.lua;',
   csjneovim,
   '/user/?/init.lua;',
}

local user_init = string.format('%s%s', csjneovim, '/user/init.lua')
dofile(user_init) -- User's init.lua
