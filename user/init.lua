require "keymaps"
require "settings"
require "plugins"

-- Settings for non-visible characters
vim.opt.fillchars:append({
   eob = "␃",
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
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
   desc = "Enable spelling in insert mode",
   group = _enable_spell,
   callback = function()
      vim.opt_local.spell = not vim.opt_local.spell:get()
   end,
})

-- Extra whitespaces will be highlighted
vim.fn.matchadd("ErrorMsg", "\\s\\+$")

vim.api.nvim_create_user_command("EvalYankRegister", function()
   vim.cmd.lua(vim.fn.getreg '"')
end, {})

vim.api.nvim_create_autocmd(
   { "WinLeave", "BufLeave", "FocusLost", "InsertLeave" },
   {
      callback = function()
         if
            vim.bo.modified
            and not vim.bo.readonly
            and vim.fn.expand "%" ~= ""
            and vim.bo.buftype == ""
         then
            vim.api.nvim_command "silent update"
         end
      end,
   }
)

-- vim.api.nvim_create_autocmd("BufEnter", {
--    callback = function()
--       vim.cmd [[syntax match hidechars '\'' conceal " cchar= ]]
--       vim.cmd [[syntax match hidechars '\"' conceal " cchar= ]]
--       vim.cmd [[syntax match hidechars '\[\[' conceal " cchar= ]]
--       vim.cmd [[syntax match hidechars '\]\]' conceal " cchar= ]]
--    end,
-- })
