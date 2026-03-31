#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${SKILLPULL_INSTALL_DIR:-$HOME/.local/bin}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

GREEN='\033[1;32m'; DIM='\033[2m'; RESET='\033[0m'

mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_DIR/skillpull" "$INSTALL_DIR/skillpull"
chmod +x "$INSTALL_DIR/skillpull"

printf "  ${GREEN}✓${RESET} Installed skillpull to %s\n" "$INSTALL_DIR/skillpull"

# Check if in PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
  echo "  Add to PATH: export PATH=\"$INSTALL_DIR:\$PATH\""
fi

echo ""
printf "  ${DIM}Get started:${RESET}\n"
printf "  ${DIM}  skillpull init          # Setup default skill repo${RESET}\n"
printf "  ${DIM}  skillpull --help        # See all commands${RESET}\n"
