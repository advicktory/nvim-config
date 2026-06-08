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
          # If moss isn't installed yet, auto-install to ~/.config/nvim
          if [ ! -f ~/.config/nvim/init.lua ] || ! grep -q "moss" ~/.config/nvim/init.lua 2>/dev/null; then
            echo "First run: installing moss config..."
            mkdir -p ~/.config/nvim
            cp ${config}/* ~/.config/nvim/
            cp -r ${config}/lua ${config}/colors ~/.config/nvim/
          fi
          exec ${pkgs.neovim}/bin/nvim "$@"
        '';
      });
    };
}
