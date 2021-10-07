return require('packer').startup(function()
    use { "wbthomason/packer.nvim" }

    -- Impatient
    use { "lewis6991/impatient.nvim" }
    config = {
    -- Move to loa dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
    }

    -- Comments
    use { "terrortylor/nvim-comment", config = function() require("nvim_comment").setup() end }

    -- Autopairs
    use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end }

end)
