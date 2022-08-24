local utils = require('csj.core.utils')

-- NetRW config.
vim.g.netrw_banner = 0 -- Toggle the banner
vim.g.netrw_keepdir = 0 -- Keep the current directory and the browsing directory synced.
vim.g.netrw_sort_sequence = [[\/]$,*]] -- Show directories first (sorting)
vim.g.netrw_sizestyle = 'H' -- Human-readable files sizes
vim.g.netrw_liststyle = 3 -- Tree view
vim.g.netrw_winsize = 30 -- Size of the split
vim.g.netrw_preview = 0 -- Preview files in a vertical split window
vim.g.netrw_alto = 1
vim.g.netrw_browsex_viewer = 'setsid xdg-open' --  'open'
vim.g.netrw_list_hide = vim.fn['netrw_gitignore#Hide']() -- Patterns for hiding files, e.g. node_modules or .gitignore
vim.g.netrw_hide = 0 -- Show hidden files
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

-- Open files in split
-- 0 : re-use the same window (default)
-- 1 : horizontally splitting the window first
-- 2 : vertically   splitting the window first
-- 3 : open file in new tab
-- 4 : act like "P" (ie. open previous window)
vim.g.netrw_browse_split = 4

vim.g.netrw_localcopydircmd = 'cp -r' -- Enable recursive copy of directories
vim.g.netrw_localmkdir = 'mkdir -p' -- Enable recursive creation of directories
vim.g.netrw_localrmdir = 'rm -r' -- Enable recursive removal of directories and files

utils.set_hl('netrwMarkFile', { link = 'Search' }) -- Highlight marked files in the same way search matches are

local function draw_icons()
  if vim.bo.filetype ~= 'netrw' then
    return
  end
  local is_devicons_available, devicons = pcall(require, 'nvim-web-devicons')
  if not is_devicons_available then
    return
  end
  local default_signs = {
    netrw_dir = {
      text = '',
      texthl = 'netrwDir',
    },
    netrw_file = {
      text = '',
      texthl = 'netrwPlain',
    },
    netrw_exec = {
      text = '',
      texthl = 'netrwExe',
    },
    netrw_link = {
      text = '',
      texthl = 'netrwSymlink',
    },
  }

  local bufnr = vim.api.nvim_win_get_buf(0)

  -- Unplace all signs
  vim.fn.sign_unplace('*', { buffer = bufnr })

  -- Define default signs
  for sign_name, sign_opts in pairs(default_signs) do
    vim.fn.sign_define(sign_name, sign_opts)
  end

  local cur_line_nr = 1
  local total_lines = vim.fn.line('$')
  while cur_line_nr <= total_lines do
    -- Set default sign
    local sign_name = 'netrw_file'

    -- Get line contents
    local line = vim.fn.getline(cur_line_nr)

    if utils.is_empty(line) then
      -- If current line is an empty line (newline) then increase current line count
      -- without doing nothing more
      cur_line_nr = cur_line_nr + 1
    else
      if line:find('/$') then
        sign_name = 'netrw_dir'
      elseif line:find('@%s+-->') then
        sign_name = 'netrw_link'
      elseif line:find('*$') then
        sign_name:find('netrw_exec')
      else
        local filetype = line:match('^.*%.(.*)')
        if not filetype and line:find('LICENSE') then
          filetype = 'md'
        elseif line:find('rc$') then
          filetype = 'conf'
        end

        -- If filetype is still nil after manually setting extensions
        -- for unknown filetypes then let's use 'default'
        if not filetype then
          filetype = 'default'
        end

        local icon, icon_highlight =
          devicons.get_icon(line, filetype, { default = '' })
        sign_name = 'netrw_' .. filetype
        vim.fn.sign_define(sign_name, {
          text = icon,
          texthl = icon_highlight,
        })
      end
      vim.fn.sign_place(cur_line_nr, sign_name, sign_name, bufnr, {
        lnum = cur_line_nr,
      })
      cur_line_nr = cur_line_nr + 1
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    return draw_icons()
  end,
})

vim.api.nvim_create_autocmd('TextChanged', {
  callback = function()
    return draw_icons()
  end,
})
