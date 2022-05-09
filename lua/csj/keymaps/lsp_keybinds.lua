local utils = require('csj.utils')

vim.keymap.set({ 'n', 'v', 'x' }, '<Leader>ls', function()
    return vim.lsp.stop_client(vim.lsp.get_active_clients())
end, { desc = 'Stop the LS' })

vim.keymap.set({ 'v', 'x' }, '<Leader>ca', ':lua vim.lsp.buf.range_code_action()<CR>', { desc = 'Range code actions' })
vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Formatting
vim.keymap.set('n', '<Leader><Leader>f', vim.lsp.buf.formatting, { desc = 'Formatting the file' })
vim.keymap.set({ 'v', 'x' }, '<Leader><Leader>f', ':lua vim.lsp.buf.range_formatting()<CR>', { desc = 'Range formatting the file' })
vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting_sync, {})

vim.keymap.set('n', '<Leader>d', vim.diagnostic.setqflist, { desc = 'Show all diagnostics' })

vim.keymap.set('n', 'gll', function()
    -- If there is not a floating window present
    if utils.not_interfere_on_float() then
        -- Then try to open the diagnostics under the cursor
        local diags = vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
        if not diags then
            -- If there is not a diagnostic strictly under the cursor show diagnostics of the entire line
            vim.diagnostic.open_float()
        end
        return diags
    end
end, { desc = 'Show diagnostics in a float window' })

vim.keymap.set('n', 'gl', function()
    return utils.not_interfere_on_float() and vim.lsp.buf.hover()
end, { desc = 'Show a description of the word under cursor' })

vim.keymap.set('n', '<C-]>', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<C-[>', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', '<Leader>ld', require('csj.utils').toggle_diagnostics, { desc = 'Toggle diagnostics' })
vim.keymap.set('n', 'r', require('csj.utils').rename, { desc = 'Renamer' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Definitions' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Declarations' })
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references) -- References
