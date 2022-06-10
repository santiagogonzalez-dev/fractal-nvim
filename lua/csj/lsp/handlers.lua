local M = {}

function M.setup()
   local signs = {
      { name = 'DiagnosticSignError', text = ' ', texthl = 'DiagnosticSignError' },
      { name = 'DiagnosticSignWarn', text = ' ', texthl = 'DiagnosticSignWarn' },
      { name = 'DiagnosticSignHint', text = ' ', texthl = 'DiagnosticSignInfo' },
      { name = 'DiagnosticSignInfo', text = ' ', texthl = 'DiagnosticSignHint' },
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
            return string.format('%s (%s) [%s]', diagnostic.message, diagnostic.source, diagnostic.code or diagnostic.user_data.lsp.code)
         end,
      },
   }

   vim.diagnostic.config(config)
   vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = true, border = 'rounded' })
   vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded ' })
end

function M.lsp_highlight_document(client, bufnr)
   -- if client.resolved_capabilities.document_highlight then -- Deprecated
   if client.server_capabilities.documentHighlightProvider then
      local lsp_highlight = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
      vim.api.nvim_clear_autocmds {
         buffer = bufnr,
         group = 'lsp_document_highlight',
      }
      vim.api.nvim_create_autocmd('CursorHold', {
         group = lsp_highlight,
         buffer = bufnr,
         callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
         group = lsp_highlight,
         buffer = bufnr,
         callback = vim.lsp.buf.clear_references,
      })
   end
end

function M.on_attach(client, bufnr)
   require('csj.manners.lsp').keymaps(bufnr)
   M.lsp_highlight_document(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
   return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
