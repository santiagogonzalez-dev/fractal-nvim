local csj = require('csj.core.utils')
local user = require('csj.core.userspace').load_userspace() -- Load userspace and return a table with user setings

require('csj.plugins') -- Load plugins and package manager.

csj.disable(user.disable_builtins) -- Whether or not to disable builtin plugins and providers.
csj.colorscheme(user.colorscheme) -- Apply colorscheme.
csj.settings(user.opts) -- Set some settings.
csj.session(user.restore) -- Restore cursor and view.
csj.conditionals() -- Conditionals to load plugins and modules.

require('csj.core.general') -- TODO(santigo-zero): Moved this to user config
require('csj.core.autocmds') -- Some common autocommands.

-- Load modules specified by the user
for k, v in pairs(user.modules) do
  csj.load(v, k)
end
