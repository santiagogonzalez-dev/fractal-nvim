return require('packer').startup(function()
    use { "wbthomason/packer.nvim" }

    -- Comments
    use { "terrortylor/nvim-comment", config = function() require("nvim_comment").setup() end }

    -- Autopairs
    use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end }
end)
