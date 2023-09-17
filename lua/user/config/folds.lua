local folds = {
	-- DESCRIPTION: Override default icons and settings related to folds, this
	-- includes the text that appears when you close a fold.
}

-- When a block of code is folded some text appears in the line of the fold,
-- this function reformats the code to be "smarter"
---@return string
function folds.foldtext_header()
	local AVOID = {
		import = "imports",
		from = "imports",
	}
	local header_fold = vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, false)

	for key, header in pairs(AVOID) do
		if header_fold[1]:match(key) then return header end
	end

	local clean_string = header_fold[1]:gsub("%(%)", ""):gsub("%{", ""):gsub("%=", ""):gsub("%:", " ")

	return clean_string
end

-- Fold settings
vim.opt.jumpoptions = "stack,view"
vim.wo.foldtext = 'v:lua.require("user.config.folds").foldtext_header()'
vim.wo.foldcolumn = "auto:3" -- Folds column
vim.wo.foldmethod = "manual"
-- vim.opt.foldmethod = 'expr'
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldopen = vim.opt.foldopen - "search"

vim.opt.fillchars:append({
	fold = "─",
	foldclose = "󰅂",
	foldopen = "󰅀",
})

return folds
