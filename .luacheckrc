stds.nvim = {
	globals = {
		vim = { fields = { "g", "opt" } },
		map = { fields = { "function" } },
		bit = { fields = { "band" } },
		LAZY_PLUGIN_SPEC = { fields = { "variable" } },
		spec = { fields = { "variable" } },
	},
	read_globals = {
		"vim",
		"map",
		"jit",
	},
}
std = "lua51+nvim"

ignore = {
	"212/_.*", -- unused argument, for vars with "_" prefix
}
