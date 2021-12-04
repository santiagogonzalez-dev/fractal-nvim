local options = {
    laststatus = 0,                 -- Mode of the status bar
    conceallevel = 2,               -- Show text normally
    mouse = 'a',                    -- Mouse options, all enabled
    mousefocus = true,              -- Focusing cursor on the window with the keyboard focus
    cmdheight = 1,                  -- Space for displaying messages in the command line
    splitbelow = true,              -- Force splits to go below current window
    splitright = true,              -- Force vertical splits to go to the right of current window
    title = true,                   -- Set the window title based on the value of titlestring
    showmode = false,               -- Show or hide the mode you are on in the status line
    number = true,                  -- Display line number on the side
    relativenumber = true,          -- Display line number relative to the cursor
    signcolumn = 'yes',             -- 'number' -- Always show signcolumn
    numberwidth = 3,                -- Gutter column number width
    colorcolumn = '90',             -- Limiter line
    textwidth = 90,                 -- Delimit text blocks to 90 columns
    clipboard = 'unnamedplus',      -- Uses the system clipboard
    termguicolors = true,           -- Enable colors in the terminal
    grepprg = 'rg --vimgrep',       -- Grep command
    shell = 'zsh',                  -- Shell to use for `!`, `:!`, `system()` etc.
    ruler = true,                   -- Show the line and column number of the cursor position
    guifont = 'Iosevka Term:h19',   -- Font for GUIs -- JetBrains Mono:h15 Fira Code:h15
    pumheight = 20,                 -- Pop up menu height
    pumblend = 15,                  -- Transparency for the pop up menu
    spelllang = 'en,cjk',           -- Spell checking languages
    spelloptions = 'camel',         -- Options for spell checking
    showtabline = 0,                -- Show top tab bar
    hidden = true,                  -- It keeps buffers open in memory
    joinspaces = false,             -- No double spaces with join after a dot
    compatible = false,             -- 'compatible' is not set
    lazyredraw = true,              -- Lazy redraw the screen
    redrawtime = 600,               -- Time for redrawing the display
    inccommand = 'split',           -- Shows just like nosplit, but partially off-screen
    foldenable = true,              -- Enable folds
    foldmethod = 'manual',          -- Method used for idents
    foldcolumn = 'auto',            -- Column to display where the folds are
    timeoutlen = 400,               -- Time given for doing a sequence
    updatetime = 600,               -- Faster completion
    wrap = false,                    -- Wrap text
    showbreak = '↪ ',               -- Shows when text is being wrapped
    confirm = true,                 -- Confirm dialogs
    backspace = 'indent,start,eol', -- Make backspace behave like normal again
    exrc = true,                    -- Use local .nvimrc or .exrc
    cursorline = true,              -- Draw line on cursor
    cursorcolumn = true,            -- Draw line on cursor
    scrolloff = 8,                  -- Cursor does not reach top/bottom
    sidescrolloff = 8,              -- Cursor does not reach sides
    swapfile = false,               -- It does (not) creates a swapfileWage
    undofile = true,                -- Persistent undo - undo after you re-open the file
    undolevels = 10000,             -- Levels of undoing
    history = 100,                  -- Saved spaces in each table of history
    fileencoding = 'utf-8',         -- Enconding used for files
    path = '**',                    -- Search files recursively
    backupdir = '/tmp/nvim',        -- Change location of files
    directory = '/tmp/nvim',        -- Change location of files
    undodir = '/tmp/nvim',          -- Change location of files
    wildmenu = true,                -- Enables 'enhanced mode' of command-line completion
    wildmode = 'longest:full,full', -- Options for wildmenu
    wildignore = '*.o,*.rej,*.so',  -- File patterns to ignore
    wildcharm = 26,                 -- Trigger completion in macros
    wildignorecase = true,          -- Ignore case command completion menu
    winblend = 3,                   -- Enable transparency in floating windows and menus
    smartindent = true,             -- Smart indentation
    smarttab = true,                -- Smart indentation
    autoindent = true,              -- Copy indent from current line when starting a new line
    ignorecase = true,              -- Ignore case
    smartcase = true,               -- Smart case
    expandtab = true,               -- Convert tabs to spaces
    tabstop = 4,                    -- Tab length
    shiftround = true,              -- Round indent to multiple of 'shiftwidth'
    shiftwidth = 4,                 -- Size of a > or < when indenting
    softtabstop = -1,               -- Tab length, if negative shiftwidth value is used
    hlsearch = true,                -- Highlighting search
    incsearch = true,               -- Incremental search
    showmatch = false,              -- Show match brace, set to false because :DoMatchParen does enough
    matchtime = 1,                  -- Time for showing matching brace
    list = true,                    -- Show invisible characters
}

for k, v in pairs(options) do
    vim.o[k] = v
end

vim.opt.cpoptions:append 'nm'       -- See :help cpoptions, this are the defaults aABceFs_
vim.opt.shortmess:append 'IFawsc'   -- Less and shorter messages in command line
vim.opt.iskeyword:remove '_'        -- A word separated by _ is being separated in multiple ones

vim.opt.matchpairs:append {
    '<:>',
    '=:;',
}

vim.opt.tags:append {
    './tags',
    'tags'
}

-- Better cursor for visual mode
vim.opt.guicursor:append {
    'v:hor50',
    'i:ver25-iCursor'
}

vim.opt.sessionoptions:append {
    'buffers',
    'curdir',
    'tabpages',
    'winsize'
}

vim.opt.completeopt:append {
    'menuone',
    'noselect',
    'noinsert'
}

vim.opt.listchars:append {
    nbsp = '␣',
    extends = '',
    precedes = '',
    trail = '␣',
    tab  = '->',
    -- tab  = '  ',
    -- eol  = '↴',
}

vim.opt.fillchars:append {
    diff = '∙',
    vert = '┃',
    fold = '·',
    foldopen = '▾',
    foldsep = '│',
    foldclose = '▸'
}

-- To appropriately highlight codefences
vim.g.markdown_fenced_languages = {
  'ts=typescript',
  'tsx=typescriptreact',
  'js=javascript',
  'jsx=javascriptreact',
}
