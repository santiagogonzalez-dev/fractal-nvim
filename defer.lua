require "fractal.core.not"

-- Temporarily disable ftplugin and shadafile.
vim.cmd.filetype "off"
vim.cmd.filetype "plugin indent off"
vim.opt.shadafile = "NONE"

-- Enable bundled treesitter parsers, this also turns off `syntax`.
-- https://github.com/neovim/neovim/issues/14090#issuecomment-1237820552
vim.g.ts_highlight_lua = true

-- PROFILING: About profiling, all the settings before this comment are going
-- to be run first, then everything under `./plugins`, then `./after/plugins`, and
-- lastly the main function will be scheduled and run so that we defer the load
-- of the config.
vim.schedule(function()
   if not vim.opt.loadplugins:get() then
      vim.cmd "runtime! plugin/**/*.vim"
      vim.cmd "runtime! plugin/**/*.lua"
   end

   -- Enable filetype settings and shadafile.
   vim.cmd.filetype "on"
   vim.cmd.filetype "plugin indent on"
   vim.opt.shadafile = ""
   vim.cmd.rshada({ bang = true })

   require "fractal.core"
end)
