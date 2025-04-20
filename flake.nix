{
  description = "Nix configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Neovim nightly overlay
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, flake-utils, nixpkgs, nix-darwin, neovim-nightly-overlay, ... }:
  let
    # オーバーレイを明確に定義
    overlays = [
      # neovim-nightly-overlayのoverlayが正しく参照されていることを確認
      (final: prev: {
        neovim = neovim-nightly-overlay.overlay final prev;
      })
    ];

    # システム設定の共通設定
    nixpkgsConfig = {
      inherit overlays;
      config.allowUnfree = true;
    };
  in {
    # Darwin設定を明確に定義
    darwinConfigurations =
      let
        inherit (nix-darwin.lib) darwinSystem;
      in {
        "wtnqk" = darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            inputs.nix-homebrew.darwinModules.nix-homebrew
            inputs.home-manager.darwinModules.home-manager
            ./nix/hosts/mbp/configuration.nix
            {
              nixpkgs = nixpkgsConfig;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.wtnqk = import ./nix/home/home.nix;
            }
          ];
        };
      };

    # システム出力を明示的に追加
    darwinPackages = self.darwinConfigurations.wtnqk.system;
  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays;
      };
    in {
      # packagesを具体的なパッケージマップに変更
      packages = {
        default = pkgs.nil;  # デフォルトパッケージを指定
        nil = pkgs.nil;
        statix = pkgs.statix;
        nixpkgs-fmt = pkgs.nixpkgs-fmt;
      };

      devShell = with pkgs; mkShell {
        buildInputs = [
          nil
          statix
          nixpkgs-fmt
        ];
      };
    }
  );
}
