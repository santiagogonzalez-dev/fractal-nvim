---  SETTINGS  ---

local o = vim.opt
local a = vim.api
local g = vim.g

o.conceallevel = 0
o.pumheight = 10
o.showmode = true
o.number = true
o.splitbelow = true
o.splitright = true
o.timeoutlen = 333
o.updatetime = 333
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.wrap = false
o.linebreak = false
o.relativenumber = true
o.scrolloff = 8
o.clipboard = "unnamedplus"
o.fileencoding = "utf-8"
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.mouse = "a"
o.smartcase = true
o.smartindent = true
a.nvim_exec("highlight visual cterm=reverse gui=reverse", false)
a.nvim_exec("set list listchars=nbsp:¬,tab:»·,trail:·,extends:>", false)
o.colorcolumn = "80" -- fix indentline for now
-- vim.opt.completeopt = { "menuone", "noselect" }
o.cursorline = false
-- vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
-- vim.opt.guifont = "JetBrainsMono Nerd Font:h18"
o.guifont = "JetBrainsMono Nerd Font:h19"
-- vim.opt.showtabline = 2 -- always show tabs
o.termguicolors = true -- set term gui colors (most terminals support this)
g.colors_name = "tokyonight"
a.nvim_exec("let g:tokyonight_style = 'storm'", true)
o.signcolumn = "yes"
