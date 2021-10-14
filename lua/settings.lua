                             -- NEOVIM SETTINGS --
vim.o.spelllang = 'en,cjk'  -- Spell checking languages
vim.o.timeoutlen = 333  -- Time given for doing a sequence
vim.o.updatetime = 333  -- Faster completion - CursorHold interval
vim.o.clipboard = 'unnamedplus'  -- Uses the system clipboard
vim.o.hidden = true  -- It keeps buffers open in memory
vim.opt.grepprg = 'rg --vimgrep'  -- Grep command
vim.o.shell = 'zsh'  -- Shell to use for `!`, `:!`, `system()` etc.
vim.opt.joinspaces = false  -- No double spaces with join after a dot

vim.o.laststatus = 0  -- Mode of the status bar
vim.o.conceallevel = 0  -- Show text normally
vim.o.wrap = false  -- Wrap text
vim.o.mouse = 'a'  -- mouse can select, paste and
vim.o.cmdheight = 1  -- Space for displaying messages in the command line
vim.o.splitbelow = true  -- Force splits to go below current window
vim.o.splitright = true  -- Force vertical splits to go to the right of current window
vim.o.title = true  -- Set the window title based on the value of titlestring
vim.o.showtabline = 2  -- Show top tab bar
vim.o.showmode = false  -- Hides/shows mode status below status line
vim.o.showmatch = true  -- Show matching braces
vim.o.matchtime = 1  -- Time for showing matching brace
vim.o.number = true  -- Display line number on the side
vim.o.relativenumber = true  -- Display line number relative to the cursor
vim.o.signcolumn = 'yes:1'  -- 'number' -- Always show signcolumn
vim.o.numberwidth = 3  -- Gutter column number width
vim.o.colorcolumn = '80'  -- Limiter line
vim.o.pumheight = 10  -- Pop up menu height
vim.opt.pumblend = 5  -- Popup blend
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

vim.o.swapfile = false  -- It does (not) creates a swapfile
vim.o.undofile = true  -- Persistent undo - undo after you re-open the file
vim.opt.undolevels = 10000  -- Levels of undoing
vim.o.fileencoding = 'utf-8'  -- The encode used in the file
vim.o.path = '**'  -- Search files recursively

vim.o.wildmenu = true  -- Enables 'enhanced mode' of command-line completion
vim.o.wildmode= 'longest:full,full'  -- Options for wildmenu
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
vim.o.winblend = 0  -- Enable transparency in floating windows and menus
vim.o.wildignore = '*.o,*.rej,*.so'  -- File patterns for wildmenu
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }  -- Menu options

local indent = 4
vim.o.expandtab = true  -- Convert tabs to spaces
vim.o.shiftround = true  -- Round indent to multiple of 'shiftwidth'
vim.o.shiftwidth = indent  -- Size of a > or < when indenting
vim.o.tabstop = indent  -- Tab length
vim.o.softtabstop = indent  -- Tab length
vim.o.smartindent = true  -- Smart indentation
vim.o.smarttab = true  -- Smart indentation

vim.o.ignorecase = true  -- Ignore case
vim.o.smartcase = true  -- Smart case
vim.o.lazyredraw = true  -- Lazy redraw the screen
vim.o.hlsearch = true  -- Highlighting search
vim.o.incsearch = true  -- Incremental search
vim.o.inccommand = 'nosplit'  -- Live preview of :s results

vim.o.list = true  -- Show invisible characters
vim.o.showbreak = '↪'
vim.opt.listchars = {
    nbsp     = '␣',
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
vim.cmd([[
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
]])


                               -- COLORSCHEME --

vim.o.termguicolors = true  -- Set term gui colors
vim.cmd 'colorscheme tokyonight'  -- Select colorscheme
vim.g.tokyonight_style = 'night'  -- Colorscheme specific settings
vim.g.tokyodark_transparent_background = false  -- Colorscheme specific setting
vim.api.nvim_exec([[ autocmd ColorScheme * highlight Visual cterm=reverse gui=reverse ]], true)  -- Colors in visual mode


                                 -- NEOVIDE --

vim.opt.guifont = 'Iosevka Nerd Font:h16'  -- Font used in GUI applications
vim.g.neovide_refresh_rate = 90
vim.g.neovide_cursor_vfx_mode = 'sonicboom'
vim.g.neovide_cursor_antialiasing = 1


               -- LSP MOVE TO OTHER FILES, REFORMAT EVERYTHING --
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'bashls', 'clangd', 'rust_analyzer', 'pyright', 'denols' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end


-- Example custom server
-- local sumneko_root_path = vim.fn.getenv 'HOME' .. '/.local/bin/sumneko_lua' -- Change to your sumneko root installation
local sumneko_root_path = '/usr/bin' -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                path = runtime_path,
            },
            -- Setup your lua path
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
