#!/bin/bash
# install.sh — nvim config (standalone, no brew/nix needed)
# Copies files into ~/.config/nvim (not symlink — nvim writes lazy-lock.json at runtime)
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${HOME}/.config/nvim"

echo "🌿  nvim config → ~/.config/nvim"

# Backup existing
if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
  mv "$TARGET" "${TARGET}.bak-$(date +%Y%m%d-%H%M%S)"
elif [ -L "$TARGET" ]; then
  rm "$TARGET"
fi

# Copy (not symlink — nvim modifies files in-place)
mkdir -p "$TARGET"
cp -r "$DIR"/init.lua "$DIR"/lazy-lock.json "$DIR"/lua "$DIR"/colors "$DIR"/flake.nix "$DIR"/flake.lock "$TARGET"/
echo "   done"
echo ""
echo "   Next: launch nvim — plugins will auto-install via lazy.nvim"
