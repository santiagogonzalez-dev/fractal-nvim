local status_ok, gitsigns = pcall(require, 'gitsigns')
if not status_ok then
   return
end

gitsigns.setup({
   signs = {
      add = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
      change = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      delete = { hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      topdelete = {
         hl = 'GitSignsDelete',
         text = '契',
         numhl = 'GitSignsDeleteNr',
         linehl = 'GitSignsDeleteLn',
      },
      changedelete = {
         hl = 'GitSignsChange',
         text = '~',
         numhl = 'GitSignsChangeNr',
         linehl = 'GitSignsChangeLn',
      },
   },
   signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
   numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
   linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
   word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
   watch_gitdir = {
      interval = 3000,
      follow_files = true,
   },
   attach_to_untracked = true,
   current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
   current_line_blame_opts = { virt_text = false },
   current_line_blame_formatter_opts = { relative_time = true },
   sign_priority = 6,
   update_debounce = 300,
   status_formatter = nil, -- Use default
   max_file_length = 90000,
   preview_config = {
      -- Options passed to nvim_open_win
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
   },
   yadm = { enable = false },
   on_attach = function(bufnr)
      -- local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
         opts = opts or {}
         opts.buffer = bufnr
         vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
         if vim.wo.diff then
            return ']c'
         end
         vim.schedule(function()
            gitsigns.next_hunk()
         end)
         return '<Ignore>'
      end, { expr = true })

      map('n', '[c', function()
         if vim.wo.diff then
            return '[c'
         end
         vim.schedule(function()
            gitsigns.prev_hunk()
         end)
         return '<Ignore>'
      end, { expr = true })

      -- Actions
      map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hu', gitsigns.undo_stage_hunk)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hp', gitsigns.preview_hunk)
      map('n', '<leader>hb', function()
         gitsigns.blame_line({ full = true })
      end)
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      map('n', '<leader>hd', gitsigns.diffthis)
      map('n', '<leader>hD', function()
         gitsigns.diffthis('~')
      end)
      map('n', '<leader>td', gitsigns.toggle_deleted)

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

      map('n', 'ghr', gitsigns.reset_hunk)
      map('n', 'ghb', gitsigns.reset_buffer)
      map('n', 'ghj', gitsigns.next_hunk)
      map('n', 'ghk', gitsigns.prev_hunk)
      map('n', 'ghp', gitsigns.preview_hunk)
   end,
})
return gitsigns
