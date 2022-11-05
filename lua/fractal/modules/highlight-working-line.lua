local M = {
   -- DESCRIPTION: This module aims to reduce the cognitive overhead, it
   -- highlights the actual working line with the same highlight group for
   -- CursorColumn, so if you move to another part of your code and want to
   -- jump back you need to think in terms of motions or marks, like:
   -- `` `. gi `^
   -- Once you incorporate this motions and marks to your muscle memory moving
   -- around will become simpler and easier, without the need of complex motion
   -- plugins.
}
local nm_HWL = vim.api.nvim_create_namespace "HWL" -- Namespace

-- TODO(santigo-zero): Avoid showing the mark in certain filetypes

---@return number @ id of the extmark
function M.display_mark()
   local pos_cur = vim.api.nvim_buf_get_mark(0, "^")

   return vim.api.nvim_buf_set_extmark(0, nm_HWL, pos_cur[1] - 1, 0, {
      line_hl_group = "CursorColumn",
   })
end

function M.hide_mark(id)
   if not id then return end
   vim.api.nvim_buf_del_extmark(0, nm_HWL, id)
end

local ag_HWL = vim.api.nvim_create_augroup("ag_HWL", {})
function M.setup()
   vim.api.nvim_create_autocmd("InsertLeave", {
      group = ag_HWL,
      callback = function()
         local id = M.display_mark()
         vim.api.nvim_create_autocmd("InsertEnter", {
            group = ag_HWL,
            callback = function()
               M.hide_mark(id)
            end,
         })
      end,
   })
end

return M
