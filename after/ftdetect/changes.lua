vim.filetype.add({
	extension = {
		conf = 'dosini',
		dirs = 'dosini',
		dosinit = 'conf',
		postcss = 'css',
	},
	filename = {
		['package.json'] = 'jsonc',
		['tsconfig.json'] = 'jsonc',

		['.prettierignore'] = 'dosini',
	},
})
