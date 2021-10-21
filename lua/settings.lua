-- NEOVIM SETTINGS --


vim.o.spelllang = 'en,cjk'  -- Spell checking languages
vim.o.timeoutlen = 333  -- Time given for doing a sequence
vim.o.updatetime = 333  -- Faster completion
vim.o.clipboard = 'unnamedplus'  -- Uses the system clipboard
vim.o.hidden = true  -- It keeps buffers open in memory
vim.o.grepprg = 'rg --vimgrep'  -- Grep command
vim.o.shell = 'zsh'  -- Shell to use for `!`, `:!`, `system()` etc.
vim.o.joinspaces = false  -- No double spaces with join after a dot
vim.o.history = 100  -- Saved spaces in each table of history
vim.o.compatible = false  -- 'compatible' is not set

vim.o.foldenable = true  -- Enable folds
vim.o.foldmethod = 'manual'  -- Method used for idents
vim.o.foldcolumn = 'auto'  -- Column to display where the folds are

vim.o.laststatus = 0  -- Mode of the status bar
vim.o.conceallevel = 0  -- Show text normally
vim.o.wrap = false  -- Wrap text
vim.o.mouse = 'a'  -- Mouse options
vim.o.cmdheight = 1  -- Space for displaying messages in the command line
vim.o.splitbelow = true  -- Force splits to go below current window
vim.o.splitright = true  -- Force vertical splits to go to the right of current window
vim.o.title = true  -- Set the window title based on the value of titlestring
vim.o.showtabline = 2  -- Show top tab bar
vim.o.showmode = false  -- Hides/shows mode status below status line
vim.o.showmatch = false  -- Show match brace, set to false because :DoMatchParen does enough
vim.opt.matchpairs:append { '<:>' }  -- Characters that shold be considered as pairs
vim.o.matchtime = 1  -- Time for showing matching brace
vim.o.number = true  -- Display line number on the side
vim.o.relativenumber = true  -- Display line number relative to the cursor
vim.o.signcolumn = 'number'  -- 'number' -- Always show signcolumn
vim.o.numberwidth = 3  -- Gutter column number width
vim.o.colorcolumn = '90'  -- Limiter line
vim.o.pumheight = 10  -- Pop up menu height
vim.o.pumblend = 15  -- Popup blend
vim.api.nvim_exec([[ highlight PmenuSel blend=0 ]], true)  -- Make the selected option in a solid color

vim.o.confirm = true  -- Confirm dialogs
vim.o.backspace = 'indent,start,eol'  -- Make backspace behave like normal again
vim.opt.cpoptions:append 'nm'  -- See :help cpoptions, this are the defaults aABceFs_
vim.opt.shm:append 'c'  -- Helps to avoid all the |hit-enter| prompts
vim.opt.iskeyword:remove '_'  -- Word separators
vim.opt.tags:append './tags;,tags'  -- Where to search for ctags

vim.wo.cursorline = true  -- Draw line on cursor
vim.wo.cursorcolumn = true  -- Draw line on cursor
vim.wo.scrolloff = 9  -- Cursor does not reach top/bottom
vim.wo.sidescrolloff = 9  -- Cursor does not reach sides
-- vim.opt.guicursor='v:hor50'  -- Fixes blinking in visual mode

vim.o.swapfile = false  -- It does (not) creates a swapfile
vim.o.undofile = true  -- Persistent undo - undo after you re-open the file
vim.o.undolevels = 10000  -- Levels of undoing
vim.o.fileencoding = 'utf-8'  -- The encode used in the file
vim.o.path = '**'  -- Search files recursively

vim.o.wildmenu = true  -- Enables 'enhanced mode' of command-line completion
vim.o.wildmode= 'longest:full,full'  -- Options for wildmenu
vim.o.winblend = 0  -- Enable transparency in floating windows and menus
vim.o.wildignore = '*.o,*.rej,*.so'  -- File patterns to ignore
vim.opt.sessionoptions:append { 'buffers', 'curdir', 'tabpages', 'winsize' }
vim.opt.completeopt:append { 'menuone', 'noselect', 'noinsert' }  -- Menu options

local indent = 4
vim.o.expandtab = true  -- Convert tabs to spaces
vim.o.shiftround = true  -- Round indent to multiple of 'shiftwidth'
vim.o.shiftwidth = indent  -- Size of a > or < when indenting
vim.o.tabstop = indent  -- Tab length
vim.o.softtabstop = indent  -- Tab length
vim.o.smartindent = true  -- Smart indentation
vim.o.smarttab = true  -- Smart indentation
vim.o.autoindent = true  -- Copy indent from current line when starting a new line

vim.o.ignorecase = true  -- Ignore case
vim.o.smartcase = true  -- Smart case
vim.o.lazyredraw = false  -- Lazy redraw the screen
vim.o.redrawtime = 600  -- Time for redrawing the display
vim.o.hlsearch = true  -- Highlighting search
vim.o.incsearch = true  -- Incremental search
vim.o.inccommand = 'nosplit'  -- Live preview of :s results

vim.o.list = true  -- Show invisible characters
vim.o.showbreak = '↪'  -- Shows when text is being wrapped
vim.o.linebreak = true

vim.opt.listchars:append {
    nbsp     = '␣',
    extends  = '»',
    precedes = '«',
    tab      = '<->',  -- How TABs are represented
    trail    = '␣',  -- Whitespaces will show up with this symbol
    -- space    = ' ',  -- Adding this space makes it appear on visual mode
    -- eol      = ' ',  -- Adding this space makes it appear on visual mode
    -- eol      = '↴',  -- If you want to know where is a \n
    -- trail    = '•',
    -- space    = '␣',
}

vim.opt.fillchars:append {
    diff     = '∙',
    -- eob      = ' ',  -- Commented out because I like the ~ at the end of the file
    -- vert     = ' ',
    -- fold     = ' ',
    -- fold     = '·',
}

-- Give fenced codeblock in markdown files
vim.g.markdown_fenced_languages = {
    'bash',
    'rust',
    'python',
    'html',
    'javascript',
    'typescript',
    'css',
    'scss',
    'lua',
    'java',
    'vim',
}

-- In case you misspell commands
vim.api.nvim_exec([[
abbr slef self
abbr cosntants constants
abbr unkown unknown
abbr clas class
abbr krags kwargs
abbr __clas__ __class__
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qa! qa!
cnoreabbrev Wqa! wqa!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Wqa wqa
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
]], true)


-- NEOVIDE --

vim.opt.guifont = 'Iosevka Term:h16'  -- Font used in GUI applications
-- vim.opt.guifont = 'JetBrains Mono:h15'  -- Font used in GUI applications
-- vim.opt.guifont = 'Fira Code:h15'  -- Font used in GUI applications

vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_vfx_mode = 'sonicboom'
vim.g.neovide_cursor_antialiasing = 0
