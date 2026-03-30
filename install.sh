#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${SKILLPULL_INSTALL_DIR:-$HOME/.local/bin}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config/skillpull"
CONFIG_FILE="$CONFIG_DIR/config.json"

GREEN='\033[1;32m'; CYAN='\033[1;36m'; DIM='\033[2m'; RESET='\033[0m'

mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_DIR/skillpull" "$INSTALL_DIR/skillpull"
chmod +x "$INSTALL_DIR/skillpull"

printf "  ${GREEN}✓${RESET} Installed skillpull to %s\n" "$INSTALL_DIR/skillpull"

# Check if in PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
  echo "  Add to PATH: export PATH=\"$INSTALL_DIR:\$PATH\""
fi

# ── Setup default skill repository ──
echo ""
printf "  ${CYAN}Set up a default skill repository?${RESET}\n"
printf "  ${DIM}This lets you run 'skillpull <skill-name>' without typing the full URL.${RESET}\n"
printf "  ${DIM}Supports: user/repo, full URL, or leave blank to skip.${RESET}\n"
echo ""
printf "  Skill repo: "
read -r repo_input

if [[ -n "$repo_input" ]]; then
  # Resolve shortname to full URL
  resolved="$repo_input"
  if [[ "$repo_input" != *"://"* && "$repo_input" != git@* ]]; then
    if [[ "$repo_input" == */* && "$(echo "$repo_input" | tr -cd '/' | wc -c)" == "1" ]]; then
      resolved="https://github.com/${repo_input}.git"
    fi
  fi

  mkdir -p "$CONFIG_DIR"
  if [[ -f "$CONFIG_FILE" ]]; then
    sed -i "s|\"registry\":\"[^\"]*\"|\"registry\":\"${resolved}\"|" "$CONFIG_FILE"
  else
    echo "{\"aliases\":{},\"registry\":\"${resolved}\"}" > "$CONFIG_FILE"
  fi

  printf "  ${GREEN}✓${RESET} Default registry set to: %s\n" "$resolved"
  printf "  ${DIM}Now you can run: skillpull <skill-name>${RESET}\n"
else
  printf "  ${DIM}Skipped. You can set it later: skillpull registry <user/repo>${RESET}\n"
fi

echo ""
printf "  ${GREEN}Done!${RESET} Run 'skillpull --help' to get started.\n"
