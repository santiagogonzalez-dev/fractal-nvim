M = {}

-- Disable default plugins
function M.disable_builtins(mode)
   if mode == true then
      local plugins_list = {
         '2html_plugin',
         'getscript',
         'getscriptPlugin',
         'gzip',
         'logipat',
         'man',
         'matchit',
         'matchparen',
         'netrw',
         'netrwFileHandlers',
         'netrwPlugin',
         'netrwSettings',
         'perl_provider',
         'python_provider',
         'remote_plugins',
         'rrhelper',
         'ruby_provider',
         'shada_plugin',
         'spec',
         'tar',
         'tarPlugin',
         'vimball',
         'vimballPlugin',
         'zip',
         'zipPlugin',
      }

      for plugin in pairs(plugins_list) do
         vim.g['loaded_' .. plugin] = 1
      end

      vim.cmd([[
         syntax off
         filetype off
         filetype plugin indent off
      ]])

      vim.opt.shadafile = 'NONE'
   elseif mode == false then
      vim.opt.shadafile = ''

      vim.cmd([[
         rshada!
         doautocmd BufRead
         syntax on
         filetype on
         filetype plugin indent on
      ]])
   end
end

return M
