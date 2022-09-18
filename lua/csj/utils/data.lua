local M = {}
local utils = require 'csj.utils'

-- Component for the statusline.
---@return string
function M.search_count()
   local res = vim.fn.searchcount {
      recomput = 1,
      maxcount = 1000,
   }

   if
      vim.endswith(M.current_keys(true), 'n')
      or vim.endswith(M.current_keys(true), 'N')
   then
      if res.total ~= nil and res.total > 0 then
         return string.format(
            ' %s/%d %s',
            -- ' %s/%d %s ',
            res.current,
            res.total,
            vim.fn.getreg '/'
         )
      end
   else
      vim.cmd.nohlsearch()
   end

   return ' '
end

function M.vcs()
   -- Requires gitsigns.nvim
   local git_info = vim.b.gitsigns_status_dict
   if not git_info or git_info.head == '' then return '' end

   vim.api.nvim_set_hl(
      0,
      'StatusLineGitSignsAdd',
      { bg = utils.get_bg_hl 'StatusLine', fg = utils.get_fg_hl 'GitSignsAdd' }
   )
   vim.api.nvim_set_hl(0, 'StatusLineGitSignsChange', {
      bg = utils.get_bg_hl 'StatusLine',
      fg = utils.get_fg_hl 'GitSignsChange',
   })
   vim.api.nvim_set_hl(0, 'StatusLineGitSignsDelete', {
      bg = utils.get_bg_hl 'StatusLine',
      fg = utils.get_fg_hl 'GitSignsDelete',
   })
   local added = git_info.added
         and ('%#StatusLineGitSignsAdd#+' .. git_info.added .. ' ')
      or ''
   local changed = git_info.changed
         and ('%#StatusLineGitSignsChange#~' .. git_info.changed .. ' ')
      or ''
   local removed = git_info.removed
         and ('%#StatusLineGitSignsDelete#-' .. git_info.removed .. ' ')
      or ''

   if git_info.added == 0 then added = '' end

   if git_info.changed == 0 then changed = '' end

   if git_info.removed == 0 then removed = '' end

   return table.concat {
      ' ',
      added,
      changed,
      removed,
      '%#StatusLineGitSignsAdd#',
      ' ',
      git_info.head,
      ' %#StatusLine#', -- Reset hl groups and add a space
   }
end

---@return string
function M.line_and_column_buffer()
   -- Composition of other components
   return table.concat {
      '%l',
      -- ^^ equivalent to tonumber(vim.api.nvim_eval_statusline('%l', {}).str)
      -- or vim.fn.line('.') or vim.api.nvim_win_get_cursor(0)[1]
      M.icon_by_cursor_line_position(),
      M.cursor_column_interpreted(),
   }
end

function M.icon_by_cursor_line_position()
   -- Icon representing the line number position
   local current_line = vim.fn.line '.'
   local total_lines = vim.fn.line '$' -- == tonumber(vim.api.nvim_eval_statusline('%L', {}).str)

   if vim.api.nvim_eval_statusline('%P', {}).str == 'All' then
      return ' '
   elseif current_line == 1 then
      return ' '
   end

   local chars = { ' ', ' ', ' ' }
   local line_ratio = current_line / total_lines
   local index = math.ceil(line_ratio * #chars)
   return chars[index]
end

function M.cursor_column_interpreted()
   -- Represent cursor column and lenght of the line
   local line_lenght = vim.fn.col '$' - 1
   local cursor_column = vim.fn.col '.' -- == tonumber(vim.api.nvim_eval_statusline('%c', {}).str)

   if line_lenght == cursor_column then
      return cursor_column, '␊'
   elseif line_lenght == 0 then
      return ''
   else
      return cursor_column, '↲', line_lenght
   end
end

function M.filewritable()
   local fmode = vim.fn.filewritable(vim.fn.expand '%:F')
   if fmode == 0 then
      return ' '
   elseif fmode == 1 then
      local show_sign = false
      return show_sign and '' or ' '
      -- elseif fmode == 2 then
      --    return ' '
   end
end

-- Return the path of the file, without the file nor extension of it.
---@return string @ Returns a path like `/home/user/.config/nvim`
function M.filepath()
   -- Return the filepath without the name of the file
   local filepath = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.:h')
   if filepath == '' or filepath == '.' then return ' ' end

   if vim.bo.filetype == 'lua' then
      -- For lua use . as a separator instead of /
      local replace_fpath = string.gsub(filepath, '/', '.')
      return string.format('%%<%s.', replace_fpath)
   end

   return string.format('%%<%s/', filepath)
end

function M.filename()
   local filename = vim.fn.expand '%:t'
   -- local filename = vim.api.nvim_eval_statusline('%t', {}).str
   if filename == '' then return ' ' end

   return filename
end

-- TODO: Redo this
-- function M.filename_icon()
--    vim.schedule(function()
--    if utils.avoid_filetype() then
--       local ok, icons = pcall(require, 'nvim-web-devicons')
--       if ok then
--          return icons.get_icon_by_filetype(vim.bo.filetype)
--       else
--          return ' '
--       end
--       end
--    end)
-- end

-- Return the column number of the cursor line.
---@return integer
function M.current_line_lenght() return #vim.api.nvim_win_get_cursor(0) end

function M.modified_buffer()
   -- TODO(santigo-zero): Add filetype detection
   local is_modified = vim.api.nvim_eval_statusline('%m', {}).str
   if is_modified == '' then
      return ''
   else
      return ' '
   end
end

-- Get the last 5 pressed keys.
---@param as_string boolean @ true to return a string, false to return a table.
---@return string|table
function M.current_keys(as_string)
   local typed_letters = require('csj.utils.keypresses').typed_letters
   if #typed_letters > 1 then
      return as_string and string.format('  %s', table.concat(typed_letters))
         or typed_letters
   else
      return ' '
   end
end

return M
