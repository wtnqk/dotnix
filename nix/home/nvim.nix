{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [
      tree-sitter

      nil
      nixpkgs-fmt

      ripgrep
      fd
    ];
  };

  xdg.configFile.nvim = {
    source = ../../nvim;
    recursive = true;
  };
}
