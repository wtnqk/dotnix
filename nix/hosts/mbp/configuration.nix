{ pkgs, ... }:
{
  system.stateVersion = 5;
  imports = [
    ./homebrew.nix
    ./setting.nix
  ];
  environment.shells = with pkgs; [ fish zsh ];
  programs.fish.enable = true;
  users.users.wtnqk = {
    home = "/Users/wtnqk";
    shell = pkgs.fish;
  };
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
}
