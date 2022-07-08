local M = {}

function M.setup()
  local signs = {
    {
      name = 'DiagnosticSignError',
      text = ' ',
      texthl = 'DiagnosticSignError',
    },
    {
      name = 'DiagnosticSignWarn',
      text = ' ',
      texthl = 'DiagnosticSignWarn',
    },
    {
      name = 'DiagnosticSignHint',
      text = ' ',
      texthl = 'DiagnosticSignInfo',
    },
    {
      name = 'DiagnosticSignInfo',
      text = ' ',
      texthl = 'DiagnosticSignHint',
    },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
  end

  local config = {
    virtual_text = false, -- Disable virtual text
    signs = { active = signs }, -- Show signs
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      border = 'rounded',
      style = 'minimal',
      source = 'if_many',
      format = function(diagnostic)
        return string.format(
          '%s (%s) [%s]',
          diagnostic.message,
          diagnostic.source,
          diagnostic.code or diagnostic.user_data.lsp.code
        )
      end,
    },
  }

  vim.diagnostic.config(config)
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { focusable = true, border = 'rounded' }
  )
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded ' }
  )
end

function M.on_attach(client, bufnr)
  require('csj.lsp.keymaps').keymaps(bufnr)
  require('csj.core.highlightword').highlight_word_under_cursor(client, bufnr)
end

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

return M
