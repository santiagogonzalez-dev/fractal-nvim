local utils = require('csj.utils')

vim.keymap.set({ 'n', 'v', 'x' }, '<Leader>ls', function()
   return vim.lsp.stop_client(vim.lsp.get_active_clients())
end, { desc = 'Stop the LS' })

vim.keymap.set({ 'v', 'x' }, '<Leader>ca', ':lua vim.lsp.buf.range_code_action()<CR>', { desc = 'Range code actions' })
vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Formatting
vim.keymap.set('n', '<Leader><Leader>f', function()
   return vim.lsp.buf.format({ async = true })
end, { desc = 'Format the file' })

vim.keymap.set({ 'v', 'x' }, '<Leader><Leader>f', function()
   return vim.lsp.buf.range_formatting()
end, { desc = 'Range formatting the file' })

vim.api.nvim_create_user_command('Format', function()
   return vim.lsp.buf.format({ async = false })
end, {})

-- Diagnostics
vim.keymap.set('n', '<Leader>d', vim.diagnostic.setqflist, { desc = 'Show all diagnostics an a quickfix list' })

vim.keymap.set('n', 'gll', function()
   if utils.not_interfere_on_float() then -- If there is not a floating window present
      local diags = vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' }) -- Try to open diagnostics under the cursor
      if not diags then -- If there's no diagnostic under the cursor show diagnostics of the entire line
         vim.diagnostic.open_float()
      end
      return diags
   end
end, { desc = 'Show diagnostics in a float window' })

local diagnostics_active
vim.keymap.set('n', '<S-CR>', function()
   diagnostics_active = not diagnostics_active
   if diagnostics_active then
      return vim.diagnostic.hide()
   else
      return vim.diagnostic.show()
   end
end, { desc = 'Toggle diagnostics' })

vim.keymap.set('n', 'gl', function()
   return utils.not_interfere_on_float() and vim.lsp.buf.hover()
end, { desc = 'Show a description of the word under cursor' })

vim.keymap.set('n', '<C-]>', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<C-[>', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Definitions' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Declarations' })
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references) -- References

vim.keymap.set('n', 'r', function()
   local function post(rename_old)
      vim.cmd('stopinsert!')
      local new = vim.api.nvim_get_current_line()
      vim.schedule(function()
         vim.api.nvim_win_close(0, true)
         vim.lsp.buf.rename(vim.trim(new))
      end)
      vim.notify(rename_old .. '  ' .. new)
   end

   local rename_old = vim.fn.expand('<cword>')
   local created_buffer = vim.api.nvim_create_buf(false, true)
   vim.api.nvim_open_win(created_buffer, true, {
      relative = 'cursor',
      style = 'minimal',
      border = 'rounded',
      row = -3,
      col = 0,
      width = 20,
      height = 1,
   })
   vim.cmd('startinsert')

   vim.keymap.set('i', '<ESC>', function()
      vim.cmd('q')
      vim.cmd('stopinsert')
   end, { buffer = created_buffer })

   vim.keymap.set('i', '<CR>', function()
      return post(rename_old)
   end, { buffer = created_buffer })
end, { desc = 'Rename using LSP' })
