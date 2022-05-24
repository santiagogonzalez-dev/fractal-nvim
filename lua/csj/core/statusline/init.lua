local statusline = {}
local component = {}

function statusline.update_mode_colors()
   local current_mode = vim.api.nvim_get_mode().mode
   local mode_color
   if current_mode == 'n' then
      mode_color = '%#StatusLineAccent#'
   elseif current_mode == 'i' or current_mode == 'ic' then
      mode_color = '%#StatuslineInsertAccent#'
   elseif current_mode == 'v' or current_mode == 'V' or current_mode == '' then
      mode_color = '%#StatuslineVisualAccent#'
   elseif current_mode == 'R' then
      mode_color = '%#StatuslineReplaceAccent#'
   elseif current_mode == 'c' then
      mode_color = '%#StatuslineCmdLineAccent#'
   elseif current_mode == 't' then
      mode_color = '%#StatuslineTerminalAccent#'
   end
   return mode_color
end
vim.api.nvim_set_hl(0, 'StatusLineAccent', { fg = 'blue' })
vim.api.nvim_set_hl(0, 'StatuslineInsertAccent', { fg = 'orange' })
vim.api.nvim_set_hl(0, 'StatuslineVisualAccent', { fg = 'red' })
vim.api.nvim_set_hl(0, 'StatuslineReplaceAccent', { fg = 'pink' })
vim.api.nvim_set_hl(0, 'StatuslineCmdLineAccent', { fg = 'white' })
vim.api.nvim_set_hl(0, 'StatuslineTerminalAccent', { fg = 'black' })

component.MODES = {
   ['n'] = 'normal',
   ['no'] = 'normal',
   ['v'] = 'visual',
   ['V'] = 'visual line',
   [''] = 'visual block',
   ['s'] = 'select',
   ['S'] = 'select line',
   [''] = 'select block',
   ['i'] = 'insert',
   ['ic'] = 'insert',
   ['R'] = 'replace',
   ['Rv'] = 'visual replace',
   ['c'] = 'command',
   ['cv'] = 'vim ex',
   ['ce'] = 'ex',
   ['r'] = 'prompt',
   ['rm'] = 'moar',
   ['r?'] = 'confirm',
   ['!'] = 'shell',
   ['t'] = 'terminal',
}

function component.mode()
   local current_mode = vim.api.nvim_get_mode().mode
   -- return string.format(' %s ', component.MODES[current_mode]):upper()
   return string.format(' %s ', component.MODES[current_mode])
end

function component.lineinfo()
   if vim.bo.filetype == 'alpha' then
      return ''
   end

   return ' %P %l:%c'
end

function component.filepath()
   -- Return the filepath without the name of the file
   local fpath = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:h')
   if fpath == '' or fpath == '.' then
      return ' '
   end

   if vim.opt.filetype:get() == 'lua' then
      -- For lua use . as a separator instead of /
      local replace_fpath = string.gsub(fpath, '/', '.')
      return string.format(' %%<%s.', replace_fpath)
   end

   return string.format(' %%<%s/', fpath)
end

function component.filename()
   local fname = vim.fn.expand('%:t')
   if fname == '' then
      return ''
   end
   return fname
end

function component.vcs()
   local git_info = vim.b.gitsigns_status_dict
   if not git_info or git_info.head == '' then
      return ''
   end
   local added = git_info.added and ('%#GitSignsAdd#+' .. git_info.added .. ' ') or ''
   local changed = git_info.changed and ('%#GitSignsChange#~' .. git_info.changed .. ' ') or ''
   local removed = git_info.removed and ('%#GitSignsDelete#-' .. git_info.removed .. ' ') or ''
   if git_info.added == 0 then
      added = ''
   end
   if git_info.changed == 0 then
      changed = ''
   end
   if git_info.removed == 0 then
      removed = ''
   end
   return table.concat({
      ' ',
      added,
      changed,
      removed,
      ' ',
      '%#GitSignsAdd# ',
      git_info.head,
      ' %#Normal#',
   })
end

function statusline.init()
   vim.opt.laststatus = 3

   return table.concat({
      '%#StatusLine#',
      statusline.update_mode_colors(),
      component.mode(),
      '%#Normal#',
      component.lineinfo(),
      component.filepath(),
      '%#Function#', -- Change colors for the filename using the Function hl group
      component.filename(),
      '%#Normal#',
      '%=%', -- Put component in the right side
      component.vcs(),
   })
end

vim.opt.statusline = '%!v:lua.require("csj.core.statusline").init()'

return statusline, component
