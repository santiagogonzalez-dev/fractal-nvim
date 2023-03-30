local folds = {
   -- DESCRIPTION: Override default icons and settings related to folds, this
   -- includes the text that appears when you close a fold.
}

-- When a block of code is folded some text appears in the line of the fold,
-- this function reformats the code to be "smarter"
---@return string
function folds.foldtext_header()
   local AVOID = {
      import = 'imports',
      from = 'imports',
   }
   local header_fold =
      vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, false)

   for key, header in pairs(AVOID) do
      if header_fold[1]:match(key) then
         return header -- For example instead of seeing "from pathlib import Path" we just see "imports"
      else
         local clean_string = header_fold[1]
            :gsub('%(%)', '')
            :gsub('%{', '')
            :gsub('%=', '')
            :gsub('%:', ' ')
         return clean_string
      end
   end
end

function folds.setup()
   -- Fold settings
   vim.opt.jumpoptions = 'stack,view'
   vim.opt.foldtext = 'v:lua.require("fractal.modules.folds").foldtext_header()'
   vim.opt.foldcolumn = 'auto:3' -- Folds column
   vim.opt.foldmethod = 'manual'
   -- vim.opt.foldmethod = "expr"
   vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

   vim.opt.fillchars:append({
      fold = '─',
      foldclose = '󰅂',
      foldopen = '󰅀',
   })
end

return folds
