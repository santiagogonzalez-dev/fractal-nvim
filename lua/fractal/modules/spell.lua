local M = {}

function M.setup()
	vim.opt.spell = true
	vim.opt.spelllang = "en,es,de,cjk"
	vim.opt.spelloptions = "camel,noplainbuffer"
	vim.opt.spellsuggest = "best"
end

return M
