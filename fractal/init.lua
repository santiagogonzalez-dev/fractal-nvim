local ROOT = vim.fn.stdpath("config")
package.path = table.concat({
	package.path,
	";",
	ROOT,
	"/fractal/?.lua;",
	ROOT,
	"/fractal/?/init.lua;",
})

require("user")
require("fractal")
