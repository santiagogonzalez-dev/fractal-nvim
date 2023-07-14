return {
	single_file_support = true,
	-- cmd = { 'vscode-html-language-server', '--stdio' },
	-- cmd = { 'html-languageserver', '--stdio' },
	settings = {},
	init_options = {
		configurationSection = { "svelte", "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
			svelte = true,
		},
		provideFormatter = true,
	},

	filetypes = {
		"svelte",
	},
}
