local M = {}

function M.conditional_for_numbers()
   return "%{v:relnum?v:relnum:v:lnum} "
end

function M.get()
   return table.concat({
      "%s",
      M.conditional_for_numbers(),
      "%=",
      "%C",
      " ",
   })
end

function M.setup()
   vim.opt.number = true
   vim.opt.relativenumber = true
   vim.opt.numberwidth = 1
   -- vim.opt.signcolumn = "number"
   vim.opt.statuscolumn = [[%!v:lua.require('fractal.modules.gutter').get()]]
   -- vim.o.statuscolumn='%s%=%l %C%{v:relnum == 0 ? "⧽" : ""}%{v:relnum == 0 ? "" : "▏"} '
end

return M
