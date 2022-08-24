local M = {}

-- Default tab size, this is not applied if you specified a different one in
-- ftplugin
local tab_lenght = 4
vim.opt.shiftwidth = tab_lenght -- Size of a > or < when indenting
vim.opt.tabstop = tab_lenght -- Tab length

-- Cursor settings
vim.opt.guicursor:append('v:hor50')
vim.opt.guicursor:append('i-ci-ve:ver25')
vim.opt.guicursor:append('r-cr-o:hor20')

-- Search files recursively
vim.opt.path:append('**')

vim.opt.showcmd = false

-- To appropriately highlight codefences
vim.g.markdown_fenced_languages = {
  'js=javascript',
  'jsx=javascriptreact',
  'ts=typescript',
  'tsx=typescriptreact',
}

-- TODO(santigo-zero): Delete this, it's just an example
-- -- Warn the user that it's at the bottom of the file
-- local _ns_general = vim.api.nvim_create_namespace('general') -- Namespace
-- local function create_virt_lines(lines)
--   local virt_lines = {}
--   for _, l in ipairs(lines) do
--     virt_lines[#virt_lines + 1] = { { l, 'ErrorMsg' } }
--   end
--   return virt_lines
-- end

-- function M.show_eob()
--   vim.api.nvim_buf_set_extmark(0, _ns_general, vim.fn.line('$') - 1, 0, {
--     virt_lines = create_virt_lines { 'END OF BUFFER' },
--   })
-- end

-- vim.api.nvim_create_autocmd('BufEnter', {
--   callback = M.show_eob,
-- })

return M
