local load = require 'csj.utils.load'
load.disable()

vim.schedule(function()
   load.enable()
   require 'csj.core'
   load.late_autocmds()
end)
