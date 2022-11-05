local M = {}

function M.setup()
   local signs = {
      {
         name = "DiagnosticSignError",
         text = " ",
         texthl = "DiagnosticSignError",
      },
      {
         name = "DiagnosticSignWarn",
         text = " ",
         texthl = "DiagnosticSignWarn",
      },
      {
         name = "DiagnosticSignHint",
         text = " ",
         texthl = "DiagnosticSignInfo",
      },
      {
         name = "DiagnosticSignInfo",
         text = " ",
         texthl = "DiagnosticSignHint",
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
         border = "rounded",
         style = "minimal",
         source = "if_many",
         format = function(diagnostic)
            return string.format(
               "%s (%s) [%s]",
               diagnostic.message,
               diagnostic.source,
               diagnostic.code or diagnostic.user_data.lsp.code
            )
         end,
      },
   }

   vim.diagnostic.config(config)
   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { focusable = true, border = "rounded" }
   )
   vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded " })
end

M.on_attach = function(client, bufnr)
   local caps = client.server_capabilities
   if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
      local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
      vim.api.nvim_create_autocmd("TextChanged", {
         group = augroup,
         buffer = bufnr,
         callback = function()
            vim.lsp.buf.semantic_tokens_full()
         end,
      })
      -- fire it first time on load as well
      vim.lsp.buf.semantic_tokens_full()
   end

   if client.name == "jdt.ls" then
      vim.lsp.codelens.refresh()
      if JAVA_DAP_ACTIVE then
         require("jdtls").setup_dap({ hotcodereplace = "auto" })
         require("jdtls.dap").setup_dap_main_class_configs()
      end
   end

   -- Write on format
   vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {
         "*.css",
         "*.html",
         "*.js",
         "*.lua",
         "*.python",
         "*.ts",
      },
      callback = function()
         vim.lsp.buf.format({ async = true })
      end,
   })

   require("plugins.lsp.keymaps").keymaps(bufnr)
   if client.server_capabilities.documentHighlightProvider then
  --     vim.cmd [[
  --   hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  --   hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  --   hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  -- ]]
      vim.api.nvim_create_augroup("lsp_document_highlight", {
         clear = false,
      })
      vim.api.nvim_clear_autocmds({
         buffer = bufnr,
         group = "lsp_document_highlight",
      })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
         group = "lsp_document_highlight",
         buffer = bufnr,
         callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
         group = "lsp_document_highlight",
         buffer = bufnr,
         callback = vim.lsp.buf.clear_references,
      })
   end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

return M
