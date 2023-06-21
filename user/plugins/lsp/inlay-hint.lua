local function get_client(event)
   local client_id = event.data.client_id
   local client = vim.lsp.get_client_by_id(client_id)

   return client
end

vim.api.nvim_create_autocmd('LspAttach', {
   callback = function(ev)
      if get_client(ev).server_capabilities.inlayHintProvider then
         vim.lsp.buf.inlay_hint(0, true)
      end
   end,
})
