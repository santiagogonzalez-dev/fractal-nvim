----  SETTINGS  ----

-- Local variables --

vim.opt.conceallevel = 0 -- Show text normally
vim.opt.pumheight = 10 -- Pop up menu height
vim.opt.showmode = false -- Hides/shows mode status below status line
vim.opt.splitbelow = true -- Force splits to go below current window
vim.opt.splitright = true -- Force all vertical splits to go to the right of current window
vim.opt.timeoutlen = 333 -- Time given for doing a sequence
vim.opt.updatetime = 333 -- Faster completion
vim.opt.swapfile = false -- It does (not) creates a swapfile
vim.opt.undofile = true -- Persistent undo
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Number of spaces for indentation
vim.opt.tabstop = 4 -- Tab length
vim.opt.title = true -- Set the window title based on the value of titlestring
vim.opt.wrap = false -- Do not wrap
vim.opt.number = true -- Display line number on the side
vim.opt.relativenumber = true -- Display line number relative to the cursor
vim.opt.scrolloff = 8 -- Cursor does not reach top/bottom
vim.opt.sidescrolloff = 8 -- Cursor does not reach sides
vim.opt.clipboard = "unnamedplus" -- Uses the system clipboard
vim.opt.fileencoding = "utf-8" -- The encode used in the file
vim.opt.hidden = true -- It keeps buffers open in memory
vim.opt.hlsearch = true -- ingremental search
vim.opt.mouse = "a" -- mouse can select, paste and
vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true -- Smart case
vim.opt.smartindent = true -- Smart identation
vim.api.nvim_exec("highlight visual cterm=reverse gui=reverse", false) -- Visual mode reversed colors
vim.api.nvim_exec("set list listchars=nbsp:¬,tab:»·,trail:·,extends:>", false) -- Show whitespaces
vim.opt.colorcolumn = "120" -- Limiter line
vim.opt.cursorline = true -- Draw line on cursor
vim.opt.guifont = "JetBrainsMono Nerd Font:h19"
vim.opt.termguicolors = false -- set term gui colors (most terminals support this)
vim.opt.signcolumn = "yes" -- Show/hide signs column
vim.opt.showtabline = 2 -- Show top tab bar
vim.opt.completeopt = { "menuone", "noselect" } -- Menu options
vim.opt.cmdheight = 1 -- Space for displaying messages in the command line
vim.opt.guifont = "JetBrainsMono Nerd Font:h18"
-- vim.g.colors_name = "tokyonight"
-- vim.a.nvim_exec("let g:tokyonight_style = 'storm'", true)

--- VIM ONLY COMMANDS ---

vim.cmd "filetype plugin on"
vim.cmd "set inccommand=split"
vim.cmd "set iskeyword+=-"
