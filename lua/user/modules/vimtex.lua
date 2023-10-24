local M = {
   'lervag/vimtex'
}

function M.config()
   vim.g.vimtex_view_general_viewer = 'general'
   vim.g.vimtex_view_method = 'general'
   -- vim.g.tex_flavor='latex'
   -- vim.g.vimtex_quickfix_mode=0
   -- vim.g.tex_conceal='abdmg'
end

return M
