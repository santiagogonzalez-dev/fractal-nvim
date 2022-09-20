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
   vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded ' })
end

function M.highlight_word_under_cursor(client, bufnr)
   -- For now this only uses LSP
   if client.server_capabilities.documentHighlightProvider then
      local highlight_word =
         vim.api.nvim_create_augroup('lsp_document_highlight', {})
      vim.api.nvim_clear_autocmds({
         buffer = bufnr,
         group = 'lsp_document_highlight',
      })

      vim.api.nvim_create_autocmd('CursorHold', {
         group = highlight_word,
         buffer = bufnr,
         callback = function() vim.lsp.buf.document_highlight() end,
      })

      vim.api.nvim_create_autocmd('CursorMoved', {
         group = highlight_word,
         buffer = bufnr,
         callback = function() vim.lsp.buf.clear_references() end,
      })
   end
end

M.on_attach = function(client, bufnr)
   local caps = client.server_capabilities
   if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
      local augroup = vim.api.nvim_create_augroup('SemanticTokens', {})
      vim.api.nvim_create_autocmd('TextChanged', {
         group = augroup,
         buffer = bufnr,
         callback = function() vim.lsp.buf.semantic_tokens_full() end,
      })
      -- fire it first time on load as well
      vim.lsp.buf.semantic_tokens_full()
   end

   if client.name == 'jdt.ls' then
      vim.lsp.codelens.refresh()
      if JAVA_DAP_ACTIVE then
         require('jdtls').setup_dap({ hotcodereplace = 'auto' })
         require('jdtls.dap').setup_dap_main_class_configs()
      end
   end
   require('plugins.lsp.keymaps').keymaps(bufnr)
   M.highlight_word_under_cursor(client, bufnr)
end

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then return end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

return M
