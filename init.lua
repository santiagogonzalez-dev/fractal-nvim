-- -- Builtin plugins and providers.
-- vim.opt.loadplugins = false -- TODO(santigo-zero): Netrw doesn't work with this enabled.

-- local builtins = false -- Any other value besides nil disables the plugins.
-- vim.g.loaded_2html_plugin = builtins
-- vim.g.loaded_bugreport = builtins
-- vim.g.loaded_compiler = builtins
-- vim.g.loaded_getscript = builtins
-- vim.g.loaded_getscriptPlugin = builtins
-- vim.g.loaded_gzip = builtins
-- vim.g.loaded_logiPat = builtins
-- vim.g.loaded_logipat = builtins
-- vim.g.loaded_man = builtins
-- vim.g.loaded_matchParen = builtins
-- vim.g.loaded_matchit = builtins
-- vim.g.loaded_netrwFileHandlers = builtins
-- vim.g.loaded_netrwSettings = builtins
-- vim.g.loaded_optwin = builtins
-- vim.g.loaded_perl_provider = builtins
-- vim.g.loaded_rplugin = builtins
-- vim.g.loaded_rrhelper = builtins
-- vim.g.loaded_spec = builtins
-- vim.g.loaded_synmenu = builtins
-- vim.g.loaded_syntax = builtins
-- vim.g.loaded_tar = builtins
-- vim.g.loaded_tarPlugin = builtins
-- vim.g.loaded_tutor = builtins
-- vim.g.loaded_vimball = builtins
-- vim.g.loaded_vimballPlugin = builtins
-- vim.g.loaded_zip = builtins
-- vim.g.loaded_zipPlugin = builtins

-- -- Disable providers
-- vim.g.loaded_python3_provider = builtins
-- vim.g.loaded_node_provider = builtins
-- vim.g.loaded_ruby_provider = builtins
-- vim.g.loaded_perl_provider = builtins

-- -- Syntax and ftplugin.
-- vim.cmd.syntax 'off'
-- vim.cmd.filetype 'off'
-- vim.cmd.filetype 'plugin indent off'
-- vim.opt.shadafile = 'NONE'

-- vim.schedule(function()
--    -- Load runtime files.
--    -- TODO(santigo-zero): use vim.opt.runtimepath:append
--    vim.api.nvim_command 'runtime! plugin/**/*.vim'
--    vim.api.nvim_command 'runtime! plugin/**/*.lua'

--    -- Syntax and ftplugin.
--    vim.cmd.syntax 'on'
--    vim.cmd.filetype 'on'
--    vim.cmd.filetype 'plugin indent on'

--    -- Shadafile.
--    vim.opt.shadafile = ''
--    vim.cmd.rshada { bang = true } -- Read shadafile.

--    require 'csj.core'

--    -- Manually check and trigger BufNewFile, this is done because I'm lazyloading
--    if vim.fn.filereadable(vim.fn.expand(vim.api.nvim_eval_statusline('%F', {}).str)) == 0 then
--       vim.api.nvim_exec_autocmds('BufNewFile', {})
--    else
--       vim.cmd.e() -- or vim.cmd.filetype 'detect' -- Load ftplugin.
--    end

--    vim.api.nvim_exec_autocmds('BufEnter', {})
--    vim.api.nvim_exec_autocmds('UIEnter', {})
-- end)

require('csj.core')
