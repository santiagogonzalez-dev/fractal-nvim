M = {}

-- Folds text
function M.foldtext_expression()
  -- Match the characters at the start of the line
  local function starts_with(string_to_search, pattern_to_match)
    return string.sub(string_to_search, 1, string.len(pattern_to_match)) == pattern_to_match
  end

  local fold_end = function()
    local fe = vim.trim(vim.fn.getline(vim.v.foldend))
    local fae = vim.trim(vim.fn.getline(vim.v.foldend - 1))
    if starts_with(fae, 'return') then
      return ('  ' .. fae)
    elseif starts_with(fe, 'return') then
      return ('  ' .. fe)
    else
      return ''
    end
  end

  local start_line = function()
    if starts_with(vim.trim(vim.fn.getline(vim.v.foldstart)), 'import') then
      return 'imports'
    else
      return vim.fn.getline(vim.v.foldstart):gsub('\t', ('\t'):rep(vim.o.tabstop))
    end
  end
  return start_line() .. fold_end()
end

-- Close or quit buffer
M.close_or_quit = function()
  local count_bufs_by_type = function(loaded_only)
    loaded_only = (loaded_only == nil and true or loaded_only)
    local count = {
      normal = 0,
      acwrite = 0,
      help = 0,
      nofile = 0,
      nowrite = 0,
      quickfix = 0,
      terminal = 0,
      prompt = 0,
      Trouble = 0,
      NvimTree = 0,
    }
    for _, bufname in pairs(vim.api.nvim_list_bufs()) do
      if not loaded_only or vim.api.nvim_buf_is_loaded(bufname) then
        local buf_type = vim.api.nvim_buf_get_option(bufname, 'buftype')
        buf_type = buf_type ~= '' and buf_type or 'normal'
        count[buf_type] = count[buf_type] + 1
      end
    end
    return count
  end

  if count_bufs_by_type().normal <= 1 then
    vim.ui.select({ 'Delete the buffer', 'Quit neovim' }, {}, function(_, prompt)
      if tonumber(prompt) == 1 then
        return vim.cmd('bd')
      elseif tonumber(prompt) == 2 then
        return vim.cmd('q')
      end
    end)
  else
    return vim.cmd('bp | sp | bn | bd')
  end
end

-- Toggle diagnostics
vim.g.diagnostics_active = true
M.toggle_diagnostics = function()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
    vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
  else
    vim.g.diagnostics_active = true
    vim.cmd([[exe "normal ii\<Esc>x"]])
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
    })
  end
end

-- Rename
M.rename = function()
  local function post(rename_old)
    vim.cmd('stopinsert!')
    local new = vim.api.nvim_get_current_line()
    vim.schedule(function()
      vim.api.nvim_win_close(0, true)
      vim.lsp.buf.rename(vim.trim(new))
    end)
    vim.notify(rename_old .. '  ' .. new)
  end
  local rename_old = vim.fn.expand('<cword>')
  local created_buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(created_buffer, true, {
    relative = 'cursor',
    style = 'minimal',
    border = 'rounded',
    row = -3,
    col = 0,
    width = 20,
    height = 1,
  })
  vim.cmd('startinsert')

  vim.keymap.set('i', '<ESC>', function()
    vim.cmd('q')
    vim.cmd('stopinsert')
  end, { buffer = created_buffer })

  vim.keymap.set('i', '<CR>', function()
    return post(rename_old)
  end, { buffer = created_buffer })
end

-- Yanked text
M.get_yanked_text = function()
  return print(vim.fn.getreg('"'))
end

-- Swap booleans
function M.swap_bool()
  local actual_word = vim.fn.expand('<cword>')
  local suspected_line = vim.api.nvim_get_current_line()

  if actual_word:match('true') then
    local fixed_line = suspected_line:gsub('true', 'false')
    return vim.api.nvim_set_current_line(fixed_line)
  elseif actual_word:match('false') then
    local fixed_line = suspected_line:gsub('false', 'true')
    return vim.api.nvim_set_current_line(fixed_line)
  elseif actual_word:match('True') then
    local fixed_line = suspected_line:gsub('True', 'False')
    return vim.api.nvim_set_current_line(fixed_line)
  elseif actual_word:match('False') then
    local fixed_line = suspected_line:gsub('False', 'True')
    return vim.api.nvim_set_current_line(fixed_line)
  else
    vim.cmd(':norm <C-a>')
  end
end

return M
