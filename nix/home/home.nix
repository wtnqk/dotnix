{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    monaspace
    curl
    coreutils
    jq
    ripgrep
    fd
    age
    ngrok
  ];

  imports = [
    ./zsh.nix
    ./fish.nix
    # ./git.nix
    # ./ssh.nix
    ./vscode.nix
    ./nvim.nix
  ];

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv.enable = true;
}
