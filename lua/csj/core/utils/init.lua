local utils = {}

-- Folds text
function utils.foldtext_expression()
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
    -- imports for most languages
    if starts_with(vim.trim(vim.fn.getline(vim.v.foldstart)), 'import') then
      return 'imports'
      -- class in python
    elseif starts_with(vim.trim(vim.fn.getline(vim.v.foldstart)), 'class ') then
      return vim.fn.getline(vim.v.foldstart):gsub('class ', '')
      -- functions in python
    elseif starts_with(vim.trim(vim.fn.getline(vim.v.foldstart)), 'def ') then
      return vim.fn.getline(vim.v.foldstart):gsub('def ', '')
    else
      return vim.fn.getline(vim.v.foldstart):gsub('\t', ('\t'):rep(vim.o.tabstop))
    end
  end
  return start_line() .. fold_end()
end

-- Close or quit buffer
function utils.close_or_quit()
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
utils.toggle_diagnostics = function()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
    vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
  else
    vim.g.diagnostics_active = true
    vim.cmd([[exe "normal ii\<Esc>x"]])
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      signs = true,
      underline = true,
      update_in_insert = false,
    })
  end
end

-- Rename
function utils.rename()
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
function utils.get_yanked_text()
  return print(vim.fn.getreg('"'))
end

-- Conditional for width of the terminal
function utils.hide_at_vp()
  return vim.opt.columns:get() > 90
end

-- Highlights
function utils.set_hl(mode, table)
  if type(mode) == 'table' then
    for _, groups in pairs(mode) do
      vim.api.nvim_set_hl(0, groups, table)
    end
  else
    vim.api.nvim_set_hl(0, mode, table)
  end
end

-- Function to setup the initial load and maintain some settings between buffers
function utils.setup_session(optional_settings)
  vim.opt.shadafile = ''
  vim.cmd('rshada!')

  vim.api.nvim_create_augroup('_save_sessions', { clear = true })
  vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Open file at the last position it was edited earlier',
    group = '_save_sessions',
    callback = function()
      if vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf()) then
        if not vim.tbl_contains({ 'gitcommit', 'help', 'packer', 'toggleterm' }, vim.bo.ft) then
          -- Check if mark `"` is inside the current file (can be false if at end of file and stuff got deleted outside
          -- neovim) if it is go to it
          -- TODO use lua in here
          vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]])
          local cursor = vim.api.nvim_win_get_cursor(0) -- Get cursor position
          if vim.fn.foldclosed(cursor[1]) ~= -1 then -- If there are folds under the cursor open them
            vim.cmd('silent normal! zO')
          end
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd('BufWinLeave', {
    desc = 'Save the view of the buffer',
    group = '_save_sessions',
    callback = function()
      return vim.cmd('silent! mkview')
    end,
  })

  vim.api.nvim_create_autocmd('BufWinEnter', {
    desc = 'Load the view of the buffer',
    group = '_save_sessions',
    callback = function()
      return vim.cmd('silent! loadview')
    end,
  })

  -- Deferred load
  local function load_settings()
    vim.api.nvim_create_autocmd('BufWinEnter', {
      group = '_save_sessions',
      desc = 'Persistent configs for all buffers',
      callback = function()
        optional_settings()
      end,
    })
    optional_settings()
  end

  vim.api.nvim_create_autocmd('UIEnter', {
    group = '_first_load',
    once = true,
    callback = function()
      return vim.defer_fn(load_settings, 60)
    end,
  })
end

-- -- Git project or not
-- -- TODO finish this
-- function utils.inside_git_project()
--   local val = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
--   if val:match('true') then
--     return true
--   else
--     return false
--   end
-- end

-- vim.api.nvim_create_augroup('project_git', {})
-- vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
--   group = 'project_git',
--   callback = function ()
--     if utils.inside_git_project() then
--       vim.api.nvim_exec_autocmd()
--     end
--   end,
-- })

return utils
