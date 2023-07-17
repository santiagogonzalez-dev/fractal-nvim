local M = {
	"NvChad/nvim-colorizer.lua",
	event = "VeryLazy",
}

function M.config()
	require("colorizer").setup({
		filetypes = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"svelte",
			"css",
			"html",
			"astro",
			"lua",
		},
		user_default_options = {
			names = false,
			mode = "virtualtext",
			virtualtext = "██",
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = true, -- 0xAARRGGBB hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true,
			tailwind = "both",
			always_update = true,
		},
	})
end

return M
