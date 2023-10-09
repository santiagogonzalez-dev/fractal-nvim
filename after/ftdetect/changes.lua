vim.filetype.add({
	extension = {
		wgsl = "wgsl",
		conf = "dosini",
		config = "dosini",
		dirs = "dosini",
		profile = "dosini",
		dosinit = "conf",
		postcss = "css",
	},
	filename = {
		["package.json"] = "jsonc",
		["tsconfig.json"] = "jsonc",

		[".prettierignore"] = "dosini",
	},
})
