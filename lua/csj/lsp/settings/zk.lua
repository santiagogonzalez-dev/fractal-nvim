local root_pattern = require('lspconfig/util').root_pattern

return {
    root_dir = root_pattern({
        '.git',
        '.zk',
    }),
}
