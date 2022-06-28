require('csj.core')

-- TODO(santigo-zero):
-- * Folds are getting shifted down one line after formatting (null-ls and lsp)
--
-- * ci( and ci) should work normally, and  c( and c) should work line wise
-- The same goes for di( and di) and d( and d). Also maintain the column when pasting
--
-- * vim.keymap.set('n', 'c)', 'ci)', { desc = 'c} does the same and I prefer using it'})
-- vim.keymap.set('n', 'c(', 'ci(', { desc = 'c{ does the same and I prefer using it'})
--
-- * A better f t F T, also change in "
-- * Settings do not get applied (till using netrw, telescope and other plugins) when opening certain files :e.g .gitignore
