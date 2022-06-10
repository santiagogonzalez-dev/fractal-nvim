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
    #     black
    #     nodePackages.bash-language-server
    #     nodePackages.dockerfile-language-server-nodejs
    #     nodePackages.prettier
    #     nodePackages.pyright
    #     nodePackages.typescript-language-server
    #     nodePackages.vscode-css-languageserver-bin
    #     nodePackages.vscode-html-languageserver-bin
    #     nodePackages.vscode-json-languageserver-bin
    #     nodePackages.yaml-language-server
    #     python310
    #     python310Packages.flake8
    #     shellcheck
    #     stylua
    #   ];
    # };
    package = pkgs.neovim-unwrapped;
  };

  # Install the packages globally to avoid problems
  environment = {
    systemPackages = with pkgs; [
      black
      neovim
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.prettier
      nodePackages.pyright
      nodePackages.typescript-language-server
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.yaml-language-server
      python310
      python310Packages.flake8
      shellcheck
      stylua
      sumneko-lua-language-server
    ];
  };
}
