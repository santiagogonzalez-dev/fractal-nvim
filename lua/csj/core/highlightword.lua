local M = {}

function M.highlight_word_under_cursor(client, bufnr)
  -- For now this only uses LSP
  if client.server_capabilities.documentHighlightProvider then
    local highlight_word = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = 'lsp_document_highlight',
    }

    vim.api.nvim_create_autocmd('CursorMoved', {
      group = highlight_word,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end,
    })
  end
end

--[[ require('nvim-treesitter.ts_utils').highlight_node(require('nvim-treesitter.ts_utils').get_node_at_cursor(),
0, vim.api.nvim_create_namespace('test'), 'Search') ]]
--

return M
