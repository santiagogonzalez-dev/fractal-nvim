local M = {}
local utils = require 'csj.utils'

-- Set a colorscheme or notify if there's something wrong with it
---@param name string
---@return boolean
M.colorscheme = function(name)
   -- Comprobation that `name` is a valid string
   if name == '' or name == nil or name == vim.NIL then
      vim.notify 'The string for setting up the colorcheme might be wrong, check you user_settings.json'
      return false
   end

   local ok, _ = pcall(vim.cmd.colorscheme, name)
   if not ok then
      vim.notify 'Could not find the colorscheme, check your settings.json'
      return false
   else
      vim.cmd.redraw()
      return true
   end
end

-- Apply settings using the settings from user.opts
---@param opts table
M.opts = function(opts)
   for k, v in pairs(opts) do
      vim.opt[k] = v
   end
end

-- Restore session: Folds, view of the window, marks, command line history, and
-- cursor position.
---@param mode boolean
---@return boolean
M.session = function(mode)
   if not mode then
      return false
   end

   -- Setup the initial load and maintain some settings between buffers
   local save_sessions = vim.api.nvim_create_augroup('save_sessions', {})

   local point_restore = function()
      pcall(vim.cmd.loadview) -- Load the view for the opened buffer

      -- Restore cursor position
      local markpos = vim.api.nvim_buf_get_mark(0, '"') -- Get position of last saved edit
      local line = markpos[1]
      local col = markpos[2]
      -- If the cursor line position is less than 1, but not bigger than the lines of the buffer then
      if line <= vim.api.nvim_buf_line_count(0) then
         vim.api.nvim_win_set_cursor(0, { line, col }) -- Set the position
         if vim.fn.foldclosed(line) ~= -1 then -- And check if there's a closed fold
            return vim.cmd.normal 'zo'
         end
      end
   end

   point_restore()

   vim.api.nvim_create_autocmd('BufWinEnter', {
      desc = 'Load buffer view and cursor position',
      group = save_sessions,
      callback = function()
         if not utils.avoid_filetype() then
            point_restore()
         end
         -- return utils.avoid_filetype() and point_restore()
      end,
   })

   vim.api.nvim_create_autocmd('BufWinLeave', {
      desc = 'Save the view of the buffer',
      group = save_sessions,
      callback = function()
         if not utils.avoid_filetype() then
            return vim.cmd.mkview()
         end
      end,
   })

   return true
end

M.conditionals = function(mode)
   if not mode then
      return false
   end

   local function run_comprobations()
      -- Conditionals
      local conditionals = vim.api.nvim_create_augroup('conditionals', {})
      -- Run a comprobation for git, if the file is under git control there's no
      -- need to create an autocommand
      if utils.is_git() then
         return
      else
         -- If the current buffer wasn't under git version control run the
         -- comprobation each time you change of directory
         vim.api.nvim_create_autocmd('DirChanged', {
            group = conditionals,
            callback = function()
               return utils.is_git()
            end,
         })
      end
   end

   vim.schedule(run_comprobations)

   return true
end

-- List of modules to be loaded, they can be found under
-- `./lua/modules` k is the name of the module and v is a boolean
---@param T table @ Table containing the modules to be loaded
---@return boolean
M.modules = function(T)
   if T == nil or T == vim.NIL then
      return false
   end

   for k, v in pairs(T) do
      local module_path = string.format('csj.modules.%s', k)
      -- local status

      if type(v) == 'boolean' and v then
         -- If the v for the module are just booleans call the module
         -- status = utils.prequire(module_path)
         utils.prequire(module_path)
      elseif type(v) == 'table' or type(v) == 'string' then
         -- In the other hand if the v for the module are tables/strings call
         -- the setups for each module.
         local lib = utils.prequire(module_path)
         if lib then
            -- status = lib.setup(v)
            lib.setup(v)
         end
      end
      -- if status then
      --    vim.pretty_print(string.format('%s %s   ', '   Module loaded ->', k))
      -- end
   end
   return true
end

return M
