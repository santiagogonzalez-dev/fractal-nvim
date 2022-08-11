local utils = require('csj.core.utils')
local component = {}

function component.input()
  local res = vim.fn.searchcount()

  if res.total ~= vim.empty_dict() and res.total > 0 then
    return string.format('%s/%d %s ', res.current, res.total, vim.fn.getreg('/'))
  else
    return ' '
  end
end

function component.vcs()
  -- Requires gitsigns.nvim
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == '' then
    return ''
  end

  vim.api.nvim_set_hl(
    0,
    'StatusLineGitSignsAdd',
    { bg = utils.get_bg_hl('StatusLine'), fg = utils.get_fg_hl('GitSignsAdd') }
  )
  vim.api.nvim_set_hl(0, 'StatusLineGitSignsChange', {
    bg = utils.get_bg_hl('StatusLine'),
    fg = utils.get_fg_hl('GitSignsChange'),
  })
  vim.api.nvim_set_hl(0, 'StatusLineGitSignsDelete', {
    bg = utils.get_bg_hl('StatusLine'),
    fg = utils.get_fg_hl('GitSignsDelete'),
  })
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
  }
end

function component.lineinfo()
  -- Composition of other components
  return table.concat {
    '%l',
    -- ^^ equivalent to tonumber(vim.api.nvim_eval_statusline('%l', {}).str)
    -- or vim.fn.line('.')
    component.position_icon(),
    component.column_cursor(),
  }
end

function component.position_icon()
  -- Icon representing the line number position
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$') -- == tonumber(vim.api.nvim_eval_statusline('%L', {}).str)

  if vim.api.nvim_eval_statusline('%P', {}).str == 'All' then
    return ''
  elseif current_line == 1 then
    return ''
  end

  local chars = { '', '', '' }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

function component.column_cursor()
  -- Represent cursor column and lenght of the line
  local line_lenght = vim.fn.col('$') - 1
  local cursor_column = vim.fn.col('.') -- == tonumber(vim.api.nvim_eval_statusline('%c', {}).str)

  if line_lenght == cursor_column then
    return cursor_column, '␊'
  elseif line_lenght == 0 then
    return ''
  else
    return cursor_column, '↲', line_lenght
  end
end

function component.filewritable()
  local fmode = vim.fn.filewritable(vim.fn.expand('%:F'))
  if fmode == 0 then
    return ' '
  elseif fmode == 1 then
    local show_sign = false
    return show_sign and '' or ' '
    -- elseif fmode == 2 then
    --    return ' '
  end
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
