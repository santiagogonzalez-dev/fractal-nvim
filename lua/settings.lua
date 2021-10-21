local opts = { noremap = true, silent = true }
local indent = 4

vim.o.timeoutlen = 333  -- Time given for doing a sequence
vim.o.updatetime = 333  -- Faster completion

vim.o.clipboard = 'unnamedplus'  -- Uses the system clipboard
vim.o.hidden = true  -- It keeps buffers open in memory
vim.o.grepprg = 'rg --vimgrep'  -- Grep command
vim.o.shell = 'zsh'  -- Shell to use for `!`, `:!`, `system()` etc.
vim.o.joinspaces = false  -- No double spaces with join after a dot
vim.o.compatible = false  -- 'compatible' is not set

vim.o.foldenable = true  -- Enable folds
vim.o.foldmethod = 'manual'  -- Method used for idents
vim.o.foldcolumn = 'auto'  -- Column to display where the folds are

vim.o.laststatus = 0  -- Mode of the status bar
vim.o.conceallevel = 0  -- Show text normally
vim.o.wrap = false  -- Wrap text
vim.o.mouse = 'a'  -- Mouse options, all enabled
vim.o.cmdheight = 1  -- Space for displaying messages in the command line
vim.o.splitbelow = true  -- Force splits to go below current window
vim.o.splitright = true  -- Force vertical splits to go to the right of current window
vim.o.title = true  -- Set the window title based on the value of titlestring
vim.o.showtabline = 2  -- Show top tab bar
vim.o.showmode = false  -- Hides/shows mode status below status line
vim.o.number = true  -- Display line number on the side
vim.o.relativenumber = true  -- Display line number relative to the cursor
vim.o.signcolumn = 'auto'  -- 'number' -- Always show signcolumn
vim.o.numberwidth = 3  -- Gutter column number width
vim.o.colorcolumn = '90'  -- Limiter line
vim.o.pumheight = 10  -- Pop up menu height
vim.o.pumblend = 15  -- Popup blend
vim.api.nvim_exec([[ highlight PmenuSel blend=0 ]], true)  -- Make the selected option in a solid color

-- Automatic toggling between line number modes
vim.api.nvim_exec([[
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup END
]], true)

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
vim.api.nvim_set_keymap('n', '<C-C>', 'b~', opts)  -- Capitalize word under cursor
-- Show cursor crosshair only in active window
vim.api.nvim_exec([[
    autocmd InsertLeave,WinEnter * set cursorline cursorcolumn
    autocmd InsertEnter,WinLeave * set nocursorline nocursorcolumn
]], true)
vim.opt.guifont = 'Iosevka Term:h16'  -- Font used in GUI applications
-- vim.opt.guifont = 'JetBrains Mono:h15'  -- Font used in GUI applications
-- vim.opt.guifont = 'Fira Code:h15'  -- Font used in GUI applications
vim.opt.guicursor='v:hor50'  -- Fixes blinking in visual mode

vim.o.swapfile = false  -- It does (not) creates a swapfile
vim.o.undofile = true  -- Persistent undo - undo after you re-open the file
vim.o.undolevels = 10000  -- Levels of undoing
vim.o.history = 100  -- Saved spaces in each table of history
vim.o.fileencoding = 'utf-8'  -- The encode used in the file
vim.o.path = '**'  -- Search files recursively

vim.o.wildmenu = true  -- Enables 'enhanced mode' of command-line completion
vim.o.wildmode= 'longest:full,full'  -- Options for wildmenu
vim.o.winblend = 0  -- Enable transparency in floating windows and menus
vim.o.wildignore = '*.o,*.rej,*.so'  -- File patterns to ignore
vim.opt.sessionoptions:append { 'buffers', 'curdir', 'tabpages', 'winsize' }
vim.opt.completeopt:append { 'menuone', 'noselect', 'noinsert' }  -- Menu options

vim.o.expandtab = true  -- Convert tabs to spaces
vim.o.shiftround = true  -- Round indent to multiple of 'shiftwidth'
vim.o.shiftwidth = indent  -- Size of a > or < when indenting
vim.o.tabstop = indent  -- Tab length
vim.o.softtabstop = indent  -- Tab length
vim.o.smartindent = true  -- Smart indentation
vim.o.smarttab = true  -- Smart indentation
vim.o.autoindent = true  -- Copy indent from current line when starting a new line
-- Spaces used for indentation and tabs depending on the file extension
vim.api.nvim_exec([[ autocmd FileType html,css,scss,xml,xhtml setlocal shiftwidth=2 tabstop=2 ]], true)
vim.api.nvim_exec([[ autocmd FileType go setlocal shiftwidth=8 tabstop=8 ]], true)

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
    trail    = '␣',  -- Whitespaces will show up with this symbol
    -- tab      = '<->',  -- How TABs are represented
    -- space    = ' ',  -- Adding this space makes it appear on visual mode
    -- eol      = '↴',  -- You can see the \n with this
    -- trail    = '•',
    -- space    = '␣',
}

vim.opt.fillchars:append {
    diff     = '∙',
    -- eob      = ' ',  -- Commented out because I like the ~ at the end of the files
    -- vert     = ' ',
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

-- Neovide
vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_vfx_mode = 'sonicboom'
vim.g.neovide_cursor_antialiasing = 0

-- Quick actions
vim.api.nvim_set_keymap('n', '<Leader>;', '$a;<Esc>', opts)
vim.api.nvim_set_keymap('n', '<Leader>:', '$a:<Esc>', opts)
vim.api.nvim_set_keymap('n', '<Leader>,', '$a,<Esc>', opts)
vim.api.nvim_set_keymap('n', '<Leader>x', ':xa<CR>', opts)

-- Insert empty line without leaving normal mode
vim.api.nvim_set_keymap('n', '<Leader>o', 'o<Esc>', opts)
vim.api.nvim_set_keymap('n', '<Leader>O', 'O<Esc>', opts)

-- Switch buffers using TAB and SHIFT-TAB
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

-- May PageUp and PageDown
vim.api.nvim_set_keymap("n", "<PageUp>", ":bnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<PageDown>", ":bprev<CR>", opts)

-- Move current block
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', opts)
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>==', opts)
vim.api.nvim_set_keymap('x', '<C-j>', ":m '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap('x', '<C-k>', ":m '<-2<CR>gv-gv", opts)

-- Center searches
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)

-- Execute buffer with node
vim.api.nvim_set_keymap('n', '<Leader>bn', ':w !node<CR>', opts)  -- :!node %<CR>
vim.api.nvim_set_keymap('n', '<Leader>tn', ':terminal node %<CR>', opts)

-- Reselect selection after shifting code block
vim.api.nvim_set_keymap('x', '<', '<gv', opts)
vim.api.nvim_set_keymap('x', '>', '>gv', opts)

-- Toggle to show/hide searched terms
vim.api.nvim_set_keymap('n', '<C-N>', ':set hlsearch!<CR>', opts)

-- Undo break points
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', opts)
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', opts)
vim.api.nvim_set_keymap('i', '!', '!<C-g>u', opts)
vim.api.nvim_set_keymap('i', '?', '?<C-g>u', opts)
vim.api.nvim_set_keymap('i', ' ', ' <C-g>u', opts)
vim.api.nvim_set_keymap('i', '_', '_<C-g>u', opts)
vim.api.nvim_set_keymap('i', '<CR>', '<CR><C-g>u', opts)

-- Spell checking
vim.api.nvim_set_keymap('n', '<Leader>s', ':set spell!<CR>', opts)  -- Toggle spell checking
vim.o.spelllang = 'en,cjk'  -- Spell checking languages

-- Move between windows with
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', opts)
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', opts)

-- Rearrange windows using arrows
vim.api.nvim_set_keymap('n', '<down>', ':wincmd J<CR>', opts)
vim.api.nvim_set_keymap('n', '<left>', ':wincmd H<CR>', opts)
vim.api.nvim_set_keymap('n', '<up>', ':wincmd K<CR>', opts)
vim.api.nvim_set_keymap('n', '<right>', ':wincmd L<CR>', opts)

-- Highlight line and create mark
vim.cmd([[ nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR> ]])

-- Automatically reload file if contents changed
vim.api.nvim_exec([[autocmd FocusGained * :checktime]], true)

-- Write to all buffers when exit
vim.api.nvim_exec([[
    augroup ConfigGroup
        autocmd!
        autocmd FocusLost * silent! wa!
    augroup END
]], true)

-- Highlight on yank
vim.api.nvim_exec([[ autocmd TextYankPost * silent! lua vim.highlight.on_yank {} ]], true)

-- Yank until the end of line with Y
vim.api.nvim_set_keymap('n', 'Y', 'y$', opts)

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.api.nvim_exec([[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif ]], true)

-- Filetype set correctly
vim.api.nvim_exec([[ autocmd BufNewFile,BufRead *.conf set filetype=dosini ]], true)

-- Default filetype for files without extension
vim.api.nvim_exec([[ autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=markdown | endif ]], true)

-- Trim white spaces
vim.api.nvim_exec([[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
    augroup JIUMYLOVE
        autocmd!
        autocmd BufWritePre * :call TrimWhitespace()
    augroup END
]], true)

-- Disable delimiter line in certain type of files
vim.api.nvim_exec([[ autocmd FileType help,zsh,conf,dosini,text,markdown,html,javascript,typescript setlocal colorcolumn=0 ]], true)

-- Pairs
vim.api.nvim_exec([[ autocmd FileType c,cpp,java set mps+==:; ]], true)  -- Add = and ; as pairs for java, c and cpp
vim.opt.matchpairs:append { '<:>' }  -- Characters that shold be considered as pairs
vim.o.showmatch = false  -- Show match brace, set to false because :DoMatchParen does enough
vim.o.matchtime = 1  -- Time for showing matching brace
