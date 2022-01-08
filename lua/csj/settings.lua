local options = {
    autoindent = true, -- Copy indent from current line when starting a new line
    backspace = 'indent,start,eol', -- Make backspace behave like normal again
    clipboard = 'unnamedplus', -- Uses the system clipboard
    cmdheight = 1, -- Space for displaying messages in the command line
    textwidth = 120, -- Delimit text blocks to N columns
    colorcolumn = '+1', -- Limiter line, + line more than textwidth
    conceallevel = 2, -- Show text normally
    confirm = true, -- Confirm dialogs
    -- cursorcolumn = true, -- Draw line on cursor
    -- cursorline = true, -- Draw line on cursor
    undofile = true, -- Persistent undo - undo after you re-open the file
    undolevels = 10000, -- Levels of undoing
    exrc = true, -- Use local .nvimrc or .exrc
    foldenable = true, -- Enable folds
    foldmethod = 'manual', -- Method used for idents
    foldexpr = 'nvim_treesitter#foldexpr()', -- Use treesitter to define folds, needs to enable expr
    foldcolumn = 'auto', -- Column to display where the folds are
    foldlevelstart = 99, -- Sets 'foldlevel' when starting to edit another buffer in a window
    foldnestmax = 1, -- To only fold outer functions
    hidden = true, -- It keeps buffers open in memory
    history = 100, -- Saved spaces in each table of history
    hlsearch = true, -- Highlighting search
    ignorecase = true, -- Ignore case
    inccommand = 'split', -- Shows just like nosplit, but partially off-screen
    incsearch = true, -- Incremental search
    joinspaces = false, -- No double spaces with join after a dot
    laststatus = 0, -- Mode of the status bar
    lazyredraw = true, -- Lazy redraw the screen
    diffopt = 'internal,filler,closeoff,foldcolumn:0,hiddenoff',
    list = true, -- Show invisible characters
    matchtime = 1, -- Time for showing matching brace
    mouse = 'a', -- Mouse options, all enabled
    mousefocus = true, -- Focusing cursor on the window with the keyboard focus
    number = true, -- Display line number on the side
    path = '**', -- Search files recursively
    -- pumblend = 9, -- Transparency for the pop up menu, disabled because it messess up Nerd Font icons
    pumheight = 33, -- Pop up menu height
    redrawtime = 600, -- Time for redrawing the display
    relativenumber = true, -- Display line number relative to the cursor
    ruler = true, -- Show the line and column number of the cursor position
    shell = 'zsh', -- Shell to use for `!`, `:!`, `system()` etc.
    grepprg = 'rg --hidden --no-heading --vimgrep', -- Grep command
    shiftround = true, -- Round indent to multiple of "shiftwidth"
    shiftwidth = 4, -- Size of a > or < when indenting
    showbreak = '↪', -- Shows when text is being wrapped
    showmatch = false, -- Show match brace, set to false because :DoMatchParen does enough
    showmode = false, -- Show or hide the mode you are on in the status line
    scrolloff = 999, -- Cursor does not reach top/bottom
    sidescrolloff = 8, -- Cursor does not reach sides
    signcolumn = 'yes', -- Always show signcolumn
    smartcase = true, -- Smart case
    smartindent = true, -- Smart indentation
    showtabline = 0, -- Show top tab bar
    virtualedit = 'all', -- Be able to put the cursor where there's not actual text
    expandtab = true, -- Convert tabs to spaces
    smarttab = true, -- Smart indentation
    softtabstop = -1, -- Tab length, if negative shiftwidth value is used
    tabstop = 4, -- Tab length
    spelllang = 'en,cjk', -- Spell checking languages
    spelloptions = 'camel', -- Options for spell checking
    splitbelow = true, -- Force splits to go below current window
    splitright = true, -- Force vertical splits to go to the right of current window
    swapfile = false, -- It does (not) creates a swapfileWage
    termguicolors = true, -- Enable colors in the terminal
    timeoutlen = 400, -- Time given for doing a sequence
    title = true, -- Set the window title based on the value of titlestring
    updatetime = 600, -- Faster completion
    wildcharm = 26, -- Trigger completion in macros
    wildignore = '*.o,*.rej,*.so', -- File patterns to ignore
    wildignorecase = true, -- Ignore case command completion menu
    wildmenu = true, -- Enables "enhanced mode" of command-line completion
    winhighlight = 'NormalNC:WinNormalNC',
    wildmode = 'longest:full,full', -- Options for wildmenu
    winblend = 9, -- Enable transparency in floating windows and menus
    wrap = false, -- Wrap text
}

for k, v in pairs(options) do
    vim.o[k] = v
end

vim.opt.cpoptions:append('nm') -- See :help cpoptions, this are the defaults aABceFs_
vim.opt.shortmess:append('IFawsc') -- Less and shorter messages in command line
vim.opt.iskeyword:remove('_') -- A word separated by _ is being separated in multiple ones
-- See https://github.com/neovim/neovim/pull/16251 for more info on cmdheight=0
-- vim.opt.lines:append '1' -- Hide command line, currently very buggy

vim.opt.matchpairs:append({
    '<:>',
    '=:;',
})

vim.opt.tags:append({
    './tags',
    'tags',
})

-- Better cursor for visual mode
vim.opt.guicursor:append({
    'i:ver25-iCursor',
    'v:hor50',
})

vim.opt.sessionoptions:append({
    'buffers',
    'curdir',
    'tabpages',
    'winsize',
})

vim.opt.completeopt:append({
    'menuone',
    'noinsert',
    'noselect',
})

vim.opt.listchars:append({
    extends = '◣',
    precedes = '◢',
    nbsp = '␣',
    tab = '-->',
    trail = '█',
})

vim.opt.fillchars:append({
    -- eob = '~',
    eob = ' ',
    diff = '∙',
    fold = ' ',
    foldclose = '▶',
    foldopen = '▼',
    foldsep = '│',
    vert = '┃',
})

-- To appropriately highlight codefences
vim.g.markdown_fenced_languages = {
    'ts=typescript',
    'tsx=typescriptreact',
    'js=javascript',
    'jsx=javascriptreact',
}
