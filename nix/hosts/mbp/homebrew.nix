{ pkgs, ... }:
{
  nix-homebrew = {
    enable = true;
    user = "wtnqk";
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    brews = [
      "biome"
      "fzf"
      "gh"
      "lazygit"
      "mise"
      "openssl@3"
      "pnpm"
      "starship"
      "sops"
      "age"
      "bottom"
      "bat"
    ];
    casks = [
      "firefox"
      "google-chrome"
      "orbstack"
      "raycast"
      "claude"
      "beekeeper-studio"
      "spotify"
      "ghostty"
    ];
  };
}
