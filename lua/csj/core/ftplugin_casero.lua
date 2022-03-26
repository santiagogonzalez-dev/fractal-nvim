-- Filetype settings and utilities

-- Globals
vim.api.nvim_create_augroup('buffer_settings', { clear = true })
vim.api.nvim_create_autocmd({ 'UIEnter', 'BufWinEnter', 'BufEnter', 'FileType' }, {
  desc = 'Load some options in all buffers',
  group = 'buffer_settings',
  pattern = '*.*',
  callback = function()
    _G.all_buffers_settings()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Quit with q in this filetypes',
  group = 'buffer_settings',
  pattern = 'qf,help,man,lspinfo,startuptime,Trouble',
  callback = function()
    vim.keymap.set('n', 'q', '<CMD>close<CR>')
  end,
})

-- QF
vim.api.nvim_create_autocmd('FileType', {
  group = 'buffer_settings',
  pattern = 'qf',
  callback = function()
    vim.cmd([[
      " From https://github.com/kevinhwang91/nvim-bqf
      if exists('b:current_syntax')
        finish
      endif

      syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
      syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
      syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
      syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
      syn match qfError / E .*$/ contained
      syn match qfWarning / W .*$/ contained
      syn match qfInfo / I .*$/ contained
      syn match qfNote / [NH] .*$/ contained

      hi def link qfFileName       Directory
      hi def link qfSeparatorLeft  qfLineNr
      hi def link qfSeparatorRight qfLineNr

      hi def link qfError          DiagnosticError
      hi def link qfWarning        Diagnostic
      hi def link qfInfo           DiagnosticInfo
      hi def link qfNote           DiagnosticHint

      let b:current_syntax = 'qf'
    ]])
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Filetype set correctly',
  group = 'buffer_settings',
  pattern = '*.conf',
  callback = function()
    vim.opt.filetype = 'dosini'
  end,
})

-- Web Development
vim.api.nvim_create_augroup('webdev_projects', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascriptreact',
    'javascriptreact',
    'javascript',
    'typescript',
    'html',
    'css',
    'xhtml',
    'xml',
  },
  group = 'webdev_projects',
  callback = function()
    local tab_lenght = 2
    vim.opt.tabstop = tab_lenght
    vim.opt.shiftwidth = tab_lenght
  end,
})

-- Python
vim.api.nvim_create_augroup('python_projects', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  group = 'python_projects',
  callback = function()
    vim.opt.colorcolumn = '88'
    vim.opt.textwidth = 89
    vim.g.python3_host_prog = './.venv/bin/'

    -- Toggle fstrings in python
    local ts_utils = require('nvim-treesitter.ts_utils')
    local toggle_fstring = function()
      local winnr = 0
      local cursor = vim.api.nvim_win_get_cursor(winnr)
      local node = ts_utils.get_node_at_cursor()

      while (node ~= nil) and (node:type() ~= 'string') do
        node = node:parent()
      end
      if node == nil then
        print('f-string: not in string node')
        return
      end

      local srow, scol, _, _ = ts_utils.get_vim_range { node:range() }
      vim.fn.setcursorcharpos(srow, scol)
      local char = vim.api.nvim_get_current_line():sub(scol, scol)
      local is_fstring = (char == 'f')

      if is_fstring then
        vim.cmd('normal x')
        -- If cursor is in the same line as text change
        if srow == cursor[1] then
          cursor[2] = cursor[2] - 1 -- negative offset to cursor
        end
      else
        vim.cmd('normal if')
        -- If cursor is in the same line as text change
        if srow == cursor[1] then
          cursor[2] = cursor[2] + 1 -- positive offset to cursor
        end
      end
      vim.api.nvim_win_set_cursor(winnr, cursor)
    end

    -- Toggle fstring keymap
    vim.keymap.set('n', 'F', toggle_fstring)
  end,
})

-- Lua
vim.api.nvim_create_augroup('lua_projects', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  group = 'lua_projects',
  callback = function()
    local tab_lenght = 2
    vim.opt.tabstop = tab_lenght
    vim.opt.shiftwidth = tab_lenght
    vim.opt.colorcolumn = '120'
    vim.opt.textwidth = 119

    -- Iterator that splits a string o a given delimiter
    local function split(str, delim)
      delim = delim or '%s'
      return string.gmatch(str, string.format('[^%s]+', delim))
    end

    -- Find the proper directory separator depending
    -- on lua installation or OS.
    local function dir_separator()
      -- Look at package.config for directory separator string (it's the first line)
      if package.config then
        return string.match(package.config, '^[^\n]')
      elseif vim.fn.has('win32') == 1 then
        return '\\'
      else
        return '/'
      end
    end

    -- Search for lua traditional include paths.
    -- This mimics how require internally works.
    local function include_paths(fname, ext)
      ext = ext or 'lua'
      local paths = string.gsub(package.path, '%?', fname)
      for path in split(paths, '%;') do
        if vim.fn.filereadable(path) == 1 then
          return path
        end
      end
    end

    -- Search for nvim lua include paths
    local function include_rtpaths(fname, ext)
      ext = ext or 'lua'
      local sep = dir_separator()
      local rtpaths = vim.api.nvim_list_runtime_paths()
      local modfile, initfile = string.format('%s.%s', fname, ext), string.format('init.%s', ext)
      for _, path in ipairs(rtpaths) do
        -- Look on runtime path for 'lua/*.lua' files
        local path1 = table.concat({ path, ext, modfile }, sep)
        if vim.fn.filereadable(path1) == 1 then
          return path1
        end
        -- Look on runtime path for 'lua/*/init.lua' files
        local path2 = table.concat({ path, ext, fname, initfile }, sep)
        if vim.fn.filereadable(path2) == 1 then
          return path2
        end
      end
    end

    -- Global function that searches the path for the required file
    function Find_required_path(module)
      -- Look at package.config for directory separator string (it's the first line)
      local sep = string.match(package.config, '^[^\n]')
      -- Properly change '.' to separator (probably '/' on *nix and '\' on Windows)
      local fname = vim.fn.substitute(module, '\\.', sep, 'g')
      local f
      ---- First search for lua modules
      f = include_paths(fname, 'lua')
      if f then
        return f
      end
      -- This part is just for nvim modules
      f = include_rtpaths(fname, 'lua')
      if f then
        return f
      end
      ---- Now search for Fennel modules
      f = include_paths(fname, 'fnl')
      if f then
        return f
      end
      -- This part is just for nvim modules
      f = include_rtpaths(fname, 'fnl')
      if f then
        return f
      end
    end

    -- Set options to open require with gf
    vim.opt_local.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
    vim.opt_local.includeexpr = 'v:lua.Find_required_path(v:fname)'
  end,
})

-- A monad is just a monoid in the category of endofunctors
vim.api.nvim_create_augroup('monad_fan', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'haskell',
  group = 'monad_fan',
  callback = function()
    local tab_lenght = 2
    vim.opt.tabstop = tab_lenght
    vim.opt.shiftwidth = tab_lenght
  end,
})
