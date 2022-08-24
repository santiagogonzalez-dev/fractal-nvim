local startup = require('csj.core.utils.startup')
startup.disable()

vim.schedule(function()
  -- Enable syntax, ftplugin, restore runtimepath and read shadafile.
  startup.enable()

  require('csj.core')
  require('user') -- This loads my user settings, plugins, completion, LSP, etc.

  vim.api.nvim_exec_autocmds('BufEnter', {})
  vim.api.nvim_exec_autocmds('UIEnter', {})
  vim.cmd.filetype('detect') -- Load ftplugin.
end)

-- TODO(santigo-zero):
-- Make ci( and c( behave differently
-- Do not let w and b jump between lines, make them work only on the current line
-- Conditional to disable treesitter and other heavy plugins when entering big files
-- Make module for t, T, f, F to work in the entire buffer instead of just linewise
-- Create utils/status.lua and put most of the components and statusline
-- functions in there
