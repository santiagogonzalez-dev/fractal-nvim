local M = {}

-- Setup
M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    virtual_text = false, -- Toggle virtual text
    signs = { active = signs }, -- Show signs
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      border = 'rounded',
      style = 'minimal',
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
    { focusable = false, border = 'rounded' }
  )
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
end

-- Highlight words matching the word under cursor
local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    local highlight = vim.api.nvim_create_augroup('lsp_document_highlight', {})

    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = 0,
      group = highlight,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd('CursorMoved', {
      buffer = 0,
      group = highlight,
      callback = vim.lsp.buf.clear_references,
    })

    local opts = { nocombine = true, reverse = true }
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, 'LspReferenceText', opts)
    set_hl(0, 'LspReferenceRead', opts)
    set_hl(0, 'LspReferenceWrite', opts)
  end
end

-- On attach
M.on_attach = function(client, _)
  -- tsserver
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  -- html
  if client.name == 'html' then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  -- json
  if client.name == 'jsonls' then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  require('csj.core.keymaps').lsp_keymaps() -- Keymaps
  lsp_highlight_document(client) -- Highlighting
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
  return
end

-- Update cmp capabilities
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local compl = capabilities.textDocument.completion.completionItem
compl.commitCharactersSupport = true
compl.deprecatedSupport = true
compl.insertReplaceSupport = true
compl.labelDetailsSupport = true
compl.preselectSupport = true
compl.resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits' } }
compl.tagSupport = { valueSet = { 1 } }

capabilities.textDocument.codeAction = {
  dynamicRegistration = false,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = {
        '',
        'quickfix',
        'refactor',
        'refactor.extract',
        'refactor.inline',
        'refactor.rewrite',
        'source',
        'source.organizeImports',
      },
    },
  },
}

return M
