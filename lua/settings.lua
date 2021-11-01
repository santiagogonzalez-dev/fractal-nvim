vim.o.laststatus = 0 -- Mode of the status bar
vim.o.conceallevel = 2 -- Show text normally
vim.o.mouse = 'a' -- Mouse options, all enabled
vim.o.mousefocus = true -- Focusing cursor on the window with the keyboard focus
vim.o.cmdheight = 1 -- Space for displaying messages in the command line
vim.o.splitbelow = true -- Force splits to go below current window
vim.o.splitright = true -- Force vertical splits to go to the right of current window
vim.o.title = true -- Set the window title based on the value of titlestring
vim.o.showmode = false -- Show or hide the mode you are on in the status line
vim.o.number = true -- Display line number on the side
vim.o.relativenumber = true -- Display line number relative to the cursor
vim.o.signcolumn = 'auto' -- 'number' -- Always show signcolumn
vim.o.numberwidth = 3 -- Gutter column number width
vim.o.colorcolumn = '90' -- Limiter line
vim.o.textwidth = 120
vim.o.clipboard = 'unnamedplus' -- Uses the system clipboard
vim.o.termguicolors = true -- Enable colors in the terminal
vim.o.grepprg = 'rg --vimgrep' -- Grep command
vim.o.shell = 'zsh' -- Shell to use for `!`, `:!`, `system()` etc.
vim.o.joinspaces = false -- No double spaces with join after a dot
vim.o.compatible = false -- 'compatible' is not set
vim.o.ruler = true
vim.o.guifont = 'Iosevka Term:h16' -- Font for GUIs -- JetBrains Mono:h15 Fira Code:h15
vim.o.pumheight = 10 -- Pop up menu height
vim.o.pumblend = 15 -- Transparency for the pop up menu
vim.o.spelllang = 'en,cjk' -- Spell checking languages
vim.o.showtabline = 0  -- Show top tab bar
vim.o.hidden = true -- It keeps buffers open in memory
vim.o.lazyredraw = true -- Lazy redraw the screen
vim.o.redrawtime = 600 -- Time for redrawing the display
vim.o.inccommand = 'split' -- Shows just like nosplit, but partially off-screen
vim.o.foldenable = true -- Enable folds
vim.o.foldmethod = 'manual' -- Method used for idents
vim.o.foldcolumn = 'auto' -- Column to display where the folds are
vim.o.timeoutlen = 300 -- Time given for doing a sequence
vim.o.updatetime = 600 -- Faster completion
vim.o.wrap = true -- Wrap text
vim.o.showbreak = '↪' -- Shows when text is being wrapped
vim.o.confirm = true -- Confirm dialogs
vim.o.backspace = 'indent,start,eol' -- Make backspace behave like normal again
vim.opt.cpoptions:append 'nm' -- See :help cpoptions, this are the defaults aABceFs_
vim.opt.tags:append './tags;,tags' -- Where to search for ctags

vim.o.cursorline = true -- Draw line on cursor
vim.o.cursorcolumn = true -- Draw line on cursor
vim.o.scrolloff = 6 -- Cursor does not reach top/bottom
vim.o.sidescrolloff = 12 -- Cursor does not reach sides
vim.opt.guicursor:append { 'v:hor50', 'i:ver25-iCursor' } -- Better cursor for visual mode

vim.o.swapfile = false -- It does (not) creates a swapfileWage
vim.o.undofile = true -- Persistent undo - undo after you re-open the file
vim.o.undolevels = 10000 -- Levels of undoing
vim.o.history = 100 -- Saved spaces in each table of history
vim.o.fileencoding = 'utf-8' -- Enconding used for files
vim.o.path = '**' -- Search files recursively
vim.o.backupdir = '/tmp/nvim'
vim.o.directory = '/tmp/nvim'
vim.o.undodir = '/tmp/nvim'

vim.o.wildmenu = true -- Enables 'enhanced mode' of command-line completion
vim.o.wildmode= 'longest:full,full' -- Options for wildmenu
vim.o.wildignore = '*.o,*.rej,*.so' -- File patterns to ignore
vim.o.wildcharm = 26 -- Trigger completion in macros
vim.o.wildignorecase = true -- Ignore case command completion menu
vim.o.winblend = 3 -- Enable transparency in floating windows and menus
vim.opt.sessionoptions:append { 'buffers', 'curdir', 'tabpages', 'winsize' }
vim.opt.completeopt:append { 'menuone', 'noselect', 'noinsert' } -- Menu options
vim.opt.shortmess:append 'IFawsc' -- Less and shorter messages in command line

vim.o.smartindent = true -- Smart indentation
vim.o.smarttab = true -- Smart indentation
vim.o.autoindent = true -- Copy indent from current line when starting a new line
vim.o.ignorecase = true -- Ignore case
vim.o.smartcase = true -- Smart case
vim.o.expandtab = false -- Convert tabs to spaces
vim.o.tabstop = 4 -- Tab length
vim.o.shiftround = true -- Round indent to multiple of 'shiftwidth'
vim.o.shiftwidth = 4 -- Size of a > or < when indenting
vim.o.softtabstop = -1 -- Tab length, if negative shiftwidth value is used

vim.o.hlsearch = true -- Highlighting search
vim.o.incsearch = true -- Incremental search
vim.o.showmatch = false -- Show match brace, set to false because :DoMatchParen does enough
vim.o.matchtime = 1 -- Time for showing matching brace
vim.opt.matchpairs:append { '<:>' } -- Characters that shold be considered as pairs

vim.o.list = true -- Show invisible characters
vim.opt.listchars:append { nbsp = '␣', extends = '»', precedes = '«', trail = '␣', tab  = '  ', --[[ eol  = '↴' --]] }
vim.opt.fillchars:append { diff = '∙', vert = '┃', fold = '·', foldopen = '▾', foldsep = '│', foldclose = '▸' }


local map = vim.api.nvim_set_keymap
local nore_sil = { noremap = true, silent = true }
local nore_exp_sil = { noremap = true, expr = true, silent = true }

map('n', '<Leader>;', '$a;<Esc>', nore_sil) -- Insert a semicolon
map('n', '<Leader>:', '$a:<Esc>', nore_sil) -- Insert a colon
map('n', '<Leader>,', '$a,<Esc>', nore_sil) -- Insert a comma
map('v', '<Leader>,', ":'<,'>norm A,<Cr>", nore_sil) -- Insert a comma in v-mode
map('n', '<Leader>x', ':wqa<Cr>', nore_sil) -- Write into all buffers and quit
map('n', '<Leader>e', ':w | :e%<Cr>zz', nore_sil) -- Write and reload the file
map('n', '<Leader>bw', ':bw<Cr>', nore_sil) -- Close buffer
map('n', '<Leader>s', ':set spell!<Cr>', nore_sil) -- Toggle spell checking
map('n', '<Leader>n', ':set hlsearch!<Cr>', nore_sil) -- Highlight toggle for searched words

-- Move between windows with
map('n', '<A-h>', '<C-w>h', nore_sil)
map('n', '<A-l>', '<C-w>l', nore_sil)
map('n', '<A-j>', '<C-w>j', nore_sil)
map('n', '<A-k>', '<C-w>k', nore_sil)

-- Move current block
map('n', '<C-j>', ':m .+1<Cr>==', nore_sil)
map('n', '<C-k>', ':m .-2<Cr>==', nore_sil)
map('x', '<C-j>', ":m '>+1<Cr>gv-gv", nore_sil)
map('x', '<C-k>', ":m '<-2<Cr>gv-gv", nore_sil)

-- Center searches
map('n', 'n', 'nzzzv', nore_sil)
map('n', 'N', 'Nzzzv', nore_sil)

-- Reselect selection after shifting code block
map('x', '<', '<gv', nore_sil)
map('x', '>', '>gv', nore_sil)

-- Highlight last pasted code with gvp
vim.cmd([[ nnoremap <expr> gvp '`[' . strpart(getregtype(), 0, 1) . '`]' ]])

-- Switch buffers using TAB and SHIFT-TAB
map('n', '<Tab>', ':bnext<Cr>', nore_sil)
map('n', '<S-Tab>', ':bprevious<Cr>', nore_sil)

-- Undo break points
map('i', ',', ',<C-g>u', nore_sil)
map('i', '.', '.<C-g>u', nore_sil)
map('i', '!', '!<C-g>u', nore_sil)
map('i', '?', '?<C-g>u', nore_sil)
map('i', ' ', ' <C-g>u', nore_sil)
map('i', '_', '_<C-g>u', nore_sil)
map('i', '-', '-<C-g>u', nore_sil)
map('i', '=', '=<C-g>u', nore_sil)
map('i', '<Cr>', '<Cr><C-g>u', nore_sil)

-- Better navigation inside wrapped text
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", nore_exp_sil)
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", nore_exp_sil)


-- Add = and ; as pairs for java, c and cpp
vim.cmd([[ au FileType c,cpp,java set mps+==:; ]])

-- Automatically reload file if contents changed
vim.cmd([[ au FocusGained * :checktime ]])

-- Straight red underline instead of curly line
vim.cmd([[ au BufRead * highlight SpellBad guibg=NONE guifg=NONE gui=underline guisp=red ]])

-- Highlight on yank
vim.cmd([[ au TextYankPost * silent! lua vim.highlight.on_yank {} ]])

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"zz" | endif ]])

-- Filetype set correctly
vim.cmd([[ au BufNewFile,BufRead *.conf set filetype=dosini ]])

-- Default syntax highlighting for files without extension
vim.cmd([[ au BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=markdown | endif ]])

-- Trim whitespace on save
vim.cmd([[ au BufWritePre * :%s/\s\+$//e ]])

-- Indentation override for this type of files
vim.cmd([[ au FileType html,css,scss,xml,xhtml setlocal shiftwidth=2 tabstop=2 ]])
vim.cmd([[ au FileType go setlocal shiftwidth=8 tabstop=8 ]])

-- Highlight words matching the word under cursor, other colors :so $VIMRUNTIME/syntax/hitest.vim
vim.cmd([[ au CursorMoved * exe printf('match DiagnosticVirtualTextWarn /\V\<%s\>/', escape(expand('<cword>'), '/\')) ]])

-- Show cursor only in active window
vim.cmd([[ au InsertLeave,WinEnter * set cursorline cursorcolumn ]])
vim.cmd([[ au InsertEnter,WinLeave * set nocursorline nocursorcolumn ]])

-- Colors in visual mode
vim.cmd([[ au ColorScheme * highlight Visual cterm=reverse gui=reverse ]])

-- Disable delimiter line in certain type of files
vim.cmd([[ au FileType help,zsh,conf,dosini,text,markdown,html setlocal colorcolumn=0 ]])


-- Hide last run command in the command line after 3 seconds
vim.cmd([[
	aug cmdline
		au!
		au CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 6000)
	aug END
]])

-- Write to all buffers when exit
vim.cmd([[
	aug ConfigGroup
		au!
		au FocusLost * silent! wa!
	aug END
]])

-- Switch to numbers when in insert mode, and to relative numbers when in command mode
vim.cmd([[
	aug numbertoggle
		au!
		au BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
		au BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
	aug END
]])


-- Make the selected option in a solid color
vim.cmd([[ highlight PmenuSel blend=0 ]])

-- Insert cursor in orange
vim.cmd([[ highlight iCursor guifg=white guibg=orange ]])
