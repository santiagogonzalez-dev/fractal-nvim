local M = {
	"jose-elias-alvarez/null-ls.nvim",
}

function M.config()
	local null = require("null-ls")

	local format = null.builtins.formatting
	local diag = null.builtins.diagnostics
	local actions = null.builtins.code_actions

	null.setup({
		sources = {
			actions.gitsigns,
			diag.eslint,
			actions.shellcheck,
			diag.shellcheck,
			diag.luacheck,
			format.stylua,
			format.prettier.with({
				prefer_local = "node_modules/.bin",
				command = "prettier",
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"css",
					"scss",
					"html",
					"json",
					"jsonc",
					"yaml",
					"markdown",
					"graphql",
					"handlebars",
				},
			}),
			format.black.with({
				prefer_local = ".venv/bin",
				extra_args = {
					"--fast",
					"--quiet",
					-- '--skip-string-normalization',
					-- "--line-length",
					-- "88",
					-- "--target-version",
					-- "py310",
				},
			}),
			diag.flake8.with({
				prefer_local = ".venv/bin",
				-- extra_args = { "--max-line-lenth", "88" },
			}),
		},
	})
end

return M
