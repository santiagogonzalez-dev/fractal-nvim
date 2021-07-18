----  SETTINGS  ----

-- Local variables --
local opt = vim.opt
local api = vim.api
local cmd = vim.cmd
local g = vim.g

opt.conceallevel = 0 -- Show text normally
opt.pumheight = 10 -- Pop up menu height
opt.showmode = false -- Hides/shows mode status below status line
opt.splitbelow = true -- Force splits to go below current window
opt.splitright = true -- Force all vertical splits to go to the right of current window
opt.timeoutlen = 333 -- Time given for doing a sequence
opt.updatetime = 333 -- Faster completion
opt.swapfile = false -- It does (not) creates a swapfile
opt.undofile = true -- Persistent undo
opt.expandtab = true -- Convert tabs to spaces
opt.shiftwidth = 4 -- Number of spaces for indentation
opt.tabstop = 4 -- Tab length
opt.title = true -- Set the window title based on the value of titlestring
opt.wrap = false -- Do not wrap
opt.number = true -- Display line number on the side
opt.relativenumber = true -- Display line number relative to the cursor
opt.scrolloff = 8 -- Cursor does not reach top/bottom
opt.sidescrolloff = 8 -- Cursor does not reach sides
opt.clipboard = "unnamedplus" -- Uses the system clipboard
opt.fileencoding = "utf-8" -- The encode used in the file
opt.hidden = true -- It keeps buffers open in memory
opt.hlsearch = true -- ingremental search
opt.mouse = "a" -- mouse can select, paste and
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Smart case
opt.smartindent = true -- Smart identation
api.nvim_exec("highlight visual cterm=reverse gui=reverse", false) -- Visual mode reversed colors
api.nvim_exec("set list listchars=nbsp:¬,tab:»·,trail:·,extends:>", false) -- Show whitespaces
opt.colorcolumn = "120" -- Limiter line
opt.cursorline = true -- Draw line on cursor
opt.guifont = "JetBrainsMono Nerd Font:h19"
opt.termguicolors = false -- set term gui colors (most terminals support this)
opt.signcolumn = "yes" -- Show/hide signs column
opt.showtabline = 2 -- Show top tab bar
opt.completeopt = { "menuone", "noselect" } -- Menu options
opt.cmdheight = 1 -- Space for displaying messages in the command line
opt.guifont = "JetBrainsMono Nerd Font:h18"
-- g.colors_name = "tokyonight"
-- a.nvim_exec("let g:tokyonight_style = 'storm'", true)

--- VIM ONLY COMMANDS ---

cmd "filetype plugin on"
cmd "set inccommand=split"
cmd "set iskeyword+=-"
