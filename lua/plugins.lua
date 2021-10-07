return require('packer').startup(function()
    -- Impatient
    use { "lewis6991/impatient.nvim" }

    use { "wbthomason/packer.nvim" }

    -- Comments
    use { "terrortylor/nvim-comment", config = function() require("nvim_comment").setup() end }

    -- Autopairs
    use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end }

    -- Colorschemes
    use { "folke/tokyonight.nvim" }

    config = {
        compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
    }
end)
