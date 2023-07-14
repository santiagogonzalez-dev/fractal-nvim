require("user")

local ROOT = vim.fn.stdpath("config")
package.path = table.concat({
	package.path,
	";",
	ROOT,
	"/fractal/?.lua;",
	ROOT,
	"/fractal/?/init.lua;",
})

dofile(ROOT .. "/fractal/init.lua")

--  TODO(santigo-zero):
--    Enable null-ls modules depending if the project is using it
--    Fix jetjbp color palette, add light theme
--    Make the columnline fit the formatter
--    Simplify neovim config, don't lazy load, optimize later, but do modularize
--       more if necessary
--    Try making .sh files created with a skeleton executable on the same action
--    Move fractal files to ./fractal and move ./user files to ./lua
--    Extend dd, with dD key mapping, or removing empty lines at EOF
