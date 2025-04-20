_:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      if test -f $HOME/.env
        source $HOME/.env
      end

      fish_add_path -amP /usr/bin
      fish_add_path -amP /opt/homebrew/bin
      fish_add_path -m /run/current-system/sw/bin
      fish_add_path -m $HOME/.nix-profile/bin
      fish_add_path -m $HOME/.cargo/bin
    '';

    shellAliases = {
      gds = "git diff --staged";
      gd = "git diff";
      gs = "git status";
    };
  };
}
