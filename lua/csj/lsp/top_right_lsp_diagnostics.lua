local highlight_groups = {
   [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
   [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
   [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
   [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
}

local function print_diagnostics()
   local linenr = vim.api.nvim_win_get_cursor(0)[1] - 1
   local TRLD_nm = vim.api.nvim_create_namespace('TRLD')
   local ns = vim.diagnostic.get_namespace(TRLD_nm)

   local line_diagnostics = vim.diagnostic.get(0, { ['lnum'] = linenr })

   if vim.tbl_isempty(line_diagnostics) then
      if ns.user_data.diags then
         vim.api.nvim_buf_clear_namespace(0, TRLD_nm, 0, -1)
      end
      return
   end

   if ns.user_data.last_line_nr == linenr and ns.user_data.diags then
      return
   end

   ns.user_data.diags = true
   ns.user_data.last_line_nr = linenr

   local win_info = vim.fn.getwininfo(vim.fn.win_getid())[1]

   for i, diagnostic in ipairs(line_diagnostics) do
      local diag_lines = {}

      for line in diagnostic.message:gmatch('[^\n]+') do
         table.insert(diag_lines, line)
      end
      for j, dline in ipairs(diag_lines) do
         local x = (win_info.topline - 3) + (i + j)
         if win_info.botline <= x - 1 then
            return
         end
         vim.api.nvim_buf_set_extmark(0, TRLD_nm, x, 0, {
            virt_text = { { dline, highlight_groups[diagnostic.severity] } },
            virt_text_pos = 'right_align',
            virt_lines_above = true,
         })
      end
   end
end

local function hide_diagnostics()
   local ok_nm = vim.api.nvim_get_namespaces()['TRLD']
   if ok_nm == nil then
      return
   end
   local TRLD_nm = vim.diagnostic.get_namespace(ok_nm)
   if TRLD_nm.user_data.diags then
      vim.api.nvim_buf_clear_namespace(0, ok_nm, 0, -1)
   end
   TRLD_nm.user_data.diags = false
end

vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
   desc = 'Print the lsp diagnostics at the top right of the screen',
   -- group = lsp_settings,
   callback = function()
      return print_diagnostics()
   end,
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
   desc = 'Clean the lsp messages from the top right of the screen',
   -- group = lsp_settings,
   callback = function()
      return hide_diagnostics()
   end,
})
