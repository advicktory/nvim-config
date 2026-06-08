# flake.nix — Neovim config as a Nix package
#
# Build:    nix build
# Try:      nix run
# Install:  nix profile install
#
# Everyone who runs this gets:
#   - Neovim 0.12+
#   - All plugins pinned via lazy-lock.json
#   - Moss theme + two alternates + Colemak keymaps
#   - tree-sitter CLI, curl, tar (for compiling parsers)
#   - LSP servers NOT included (managed by Mason at first launch)
#   - Zero global installs, nothing in ~/.config
{
  description = "Neovim configuration with moss theme, Colemak keymaps, and full IDE setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "aarch64-darwin";  # or "x86_64-linux", "x86_64-darwin"
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system} = {
      # ── Just the config files (use with your own Neovim) ──
      config = pkgs.stdenv.mkDerivation {
        name = "nvim-moss-config";
        src = ./.;
        installPhase = ''
          mkdir -p $out
          cp init.lua $out/
          cp lazy-lock.json $out/
          cp -r lua/ $out/
          cp -r colors/ $out/
        '';
      };

      # ── Full Neovim wrapper (config + binary + build tools) ──
      default = pkgs.writeShellScriptBin "nvim-moss" ''
        # Create a temp config directory (isolated, doesn't touch real ~/.config)
        CONFIG_DIR=$(mktemp -d)
        trap 'rm -rf $CONFIG_DIR' EXIT

        # Copy config files into place
        mkdir -p $CONFIG_DIR/nvim
        cp ${self.packages.${system}.config}/* $CONFIG_DIR/nvim/
        cp -r ${self.packages.${system}.config}/lua $CONFIG_DIR/nvim/
        cp -r ${self.packages.${system}.config}/colors $CONFIG_DIR/nvim/

        # Provide build tools for treesitter parsers
        export PATH="${pkgs.nodePackages.tree-sitter-cli}/bin:${pkgs.curl}/bin:${pkgs.gnutar}/bin:$PATH"

        # Launch Neovim with our config
        XDG_CONFIG_HOME=$CONFIG_DIR ${pkgs.neovim}/bin/nvim "$@"
      '';
    };

    # ── Optional: NixOS module ──
    nixosModules.default = { config, lib, pkgs, ... }: {
      options.programs.nvim-moss = {
        enable = lib.mkEnableOption "Neovim with moss theme and Colemak keymaps";
      };
      config = lib.mkIf config.programs.nvim-moss.enable {
        environment.systemPackages = [
          self.packages.${system}.default
          pkgs.nodePackages.tree-sitter-cli
        ];
      };
    };
  };
}
