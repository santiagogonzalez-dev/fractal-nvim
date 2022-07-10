local function h_motion()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local line = cursor_position[1]
  local column = cursor_position[2]

  vim.cmd('normal ^')
  local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

  if column == 0 then
    return vim.cmd('normal! k') and vim.cmd('normal! $')
  elseif column <= first_non_blank_char[2] then
    return vim.api.nvim_win_set_cursor(0, { line, 0 })
  else
    return vim.api.nvim_win_set_cursor(0, { line, column - 1 })
  end
end

local function l_motion()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local line = cursor_position[1]
  local column = cursor_position[2]

  local line_characters = vim.api.nvim_get_current_line()

  vim.cmd('normal ^')
  local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

  if column == #line_characters - 1 or #line_characters == 0 then
    return vim.cmd('normal! j') and vim.cmd('normal! 0')
  elseif column < first_non_blank_char[2] then
    return
  else
    return vim.api.nvim_win_set_cursor(0, { line, column + 1 })
  end
end

---@param mode boolean
local function switcher(mode)
  if mode then
    vim.keymap.set('n', 'h', function() return h_motion() end)
    vim.keymap.set('n', 'l', function() return l_motion() end)
    vim.opt.virtualedit = ''
    vim.g.strict_cursor = false
  else
    vim.opt.virtualedit = 'all' -- Be able to put the cursor where there's not actual text
    vim.keymap.del('n', 'h')
    vim.keymap.del('n', 'l')
    vim.g.strict_cursor = true
  end
end

switcher(true) -- Enable strict cursor when running the function for the first time
vim.keymap.set('n', '<Esc><Esc>', function() return switcher(vim.g.strict_cursor) end, {
  desc = 'Add a second mode for the cursor, which either restricts or lets the cursor move freely',
})
