local tab_lenght = 2
vim.opt_local.tabstop = tab_lenght
vim.opt_local.shiftwidth = tab_lenght
vim.opt_local.colorcolumn = "80,100"
vim.opt_local.textwidth = 90
vim.opt_local.conceallevel = 2

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.cmd([[syntax match hidechars '\'' conceal " cchar= ]])
		vim.cmd([[syntax match hidechars '\"' conceal " cchar= ]])
		vim.cmd([[syntax match hidechars '\[\[' conceal " cchar= ]])
		vim.cmd([[syntax match hidechars '\]\]' conceal " cchar= ]])
		vim.cmd([[syntax match hidechars '=' conceal " cchar= ]])
	end,
})
