local tab_lenght = 3
vim.opt_local.tabstop = tab_lenght
vim.opt_local.shiftwidth = tab_lenght
vim.opt_local.colorcolumn = '80,120'
vim.opt_local.textwidth = 80

-- Iterator that splits a string o a given delimiter.
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
   elseif vim.fn.has 'win32' == 1 then
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

-- Search for nvim lua include paths.
local function include_rtpaths(fname, ext)
   ext = ext or 'lua'
   local sep = dir_separator()
   local rtpaths = vim.api.nvim_list_runtime_paths()
   local modfile, initfile =
      string.format('%s.%s', fname, ext), string.format('init.%s', ext)
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

-- Global function that searches the path for the required file.
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

-- Set options to open require with gf.
vim.opt_local.include =
   [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
vim.opt_local.includeexpr = 'v:lua.Find_required_path(v:fname)'

-- vim.defer_fn(function()
--    vim.cmd [[syntax match hidechars '\'' conceal " cchar= ]]
--    vim.cmd [[syntax match hidechars '\"' conceal " cchar= ]]
--    vim.cmd [[syntax match hidechars '\[\[' conceal " cchar= ]]
--    vim.cmd [[syntax match hidechars '\]\]' conceal " cchar= ]]
-- end, 600)
