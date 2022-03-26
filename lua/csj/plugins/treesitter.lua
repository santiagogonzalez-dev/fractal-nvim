local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

treesitter.setup {
  -- ensure_installed = 'maintained',
  ensure_installed = {
    'css',
    'haskell',
    'html',
    'java',
    'javascript',
    'lua',
    'markdown',
    'python',
    'tsx',
    'typescript',
    'vim',
  },
  sync_install = false,
  highlight = {
    enable = true,
    aditional_vim_regex_highlighting = false,
    disable = { 'latex' },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = true,
  },
  indent = {
    enable = true,
    disable = { 'yaml' },
  },
  autopairs = { enable = true },
  autotag = {
    enable = true,
    filetypes = {
      'css',
      'html',
      'javascript',
      'javascriptreact',
      'markdown',
      'svelte',
      'typescript',
      'typescriptreact',
      'vue',
      'xhtml',
      'xml',
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    colors = {
      '#31748f',
      '#908caa',
      '#c4a7e7',
      '#f6c177',
      '#9ccfd8',
      '#eb6f92',
      '#ebbcba',
    },
  },
}
