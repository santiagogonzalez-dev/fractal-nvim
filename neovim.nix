# Neovim
{pkgs , ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    # vimAlias = true;
    # configure = {
    #   packages.nix.start = with pkgs; [
    #     stylua
    #   ];
    # };
    package = pkgs.neovim-unwrapped;
  };

  # Install the packages globally to avoid problems
  environment = {
    systemPackages = with pkgs; [
      neovim

      # Formatters & linters
      black
      nodePackages.prettier
      python310Packages.flake8
      shellcheck
      stylua

      # Language servers
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.pyright
      nodePackages.typescript-language-server
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.yaml-language-server
      sumneko-lua-language-server
    ];
  };
}
