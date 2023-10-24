local tab_lenght = 2
vim.opt_local.tabstop = tab_lenght
vim.opt_local.shiftwidth = tab_lenght
vim.opt_local.colorcolumn = "80,81"
vim.opt_local.textwidth = 0
vim.opt_local.conceallevel = 2
-- vim.opt_local.concealcursor = "v"
vim.opt_local.wrap = true

vim.opt.listchars:append({
	multispace = "   ",
})
