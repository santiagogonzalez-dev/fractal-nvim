local tab_lenght = 2
vim.opt_local.tabstop = tab_lenght
vim.opt_local.shiftwidth = tab_lenght
vim.opt_local.colorcolumn = '80,120'
vim.opt_local.textwidth = 80
vim.opt_local.conceallevel = 2
vim.opt.spell = true

for _, event in pairs(vim.api.nvim_get_autocmds({ group = '_enable_spell' })) do
	vim.api.nvim_del_autocmd(event.id)
end
