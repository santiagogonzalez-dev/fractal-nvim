local M = {}
local _ns_sim = vim.api.nvim_create_namespace('_ns_sim') -- Namespace

-- DESCRIPTION: This module shows a sign in the last place you went into insert
-- mode, so the user just has to think in terms of gi or `i and maybe `` and `.
-- instead of relying in numbers, relativenumbers or any other type of movemen#232136t
-- to move between two places.

function M.display_mark()
  local pos_cur = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_buf_set_mark(0, 'i', pos_cur[1], pos_cur[2] + 1, {}) -- Set a mark at i
  return vim.api.nvim_buf_set_extmark(0, _ns_sim, pos_cur[1] - 1, 0, { sign_text = '', sign_hl_group = 'Constant' })
end

function M.hide_mark(id_extmark)
  vim.api.nvim_buf_del_extmark(0, _ns_sim, id_extmark)
end

local _ag_sim = vim.api.nvim_create_augroup('show_insert_mark', {})
vim.api.nvim_create_autocmd('InsertLeave', {
  group = _ag_sim,
  callback = function()
    local sim_extmark_id = M.display_mark()
    vim.api.nvim_create_autocmd('InsertEnter', {
      group = _ag_sim,
      callback = function()
        M.hide_mark(sim_extmark_id)
      end,
    })
  end,
})

return M
