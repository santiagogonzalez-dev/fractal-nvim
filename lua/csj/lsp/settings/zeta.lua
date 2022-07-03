local root_pattern = require('lspconfig/util').root_pattern

return {
  single_file_support = true,
  root_dir = root_pattern('.git', 'slip_box.db', '0.md'),
  settings = {
    markdown = {},
  },
}
