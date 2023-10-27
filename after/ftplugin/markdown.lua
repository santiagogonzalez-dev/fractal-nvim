local tab_lenght = 2
vim.opt_local.tabstop = tab_lenght
vim.opt_local.shiftwidth = tab_lenght
vim.opt_local.colorcolumn = "80,81"
vim.opt_local.textwidth = 0
vim.opt_local.conceallevel = 0
-- vim.opt_local.concealcursor = "v"
vim.opt_local.wrap = true

vim.opt.listchars:append({
	multispace = "   ",
})

---@diagnostic disable: param-type-mismatch
vim.keymap.set("n", "<CR>", function()
	local line = vim.fn.getline(".")
	local cur = vim.api.nvim_win_get_cursor(0)

	for i = cur[2] + 1, #line - 1 do
		if string.sub(line, i, i + 1) == "](" then
			vim.api.nvim_win_set_cursor(0, { cur[1], cur[2] + i - cur[2] + 1 })
			if vim.fn.expand("<cfile>:e") == "md" then
				vim.api.nvim_feedkeys("gf", "n", false)
			else
				vim.cmd("call jobstart(['xdg-open', expand('<cfile>:p')], {'detach': v:true})")
			end
			return
		elseif i ~= cur[2] + 1 and string.sub(line, i, i) == "[" then
			break
		end
	end

	for i = cur[2] + 1, 2, -1 do
		if string.sub(line, i - 1, i) == "](" then
			vim.api.nvim_win_set_cursor(0, { cur[1], i })
			if vim.fn.expand("<cfile>:e") == "md" then
				vim.api.nvim_feedkeys("gf", "n", false)
			else
				vim.cmd("call jobstart(['xdg-open', expand('<cfile>:p')], {'detach': v:true})")
			end
			return
		elseif i ~= cur[2] + 1 and string.sub(line, i, i) == ")" then
			break
		end
	end
end, { buffer = true })
