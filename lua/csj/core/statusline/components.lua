local component = {}
local utils = require('csj.utils')

function component.vcs()
   -- Requires gitsigns.nvim
   local git_info = vim.b.gitsigns_status_dict
   if not git_info or git_info.head == '' then
      return ''
   end
   vim.api.nvim_set_hl(0, 'StatusLineGitSignsAdd', { bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background, fg = vim.api.nvim_get_hl_by_name('GitSignsAdd', true).foreground })
   vim.api.nvim_set_hl(0, 'StatusLineGitSignsChange', { bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background, fg = vim.api.nvim_get_hl_by_name('GitSignsChange', true).foreground })
   vim.api.nvim_set_hl(0, 'StatusLineGitSignsDelete', { bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background, fg = vim.api.nvim_get_hl_by_name('GitSignsDelete', true).foreground })
   local added = git_info.added and ('%#StatusLineGitSignsAdd#+' .. git_info.added .. ' ') or ''
   local changed = git_info.changed and ('%#StatusLineGitSignsChange#~' .. git_info.changed .. ' ') or ''
   local removed = git_info.removed and ('%#StatusLineGitSignsDelete#-' .. git_info.removed .. ' ') or ''
   if git_info.added == 0 then
      added = ''
   end
   if git_info.changed == 0 then
      changed = ''
   end
   if git_info.removed == 0 then
      removed = ''
   end

   return table.concat {
      ' ',
      added,
      changed,
      removed,
      '%#StatusLineGitSignsAdd#',
      ' ',
      git_info.head,
      '%#StatusLine#',
   }
end

function component.lineinfo()
   if vim.tbl_contains(utils.ignore_ft(), vim.bo.filetype) then
      return ''
   end
   local line_lenght = vim.api.nvim_get_current_line()

   return table.concat {
      '%P %l:%c',
      '',
      #line_lenght,
   }
end

function component.filepath()
   -- Return the filepath without the name of the file
   local filepath = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:h')
   if filepath == '' or filepath == '.' then
      return ' '
   end

   if vim.opt.filetype:get() == 'lua' then
      -- For lua use . as a separator instead of /
      local replace_fpath = string.gsub(filepath, '/', '.')
      return string.format('%%<%s.', replace_fpath)
   end

   return string.format('%%<%s/', filepath)
end

function component.filename()
   local filename = vim.fn.expand('%:t')
   if filename == '' then
      return ''
   end

   return filename
end

return component
