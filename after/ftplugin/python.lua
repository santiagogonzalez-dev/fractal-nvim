local tab_lenght = 4
vim.opt.tabstop = tab_lenght
vim.opt.shiftwidth = tab_lenght
vim.opt.colorcolumn = '80,88'
vim.opt.textwidth = 87
vim.g.python3_host_prog = 'python'
vim.g.python_highlight_all = 1

-- Toggle fstrings in python TODO redo this properly
local ts_utils = require('nvim-treesitter.ts_utils')
local toggle_fstring = function()
   local cursor = vim.api.nvim_win_get_cursor(0)
   local node = ts_utils.get_node_at_cursor()

   while (node ~= nil) and (node:type() ~= 'string') do
      node = node:parent()
   end
   if node == nil then
      print('f-string: not in string node')
      return
   end

   local srow, scol, _, _ = ts_utils.get_vim_range { node:range() }
   vim.fn.setcursorcharpos(srow, scol)
   local char = vim.api.nvim_get_current_line():sub(scol, scol)
   local is_fstring = (char == 'f')

   if is_fstring then
      vim.cmd('normal x') -- TODO(santigo-zero): move to vim.api.nvim_cmd
      -- If cursor is in the same line as text change
      if srow == cursor[1] then
         cursor[2] = cursor[2] - 1 -- negative offset to cursor
      end
   else
      vim.cmd('normal if')
      -- If cursor is in the same line as text change
      if srow == cursor[1] then
         cursor[2] = cursor[2] + 1 -- positive offset to cursor
      end
   end
   vim.api.nvim_win_set_cursor(0, cursor)
end

-- Toggle fstring keymap
vim.keymap.set('n', '<A-f>', toggle_fstring)
