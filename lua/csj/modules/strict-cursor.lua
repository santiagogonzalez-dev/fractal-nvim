local M = {}

function M.h_motion()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local line = cursor_position[1]
  local column = cursor_position[2]

  vim.cmd.normal('^')
  -- vim.cmd('normal ^')
  local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

  if column == 0 then
    return vim.cmd.normal('k') and vim.cmd.normal('$')
    -- return vim.cmd('normal! k') and vim.cmd('normal! $')
  elseif column <= first_non_blank_char[2] then
    return vim.api.nvim_win_set_cursor(0, { line, 0 })
  else
    return vim.api.nvim_win_set_cursor(0, { line, column - 1 })
  end
end

function M.l_motion()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local line = cursor_position[1]
  local column = cursor_position[2]

  local line_characters = vim.api.nvim_get_current_line()

  vim.cmd.normal('^')
  -- vim.cmd('normal ^')
  local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

  if column == #line_characters - 1 or #line_characters == 0 then
    return vim.cmd.normal('j') and vim.cmd.normal('0')
    -- return vim.cmd('normal! j') and vim.cmd('normal! 0')
  elseif column < first_non_blank_char[2] then
    return
  else
    return vim.api.nvim_win_set_cursor(0, { line, column + 1 })
  end
end

---@param mode boolean
function M.switcher(mode)
  if mode then
    vim.keymap.set('n', 'h', function()
      return M.h_motion()
    end)
    vim.keymap.set('n', 'l', function()
      return M.l_motion()
    end)
    vim.opt.virtualedit = ''
    vim.g.strict_cursor = false
  else
    vim.opt.virtualedit = 'all' -- Be able to put the cursor where there's not actual text
    vim.keymap.del('n', 'h')
    vim.keymap.del('n', 'l')
    vim.g.strict_cursor = true
  end
end

---@param mapping string
function M.setup(mapping)
  if type(mapping) ~= 'string' then
    return false
  end

  M.switcher(true) -- Enable strict cursor when running the function for the first time
  vim.keymap.set('n', mapping, function()
    return M.switcher(vim.g.strict_cursor)
  end, {
    desc = 'The cursor has a default stricter mode, and a secondary mode, which lets the cursor move freely',
  })
  return true
end

return M
