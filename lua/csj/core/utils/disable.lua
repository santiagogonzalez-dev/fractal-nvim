local disable = {}

-- Handle things I'm not going to use, this include builtin plugins, providers,
-- and the shada file.

---@param mode boolean
function disable.builtins(mode)
  if not mode then
    return
  end

  -- Plugins
  vim.g.loadplugins = false
  vim.g.did_indent_on = 1
  vim.g.did_load_ftplugin = 1

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
end

function disable.providers(mode)
  if not mode then
    return
  end

  -- Disable providers
  vim.g.loaded_python3_provider = 1
  vim.g.loaded_node_provider = 1
  vim.g.loaded_ruby_provider = 1
  vim.g.loaded_perl_provider = 1
end

-- -- Shada
-- vim.opt.shadafile = 'NONE'

function disable.setup(T)
  disable.builtins(T.builtins) -- Whether or not to disable builtin plugins.
  disable.providers(T.providers) -- Whether or not to disable providers.
end

return disable
