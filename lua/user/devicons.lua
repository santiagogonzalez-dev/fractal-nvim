local M = {
	"nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
}

function M.config()
	local config = require("nvim-web-devicons")

	config.set_icon({
		astro = {
			--  󱓟 
			icon = "󱓞",
			color = "#FF7E33",
			name = "astro",
		},
	})
end

return M
