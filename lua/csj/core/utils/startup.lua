local M = {}
local utils = require('csj.core.utils')

-- Disable temporarily syntax, ftplugin, shadafile, runtimepath and other
-- builtin plugins and providers in order to improve startup time.
function M.disable()
  vim.cmd.syntax('off')
  vim.cmd.filetype('off')
  vim.cmd.filetype('plugin indent off')
  vim.opt.shadafile = 'NONE'

  -- Plugins
  -- vim.opt.loadplugins = false -- TODO(santigo-zero): CMP doesn't work with this enabled.
  vim.g.did_indent_on = 1
  -- vim.g.did_load_ftplugin = 1

  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_bugreport = 1
  vim.g.loaded_compiler = 1
  vim.g.loaded_ftplugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_gzip = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_logipat = 1
  vim.g.loaded_man = 1
  vim.g.loaded_matchParen = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_optwin = 1
  vim.g.loaded_perl_provider = 1
  vim.g.loaded_rplugin = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_spec = 1
  vim.g.loaded_synmenu = 1
  vim.g.loaded_syntax = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_tutor = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1

  -- Disable providers
  vim.g.loaded_python3_provider = 1
  vim.g.loaded_node_provider = 1
  vim.g.loaded_ruby_provider = 1
  vim.g.loaded_perl_provider = 1
end

-- Enable stuff that was disable by M.disable
function M.enable()
  vim.cmd.syntax('on')
  vim.cmd.filetype('on')
  vim.cmd.filetype('plugin indent on')
  vim.opt.shadafile = ''
  vim.cmd.rshada { bang = true }

  -- Load runtime files.
  if not vim.opt.loadplugins then
    vim.cmd.runtime('plugin/**/*.lua')
    vim.cmd.runtime('plugin/**/*.vim')
  end
end

-- Set a colorscheme or notify if there's something wrong with it
---@param name string
---@return boolean
function M.colorscheme(name)
  -- Comprobation that `name` is a valid string
  if name == '' or name == nil or name == vim.NIL then
    vim.notify(
      'The string for setting up the colorcheme might be wrong, check you user_settings.json',
      vim.log.levels.INFO
    )
    return false
  end

  vim.cmd.colorscheme(name)
  return true
end

-- Apply settings using the settings from user.opts
---@param opts table
function M.opts(opts)
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
end

-- Restore session: Folds, view of the window, marks, command line history, and
-- cursor position.
---@param mode boolean
---@return boolean
function M.session(mode)
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
        return vim.cmd.normal('zo')
      end
    end
  end

  point_restore()

  vim.api.nvim_create_autocmd('BufWinEnter', {
    desc = 'Load buffer view and cursor position',
    group = save_sessions,
    callback = function()
      if utils.avoid_filetype() then
        return
      end
      point_restore()
    end,
  })

  vim.api.nvim_create_autocmd('BufWinLeave', {
    desc = 'Save the view of the buffer',
    group = save_sessions,
    callback = function()
      if utils.avoid_filetype() then
        return
      end
      return vim.cmd.mkview()
    end,
  })

  return true
end

function M.conditionals(mode)
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
-- `./lua/csj/core/modules` k is the name of the module and v is a boolean
---param T table @ Table containing the modules to be loaded
function M.modules(T)
  if T == nil or T == vim.NIL then
    return false
  end

  for k, v in pairs(T) do
    local module_path = string.format('csj.modules.%s', k)
    local status

    if type(v) == 'boolean' and v then
      -- If the v for the module are just booleans call the module
      status = utils.prequire(module_path)
    elseif type(v) == 'table' or type(v) == 'string' then
      -- In the other hand if the v for the module are tables call the setups
      -- for each module
      local lib = utils.prequire(module_path)
      if lib then
        status = lib.setup(v)
      end
    end
    if status then
      vim.pretty_print(string.format('%s %s   ', '   Module loaded ->', k))
    end
  end
end

return M
