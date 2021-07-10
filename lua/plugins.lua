return require("packer").startup(function(use)
  -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"
    use "drewtempelmeyer/palenight.vim"
    use "ghifarit53/tokyonight-vim"
end)
