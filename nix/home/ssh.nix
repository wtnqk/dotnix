_:
{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      AddKeysToAgent yes
      ServerAliveInterval 60
    '';
    "*" = {
      identityFile = "~/.ssh/id_ed25519";
      addKeysToAgent = "yes";
    };

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_key";
      };

      "server" = {
        hostname = "example.com";
        user = "username";
        port = 2222;
        identityFile = "~/.ssh/server_key";
      };

      "jump-host" = {
        hostname = "jumphost.example.com";
        user = "jump_user";
        identityFile = "~/.ssh/server_key";
      };

      "internal-server" = {
        hostname = "internal.example.com";
        user = "internal_user";
        proxyJump = "jump-host";
        identityFile = "~/.ssh/server_key";
      };
    };
  };
}
