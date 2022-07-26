local M = {}

function M.highlight_word_under_cursor(client, bufnr)
  -- For now this only uses LSP
  if client.server_capabilities.documentHighlightProvider then
    local highlight_word = vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = 'lsp_document_highlight',
    }

    vim.api.nvim_create_autocmd('CursorHold', {
      group = highlight_word,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })

    vim.api.nvim_create_autocmd('CursorMoved', {
      group = highlight_word,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

return M
