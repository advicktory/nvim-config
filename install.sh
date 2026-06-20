#!/bin/bash
# install.sh — nvim config (standalone)
# Only installs if ~/.config/nvim doesn't exist yet.
# To force reinstall: delete ~/.config/nvim first.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${HOME}/.config/nvim"

if [ -d "$TARGET" ] && [ -f "$TARGET/init.lua" ]; then
  echo "🌿  nvim config already exists — skipped (delete ~/.config/nvim to reinstall)"
  exit 0
fi

echo "🌿  nvim config → ~/.config/nvim"
[ -e "$TARGET" ] && mv "$TARGET" "${TARGET}.bak-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$TARGET"
cp -r "$DIR"/init.lua "$DIR"/lazy-lock.json "$DIR"/lua "$DIR"/colors "$DIR"/flake.nix "$DIR"/flake.lock "$TARGET"/
echo "   done"
echo "   Next: launch nvim — plugins will auto-install via lazy.nvim"
