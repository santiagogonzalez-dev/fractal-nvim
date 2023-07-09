local M = {}

function M.settings()
	vim.opt.spell = true
	vim.opt.spelllang = "en,es,de,cjk"
	vim.opt.spelloptions = "camel,noplainbuffer"
	vim.opt.spellsuggest = "best"
end

function M.setup()
   M.settings()
end

return M
