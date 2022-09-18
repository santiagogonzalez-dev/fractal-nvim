local M = {}
local utils = require('csj.utils')
local _ns_sim = vim.api.nvim_create_namespace('_ns_sim') -- Namespace

-- TODO(santigo-zero): Avoid showing the mark in certain filetypes

-- Generate highlight groups
vim.api.nvim_set_hl(0, 'SIM', { link = 'TSVariableBuiltin' })
vim.api.nvim_set_hl(
   0,
   'SIMReversed',
   { bg = utils.get_fg_hl('SIM'), fg = utils.get_bg_hl('CursorLineNr') }
)

-- DESCRIPTION: This module shows a sign in the last place you went into insert
-- mode, so the user just has to think in terms of gi or `i and maybe `` and `.
-- instead of relying in numbers, relativenumbers or any other type of movemen#232136t
-- to move between two places.

---@return number @ id of the extmark
function M.display_mark()
   local pos_cur = vim.api.nvim_buf_get_mark(0, '^')

   -- return vim.api.nvim_buf_set_extmark(0, _ns_sim, pos_cur[1] - 1, 0, {
   --   cursorline_hl_group = 'SIMReversed',
   --   sign_text = ' ',
   --   sign_hl_group = 'SIM',
   -- })

   -- If the cursor is almost at the end of the line
   if pos_cur[2] >= #vim.api.nvim_get_current_line() - 5 then
      -- Use virtual text at the end of the line
      return vim.api.nvim_buf_set_extmark(0, _ns_sim, pos_cur[1] - 1, 0, {
         virt_text = {
            { '', 'SIM' },
            { ' ', 'SIMReversed' },
            { '', 'SIM' },
         },
         virt_text_pos = 'eol',
         -- virt_text_win_col = #vim.api.nvim_get_current_line(),
         -- virt_text_win_col = tonumber(
         --   vim.api.nvim_win_get_option(0, 'colorcolumn'):match('(.+),')
         -- ) - 1, -- Shows the virtual text at the column of the first colorcolumn
      })
   else
      -- If the cursor is not at the end of the line use a sign instead of virtual text
      return vim.api.nvim_buf_set_extmark(0, _ns_sim, pos_cur[1] - 1, 0, {
         cursorline_hl_group = 'SIM',
         sign_text = ' ',
         sign_hl_group = 'SIMReversed',
      })
   end
end

function M.hide_mark(id_extmark)
   if not id_extmark then return end
   vim.api.nvim_buf_del_extmark(0, _ns_sim, id_extmark)
end

function M.setup()
   local _ag_sim = vim.api.nvim_create_augroup('show_insert_mark', {})
   vim.api.nvim_create_autocmd('InsertLeave', {
      group = _ag_sim,
      callback = function()
         local sim_extmark_id = M.display_mark()
         vim.api.nvim_create_autocmd('InsertEnter', {
            group = _ag_sim,
            callback = function() M.hide_mark(sim_extmark_id) end,
         })
      end,
   })
end

return M
