local opts = vim.iter({
	smartcase = true,
	smartindent = true,
	expandtab = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	synmaxcol = 160,
	conceallevel = 2,
	timeoutlen = 600,
	undofile = true,
	undolevels = 6000,
	updatetime = 30,
	virtualedit = "all",
	whichwrap = "<,>,[,],h,l,b,s,~",
	tags = "vim.lsp.tagfunc",
	winblend = 9,
	pumblend = 9,
	list = true,
	textwidth = 80,
	confirm = true,
	softtabstop = -1,
	scrolloff = 999999,
	grepprg = "rg --hidden --no-heading --vimgrep",
	clipboard = "unnamedplus",
	ignorecase = true,
	inccommand = "split",
	infercase = true,
	joinspaces = true,
	matchpairs = "(:),{:},[:],<:>",
	diffopt = "foldcolumn:0,hiddenoff,vertical",
	lazyredraw = false,
	mousefocus = true,
	mousescroll = "ver:8,hor:8",
	modeline = false,
	sidescrolloff = 8,
	secure = true,
	shiftround = true,
	shortmess = "oOstIFS",
	pumheight = 6,
	wrap = false,
	breakindent = true,
	linebreak = true,
	showbreak = "↪ ",
	-- showbreak = string.rep(" ", 3),
	showmode = false,
	showtabline = 0,
	smoothscroll = true,
	spell = true,
	spelllang = "en,es,de,cjk",
	spelloptions = "camel,noplainbuffer",
	spellsuggest = "best",
	-- hidden = false,
})

opts:any(function(settings, value) vim.opt[settings] = value end)

-- Settings for non-visible characters
vim.opt.fillchars:append({
	eob = "␃",
	-- msgsep = "🮑", -- Separator for cmdline
	msgsep = "⸻",
})

-- Window separators
vim.opt.fillchars:append({
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
})

-- vim.opt.fillchars:append({
-- 	horiz = "─",
-- 	horizup = "┴",
-- 	horizdown = "┬",
-- 	vert = "│",
-- 	vertleft = "┤",
-- 	vertright = "├",
-- 	verthoriz = "┼",
-- })

-- vim.opt.fillchars:append({
-- 	horiz = ' ',
-- 	horizup = ' ',
-- 	horizdown = ' ',
-- 	vert = ' ',
-- 	vertleft = ' ',
-- 	vertright = ' ',
-- 	verthoriz = ' ',
-- })

vim.opt.listchars:append({
	-- eol = '↴', -- ↪ ↲ ⏎ 
	-- space = '·',
	extends = "◣",
	nbsp = "␣",
	precedes = "◢",
	multispace = "󱦰  ",
	tab = "󱦰  ",
	leadmultispace = "󱦰   ",
	trail = "█", -- · ␣
})

vim.fn.matchadd("ErrorMsg", "\\s\\+$")

vim.opt.formatoptions = vim.opt.formatoptions + "r" + "c" + "q" + "j" - "o" - "l"

vim.opt.cpoptions = vim.opt.cpoptions + "n"

local function eval_unnamed_register() vim.cmd.lua(vim.fn.getreg('"')) end
vim.api.nvim_create_user_command("EvalYankRegister", eval_unnamed_register, {})

vim.api.nvim_create_autocmd({
	"WinLeave",
	"BufLeave",
	"FocusLost",
	"InsertLeave",
}, {
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.api.nvim_command("silent update")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	desc = "Auto save",
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.api.nvim_command("silent update")
		end
	end,
})

vim.api.nvim_create_user_command("FoldMarkdown", function()
	local current_line = vim.fn.line(".") -- Get current line number
	local next_header = vim.fn.search("^#", "Wn") -- Search for the next header

	-- If a next header is found, fold from current line to the line before the next header
	if next_header < 0 then return end

	vim.cmd(string.format("%d,%dfold", current_line, next_header - 2))
end, {})

local tab_out = function()
	local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
	local line = vim.api.nvim_get_current_line()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local after = line:sub(col + 1, -1)
	local closer_col = #after + 1
	local closer_i = nil
	for i, closer in ipairs(closers) do
		local cur_index, _ = after:find(closer)
		if cur_index and (cur_index < closer_col) then
			closer_col = cur_index
			closer_i = i
		end
	end

	if closer_i then
		vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
	else
		vim.api.nvim_win_set_cursor(0, { row, col + 1 })
	end
end

vim.keymap.set("i", "<C-l>", tab_out, { noremap = true, silent = true })
