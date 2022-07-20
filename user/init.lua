-- Ensure this settings persist in all buffers
function _G.all_buffers_settings()
  vim.opt.iskeyword = '@,48-57,192-255'

  vim.opt.formatoptions = vim.opt.formatoptions
    + 'r' -- If the line is a comment insert another one below when hitting <CR>
    + 'c' -- Wrap comments at the char defined in textwidth
    + 'q' -- Allow formatting comments with gq
    + 'j' -- Remove comment leader when joining lines when possible
    - 'o' -- Don't continue comments after o/O
    - 'l' -- Format in insert mode if the line is longer than textwidth

  -- There's a non-visible character at cchar= so watch
  vim.cmd([[syntax match hidechars '\'' conceal " cchar= ]])
  vim.cmd([[syntax match hidechars '\"' conceal " cchar= ]])
  vim.cmd([[syntax match hidechars '\[\[' conceal " cchar= ]])
  vim.cmd([[syntax match hidechars '\]\]' conceal " cchar= ]])
  -- vim.cmd([[syntax match hidechars '{}' conceal cchar=]])
end

vim.api.nvim_create_autocmd('BufEnter', {
  group = 'session_opts',
  callback = _G.all_buffers_settings,
})
_G.all_buffers_settings()

---@return table
return {
  colorscheme = 'jetjbp', -- Colorscheme
  restore = true, -- Restore session, cursor and view
  disable_builtins = true, -- Disable builtins plugins

  -- Load modules
  modules = {
    folds = true,
    acceleratedjk = true,
    notifications = true,
    virtcolumn = true,
    skeletons = true,
  },

  -- Settings
  opts = {
    breakindent = true, -- Every wrapped line will continue visually indented
    clipboard = 'unnamedplus', -- Clipboard mode
    cmdheight = 0,
    conceallevel = 2, -- Show concealed text when the cursor is not on top
    confirm = true, -- Confirm dialogs
    cursorcolumn = true,
    cursorline = true,
    diffopt = 'foldcolumn:0,hiddenoff,vertical',
    expandtab = true, -- Convert tabs to spaces
    grepprg = 'rg --hidden --no-heading --vimgrep', -- Grep command
    ignorecase = true, -- Ignore case
    inccommand = 'split', -- Shows just like nosplit, but partially off-screen
    infercase = true,
    joinspaces = true, -- Commands like gq or J insert two spaces on punctuation
    lazyredraw = true, -- Lazy redraw the screen
    list = true, -- Show non-visible characters
    matchpairs = '(:),{:},[:],<:>,=:;', -- Match pairs
    mousefocus = true, -- Focusing cursor on the window with the keyboard focus
    number = true,
    pumblend = 9, -- Transparency for the pop up menu
    pumheight = 6, -- Amount of lines shown in completion menus
    relativenumber = true,
    scrolloff = 9, -- Cursor does not reach top/bottom
    secure = true, -- Self-explanatory
    shiftround = true, -- Round indent to multiple of "shiftwidth"
    shortmess = 'oOstIFS', -- Style for displaying messages
    showbreak = '↪', -- '↳' Shows when text is being wrapped
    showmode = false, -- Show or hide the mode you are on in the status line
    showtabline = 0, -- Show top tab bar
    sidescrolloff = 9, -- Cursor does not reach sides
    signcolumn = 'number', -- Column for lsp/linting errors and warnings
    smartcase = true, -- Smart case
    smartindent = true, -- Smart indentation
    softtabstop = -1, -- Tab length, if negative shiftwidth value is used
    spelllang = 'en,cjk', -- Spell check: English - PascalCase and camelCase
    spelloptions = 'camel', -- Options for spell checking
    spellsuggest = 'best', -- Spelling suggestions
    splitbelow = true, -- Force splits to go below current window
    splitright = true, -- Force vsplits to go to the right of current window
    swapfile = false, -- It does (not) creates a swapfile
    synmaxcol = 160, -- Column limit for syntax highlight
    textwidth = 80, -- Delimit text blocks to N columns
    timeoutlen = 300, -- Time given for doing a sequence
    undofile = true, -- Persistent undo - undo after you re-open the file
    undolevels = 6000, -- Levels of undoing
    updatetime = 300, -- Faster completion, it's the time for CursorHold event
    whichwrap = '<,>,[,],h,l,b,s,~', -- Jump to the next line if you reach eol
    winblend = 9, -- Transparency for windows
    winhighlight = 'Normal:ActiveWindow,NormalNC:InactiveWindow',
    wrap = false, -- Wrap lines
  },
}
