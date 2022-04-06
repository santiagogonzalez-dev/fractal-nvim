local set = vim.keymap.set
local cmdline = vim.api.nvim_add_user_command

-- Stop the LS
set({ 'n', 'v', 'x' }, '<Leader>ls', function()
  return vim.lsp.stop_client(vim.lsp.get_active_clients())
end, { buffer = true })

-- Code actions
set({ 'v', 'x' }, '<Leader>ca', vim.lsp.buf.range_code_action)
set('n', '<Leader>ca', vim.lsp.buf.code_action)

-- Formatting
set({ 'v', 'x' }, '<Leader><Leader>f', function()
  return vim.lsp.buf.range_formatting
end)
set('n', '<Leader><Leader>f', vim.lsp.buf.formatting)
cmdline('Format', vim.lsp.buf.formatting_sync, {})

set('n', '<Leader>d', vim.diagnostic.setqflist) -- Show all diagnostics
set('n', 'gll', vim.diagnostic.open_float) -- Open in float window
set('n', 'gl', vim.lsp.buf.hover) -- Open in float window
set('n', '<Leader>dj', vim.diagnostic.goto_next) -- Go to next diagnostic
set('n', '<Leader>dk', vim.diagnostic.goto_prev) -- Go to previous diagnostic
set('n', '<Leader>td', require('csj.core.utils').toggle_diagnostics) -- Toggel diagnostics
set('n', 'r', require('csj.core.utils').rename) -- Rename
set('n', 'gd', vim.lsp.buf.definition) -- Definitions
set('n', 'gD', vim.lsp.buf.declaration) -- Declaration
-- set('n', 'gr', vim.lsp.buf.references) -- References
