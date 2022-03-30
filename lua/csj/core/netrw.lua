vim.g.netrw_banner = 0 -- Disable the banner
vim.g.netrw_keepdir = 0 -- Keep the current directory and the browsing directory synced.
vim.g.netrw_sort_sequence = [[[\/]$,*]] -- Show directories first (sorting)
vim.g.netrw_sizestyle = 'H' -- Human-readable files sizes
vim.g.netrw_liststyle = 3 -- Tree view
vim.g.netrw_hide = 0 -- Show hidden files
vim.g.netrw_preview = 1 -- Preview files in a vertical split window
vim.g.netrw_browsex_viewer='setsid xdg-open' --  'open'

-- Patterns for hiding files, e.g. node_modules
-- NOTE: this works by reading '.gitignore' file
vim.g.netrw_list_hide = vim.fn['netrw_gitignore#Hide']()

-- Open files in split
-- 0 : re-use the same window (default)
-- 1 : horizontally splitting the window first
-- 2 : vertically   splitting the window first
-- 3 : open file in new tab
-- 4 : act like "P" (ie. open previous window)
vim.g.netrw_browse_split = 4
