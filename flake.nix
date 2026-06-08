# flake.nix — Neovim config as a Nix package (cross-platform)
# nix run .   |   nix run github:you/nvim-config   |   nix profile install .
{
  description = "Neovim config: moss theme + Colemak keymaps + LSP + treesitter";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      # Support all common systems
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in {
      packages = forAllSystems (pkgs: let
        config = pkgs.stdenv.mkDerivation {
          name = "nvim-moss-config";
          src = ./.;
          installPhase = ''
            mkdir -p $out
            cp init.lua lazy-lock.json $out/
            cp -r lua/ colors/ $out/
          '';
        };
      in {
        inherit config;
        default = pkgs.writeShellScriptBin "nvim-moss" ''
          # nix run → sandboxed temp directory
          DIR=$(mktemp -d); trap 'rm -rf $DIR' EXIT
          mkdir -p $DIR/nvim
          cp ${config}/* $DIR/nvim/
          cp -r ${config}/lua ${config}/colors $DIR/nvim/
          export PATH="${pkgs.curl}/bin:${pkgs.gnutar}/bin:$PATH"
          XDG_CONFIG_HOME=$DIR ${pkgs.neovim}/bin/nvim "$@"
        '';
        install = pkgs.writeShellScriptBin "nvim-moss-install" ''
          mkdir -p ~/.config/nvim
          cp ${config}/* ~/.config/nvim/
          cp -r ${config}/lua ${config}/colors ~/.config/nvim/
          echo "Moss config installed to ~/.config/nvim"
        '';
      });
    };
}
