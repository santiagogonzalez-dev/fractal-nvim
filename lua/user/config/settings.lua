-- local opts = vim.iter({
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 2
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.grepprg = "rg --hidden --no-heading --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.infercase = true
vim.opt.lazyredraw = false
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.matchpairs = "(:),{:},[:],<:>"
vim.opt.modeline = false
vim.opt.mousefocus = true
vim.opt.mousescroll = "ver:8,hor:8"
vim.opt.pumblend = 9
vim.opt.pumheight = 6
vim.opt.scrolloff = 999999
vim.opt.secure = true
vim.opt.shiftround = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.shiftwidth = 3 -- Default size of a > or < when indenting
vim.opt.shortmess = "oOstIFSmnrw"
vim.opt.showbreak = "↪ "
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.sidescrolloff = 8
vim.opt.smartcase = true
vim.opt.smartindent = true
-- vim.opt.smoothscroll = true
vim.opt.softtabstop = -1
vim.opt.spell = true
vim.opt.spelllang = "en_us,es_es,es_mx,cjk,de,la"
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.spellsuggest = "best"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.synmaxcol = 160
vim.opt.tabstop = 3 -- Default tab length
vim.opt.tags = "vim.lsp.tagfunc"
vim.opt.textwidth = 80
vim.opt.timeoutlen = 600
vim.opt.undofile = true
vim.opt.undolevels = 6000
vim.opt.updatetime = 30
vim.opt.virtualedit = "all" -- all bloc
vim.opt.whichwrap = "<,>,[,],h,l,b,s,~"
vim.opt.winblend = 9
vim.opt.wrap = false
-- })

-- opts:any(function(settings, value)
-- 	vim.opt[settings] = value
-- end)

vim.opt.fillchars:append({
	eob = "␃",
	-- msgsep = "🮑", -- Separator for cmdline
	msgsep = "⸻",
})

-- vim.opt.fillchars:append({
-- 	horiz = "━",
-- 	horizup = "┻",
-- 	horizdown = "┳",
-- 	vert = "┃",
-- 	vertleft = "┫",
-- 	vertright = "┣",
-- 	verthoriz = "╋",
-- })

vim.opt.fillchars:append({
	horiz = "─",
	horizup = "┴",
	horizdown = "┬",
	vert = "│",
	vertleft = "┤",
	vertright = "├",
	verthoriz = "┼",
})

-- vim.opt.fillchars:append({
-- 	horiz = ' ',
-- 	horizup = ' ',
-- 	horizdown = ' ',
-- 	vert = ' ',
-- 	vertleft = ' ',
-- 	vertright = ' ',
-- 	verthoriz = ' ',
-- })
--

vim.opt.jumpoptions:append("view")

vim.opt.listchars:append({
	-- eol = '↴', -- ↪ ↲ ⏎ 
	-- space = '·',
	extends = "◣",
	nbsp = "␣",
	precedes = "◢",
	multispace = "󱦰  ",
	-- tab = "󱦰  ",
	tab = " 󱦰 ",
	leadmultispace = "󱦰   ",
	trail = "█", -- · ␣
})

vim.fn.matchadd("ErrorMsg", "\\s\\+$")

-- vim.opt.formatoptions = vim.opt.formatoptions + "r" + "c" + "q" + "j" - "o" - "l" - "t"
vim.opt.formatoptions = vim.opt.formatoptions
	+ "r" -- continue comments after return
	+ "c" -- wrap comments using textwidth
	+ "q" -- allow to format comments w/ gq
	+ "j" -- remove comment leader when joining lines when possible
	- "t" -- don't autoformat
	- "a" -- no autoformatting
	- "o" -- don't continue comments after o/O
	- "2" -- don't use indent of second line for rest of paragraph

vim.opt.cpoptions = vim.opt.cpoptions + "n"

local function eval_unnamed_register()
	vim.cmd.lua(vim.fn.getreg('"'))
end
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

vim.api.nvim_create_autocmd({ "CmdlineEnter", "WinLeave", "BufLeave", "FocusLost" }, {
	-- There's vim.opt.autowrite vim.opt.autowritell but they are not exactly
	-- what I want.
	desc = "Auto save when leaving the nvim window",
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
	local closers = { ")", "]", "}", ">", "'", '"', "`", ",", "=" }
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
vim.g.colorscheme = "jetjbp"
