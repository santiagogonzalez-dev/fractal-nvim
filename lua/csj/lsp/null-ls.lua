local ok, null = pcall(require, 'null-ls')
if not ok then return end

local format = null.builtins.formatting
local diag = null.builtins.diagnostics
local actions = null.builtins.code_actions
local completion = null.builtins.completion

null.setup {
  sources = {
    actions.gitsigns,
    actions.eslint,
    diag.eslint,
    actions.shellcheck,
    diag.shellcheck,
    format.stylua,
    format.prettier.with {
      prefer_local = 'node_modules/.bin',
      command = 'prettier',
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
        'css',
        'scss',
        'html',
        'json',
        'jsonc',
        'yaml',
        'markdown',
        'graphql',
        'handlebars',
      },
      extra_args = {
        '--no-semi',
        '--single-quote',
        '--jsx-single-quote',
        -- '--tab-width',
        -- '4',
        '--print-width',
        '80',
      },
    },
    format.black.with {
      prefer_local = '.venv/bin',
      extra_args = {
        '--fast',
        '--quiet',
        -- '--skip-string-normalization',
        -- '--line-length',
        -- '88',
        '--target-version',
        'py310',
      },
    },
    diag.flake8.with {
      prefer_local = '.venv/bin',
      extra_args = { '--max-line-lenth', '88' },
    },
    diag.eslint,
    completion.spell,
  },
}
