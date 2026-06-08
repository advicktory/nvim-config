# flake.nix — Neovim config as a Nix package (cross-platform)
# nix run .          → sandboxed, temporary
# nix profile install → permanent, bootstraps ~/.config/nvim
{
  description = "Neovim config: moss theme + Colemak keymaps + LSP + treesitter";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
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
        default = pkgs.writeShellScriptBin "nvim" ''
          # nix run → sandboxed (runs from store path)
          # nix profile install → bootstraps ~/.config (runs from profile symlink)
          if echo "$0" | grep -q "/nix/var/nix/profiles/"; then
            mkdir -p ~/.config/nvim
            cp -r ${config}/* ~/.config/nvim/
          else
            DIR=$(mktemp -d); trap 'rm -rf $DIR' EXIT
            mkdir -p $DIR/nvim
            cp -r ${config}/* $DIR/nvim/
            export XDG_CONFIG_HOME=$DIR
          fi
          export PATH="${pkgs.tree-sitter}/bin:${pkgs.ripgrep}/bin:${pkgs.fd}/bin:${pkgs.git}/bin:${pkgs.curl}/bin:${pkgs.gnutar}/bin:${pkgs.stdenv.cc}/bin:$PATH"
          exec ${pkgs.neovim}/bin/nvim "$@"
        '';
      });
    };
}
