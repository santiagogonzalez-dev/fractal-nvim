require "keymaps"
require "settings"
require "plugins"

-- vim.cmd.colorscheme "jetjbp"

-- Settings for non-visible characters
vim.opt.fillchars:append({
   msgsep = "🮑", -- Separator for cmdline
})

vim.opt.fillchars:append({

   -- horiz = '━',
   -- horizup = '┻',
   -- horizdown = '┳',
   -- vert = '┃',
   -- vertleft = '┫',
   -- vertright = '┣',
   -- verthoriz = '╋',

   -- horiz = '─',
   -- horizup = '┴',
   -- horizdown = '┬',
   -- vert = '│',
   -- vertleft = '┤',
   -- vertright = '├',
   -- verthoriz = '┼',

   horiz = " ",
   horizup = " ",
   horizdown = " ",
   vert = " ",
   vertleft = " ",
   vertright = " ",
   verthoriz = " ",
})

vim.opt.listchars:append({
   -- eol = '↴', -- ↪ ↲ ⏎ 
   -- space = '·',
   -- tab = '-->',
   extends = "◣",
   nbsp = "␣",
   precedes = "◢",
   -- tab = "!·",
   -- leadmultispace = "!··",
   trail = "█", -- · ␣
})

-- Ensure this settings persist in all buffers
function _G.all_buffers_settings()
   vim.opt.iskeyword = "@,48-57,192-255"

   vim.opt.formatoptions = vim.opt.formatoptions
      + "r" -- If the line is a comment insert another one below when hitting <CR>
      + "c" -- Wrap comments at the char defined in textwidth
      + "q" -- Allow formatting comments with gq
      + "j" -- Remove comment leader when joining lines when possible
      - "o" -- Don't continue comments after o/O
      - "l" -- Format in insert mode if the line is longer than textwidth

   vim.opt.cpoptions = vim.opt.cpoptions + "n" -- Show `showbreak` icon in the number column
end

vim.schedule(function()
   vim.api.nvim_create_autocmd({ "UIEnter", "BufEnter" }, {
      group = "session_opts",
      callback = _G.all_buffers_settings,
   })
   _G.all_buffers_settings()
end)

local _enable_spell = vim.api.nvim_create_augroup("_enable_spell", {})
vim.api.nvim_create_autocmd("InsertEnter", {
   desc = "Enable spelling in insert mode",
   group = _enable_spell,
   callback = function()
      vim.opt_local.spell = true
   end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
   desc = "Disable spelling in insert mode",
   group = _enable_spell,
   callback = function()
      vim.opt_local.spell = false
   end,
})

-- Extra whitespaces will be highlighted
vim.fn.matchadd("ErrorMsg", "\\s\\+$")

vim.api.nvim_create_user_command("EvalYankRegister", function()
   vim.cmd.lua(vim.fn.getreg '"')
end, {})
