-- NEOVIM SETTINGS IN LUA

vim.opt.guifont = 'Fira Code Regular Nerd Font Complete:h15'  -- Font used in GUI applications
vim.opt.laststatus = 0  -- Mode of the status bar
vim.opt.smartcase = true  -- Smart case
-- vim.opt.ignorecase = true  -- Ignore case
vim.opt.conceallevel = 0  -- Show text normally
vim.opt.smartindent = true  -- Smart indentation
vim.opt.pumheight = 10  -- Pop up menu height
vim.opt.path = '**'
vim.cmd 'filetype plugin on'
vim.opt.tags = './tags;,tags'
vim.cmd 'set iskeyword+=-'
vim.opt.spelllang = 'en,cjk'  -- Spell checking languages
vim.opt.showmode = false  -- Hides/shows mode status below status line
vim.opt.timeoutlen = 333 -- Time given for doing a sequence
vim.opt.updatetime = 33  -- Faster completion - CursorHold interval
vim.opt.title = true  -- Set the window title based on the value of titlestring
vim.opt.wrap = false  -- Wrap text
vim.opt.number = true  -- Display line number on the side
vim.opt.relativenumber = true  -- Display line number relative to the cursor
vim.opt.numberwidth = 3  -- Gutter column number width
vim.opt.cpoptions = 'aABceFs_nm' -- See :help cpoptions, this are the defaults aABceFs_
vim.opt.list = true  -- Show whitespace
vim.opt.backspace= 'indent,start,eol'  -- Make backspace behave like normal again
vim.opt.clipboard = 'unnamedplus'  -- Uses the system clipboard
vim.opt.fileencoding = 'utf-8'  -- The encode used in the file
vim.opt.wildignore  = '*.o,*.rej,*.so'
vim.opt.hidden = true  -- It keeps buffers open in memory
vim.opt.hlsearch = true  -- incremental search
vim.opt.mouse = 'a'  -- mouse can select, paste and
vim.opt.colorcolumn = '90'  -- Limiter line
vim.opt.cursorline = true  -- Draw line on cursor
vim.opt.cmdheight = 1  -- Space for displaying messages in the command line
vim.api.nvim_exec('highlight visual cterm=reverse gui=reverse', true)  -- Visual mode reversed colors
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }  -- Menu options
vim.opt.inccommand = 'split'  -- Live preview of :s results
vim.opt.scrolloff = 6  -- Cursor does not reach top/bottom
vim.opt.sidescrolloff = 6  -- Cursor does not reach sides
vim.opt.splitbelow = true  -- Force splits to go below current window
vim.opt.splitright = true  -- Force all vertical splits to go to the right of current window
vim.opt.swapfile = false  -- It does (not) creates a swapfile
vim.opt.undofile = true  -- Persistent undo - undo after you re-open the file
vim.opt.showtabline = 0  -- Show top tab bar
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.tabstop = 4  -- Tab length
vim.opt.shiftwidth = 4  -- Number of spaces per tab for indentation
vim.opt.shiftround = true  -- Round indent to multiple of 'shiftwidth'
vim.opt.signcolumn = 'number'  -- Show/hide signs column
vim.opt.termguicolors = true  -- Set term gui colors

vim.cmd([[colorscheme tokyonight]])
vim.cmd([[let g:tokyonight_style = 'night' "]])

-- Disable certain sections in :checkhealth
vim.tbl_map(
    function(p)
        vim.g["loaded_" .. p] = vim.endswith(p, "provider") and 0 or 0
    end,
    {
        "perl_provider",
        "python_provider",
        "ruby_provider",
    }
)

vim.opt.listchars = {
    nbsp     = '⦸',
    extends  = '»',
    precedes = '«',
    tab      = '▷-',
    trail    = '•',
    space    = ' ',
}

vim.opt.fillchars = {
    diff     = '∙',
    eob      = ' ',
    fold     = '·',
    vert     = ' ',
}

-- 2 spaces for selected filetypes
vim.cmd([[autocmd FileType xml,xhtml,dart setlocal shiftwidth=2 tabstop=2]])
-- 4 spaces for selected filetypes
vim.cmd([[autocmd FileType html,css,scssjavascript,lua,dart,python,c,cpp,md,sh setlocal shiftwidth=4 tabstop=4]])
-- 8 spaces for Go files
vim.cmd([[autocmd FileType go setlocal shiftwidth=8 tabstop=8]])




-- KEYMAPPINGS, FUNCTIONS, AUTOMATION --

-- Leader key
vim.g.mapleader = ";"

-- Quick semicolon
vim.api.nvim_set_keymap('n', '<Leader>;', '$a;<Esc>', {noremap = true, silent = true})

-- Quick colon
vim.api.nvim_set_keymap('n', '<Leader>:', '$a:<Esc>', {noremap = true, silent = true})

-- View opened buffers
vim.api.nvim_set_keymap('n', '<Leader>ob', ':buffers<cr>', {noremap = true, silent = true})

-- Quick save and quit
vim.api.nvim_set_keymap('n', '<Leader>x', ':x<cr>', {noremap = true, silent = true})

-- Quick save and quit
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<cr>', {noremap = true, silent = true})

-- Insert empty line without leaving normal mode
vim.api.nvim_set_keymap('n', '<Leader>o', 'o<Esc>0"_D', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>O', 'O<Esc>0"_D', {noremap = true, silent = true})

-- Switch buffers using TAB
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- Move current block with Ctrl + j/k
vim.api.nvim_set_keymap("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<C-j>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<C-k>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- Toggle incremental search with Leader + h
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- Yank until the end of line with Y
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- Undo break points
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '!', '!<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '?', '?<C-g>u', {noremap = true, silent = true})

-- Toggle spell checking
vim.api.nvim_set_keymap('i', '<silent> <F11>', '<C-O>:set spell!<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<silent> <F11>', ':set spell!<cr>', {noremap = true, silent = true})




-- AUTOMATION

-- Highlight on yank
vim.api.nvim_exec([[
augroup yankhighlight
    autocmd!
    autocmd textyankpost * silent! lua vim.highlight.on_yank()
augroup end
]], true)

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.api.nvim_exec([[
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
]], true)




-- VIMSCRIPT ONLY FUNCTIONS

-- Trim white spaces
vim.cmd([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup JIUMYLOVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
]])

-- Automatic toggling between line number modes
vim.cmd([[
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]])
