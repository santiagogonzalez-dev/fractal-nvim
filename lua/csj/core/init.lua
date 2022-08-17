require('csj.core.general') -- General settings
require('csj.core.autocmds') -- General autocommands

do
  local userspace = require('csj.core.user')
  local user = userspace.settings('/lua/user/settings.json') -- Table with user preferences
  local start = require('csj.core.utils.startup')

  start.disable(user.disable_builtins) -- Disable builtin plugins and providers
  start.colorscheme(user.colorscheme) -- Apply colorscheme.
  start.conditionals(user.conditionals) -- Conditionals to load plugins and modules.
  start.settings(user.opts) -- Set some settings.
  start.modules_load(user.modules) -- Load modules specified by the user.
  start.session(user.restore) -- Restore cursor and view.
  require('user')
end
